#!/usr/bin/env python3

import cairo
import json5
import os
import argparse
import re
import subprocess

DOTS_PER_INCH = 72
slack = 0.8


def mm_to_pt(n):
    return n/25.4 * DOTS_PER_INCH


class CounterBox:
    def __init__(self, boxtype, size, thick, counters, label):
        self.size = size
        self.thick = thick
        self.counters = counters
        self.boxtype = boxtype
        self.height = 0
        self.skipcase = False
        self.cards = False
        w = 0
        for c in range(0, len(self.counters)):
            w += self.counters[c] * self.thick
            if c != 0:
                w += 1
            if c != len(self.counters)-1:
                w += 1 + slack
        self.total_width = w
        self.label = label

    def draw(self, context):
        context.save()
        x, y = context.get_current_point()
        context.show_text(self.label)
        y += context.text_extents(self.label).height + mm_to_pt(1)
        context.move_to(x, y)
        context.line_to(x+mm_to_pt(self.total_width), y)
        context.line_to(x+mm_to_pt(self.total_width), y+mm_to_pt(self.size+4))
        context.line_to(x, y+mm_to_pt(self.size+4))
        context.line_to(x, y)
        context.stroke()

        off = 0
        for c in range(1, len(self.counters)):
            off += self.thick * self.counters[c-1] + slack
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size+4))
            off += 1
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size+4))
            context.stroke()

        context.restore()


def write_scad(counters, out):
    maxsize = 0
    for counter in counters:
        if counter.size > maxsize:
            maxsize = counter.size

    with open(out + ".scad", "w") as f:
        f.write("include <../lib_counter_trays.scad>\n\n")
        f.write("ArrangeCounterBox(%d) {\n" % (maxsize,))

        for counter in counters:
            f.write("  %s(%f, %f, [" % (counter.boxtype, counter.size, counter.thick))
            for i in counter.counters:
                f.write("%d, " % (i,))
            f.write("], \"%s\"" % (counter.label,))
            # optionals
            if counter.height > 0:
                f.write(f", tokheight={counter.height}")
            if counter.skipcase > 0:
                f.write(f", skipcase=1")
            if counter.cards:
                f.write(f", cards=true")
            f.write(");\n")
        f.write("}\n")


def write_pdf(counters, out):
    with cairo.PDFSurface(out + ".pdf", DOTS_PER_INCH * 8.5, DOTS_PER_INCH * 11) as surface:
        ctx = cairo.Context(surface)
        ctx.set_line_width(0.2)
        off = 25.4
        for c in counters:
            ctx.move_to(25.4, mm_to_pt(off))
            c.draw(ctx)
            off += c.size + 2
            off += ctx.text_extents(c.label).height + mm_to_pt(1)
            if mm_to_pt(off + c.size + 2) > (DOTS_PER_INCH * 10.5):
                off = 25.4
                surface.show_page()


def process_file(filename, options):
    counters = []
    if options.out is None:
        out = os.path.dirname(filename)
    else:
        out = options.out[0]
        if not os.path.exists(out):
            os.mkdir(out)
    out = os.path.join(out, re.sub(".json$", "", os.path.basename(filename)))
    with open(filename) as f:
        obj = json5.load(f)

    if not isinstance(obj, list):
        raise ValueError("Expected list of counter definitions in " + filename)

    for counter in obj:
        for required in ["size", "thick", "counters", "label"]:
            if required not in counter:
                raise ValueError("Missing field %s in counter definition" % (required,))
        if "type" not in counter:
            boxtype = "CounterBox"
        else:
            boxtype = counter["type"]
        if options.skiptext:
            label = ""
        else:
            label = counter["label"]
        box = CounterBox(boxtype, counter["size"], counter["thick"], counter["counters"], label)
        # optional properties
        if "height" in counter:
            box.height = counter["height"]
        if "skipcase" in counter and counter["skipcase"] is True:
            box.skipcase = True
        if "cards" in counter and counter["cards"] is True:
            box.cards = True

        counters.append(box)

    write_scad(counters, out)
    write_pdf(counters, out)
    if options.stl:
        print("processing %s" % (out+".scad"))
        subprocess.run(["openscad", "-o", out+".stl", out+".scad"])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate counter boxes from json description.')
    parser.add_argument('file', nargs='+', help='File to processs')
    parser.add_argument('--skiptext',  action='store_true', help='don\'t create embossed text (speeds up stl generation)')
    parser.add_argument('--out', '-o', metavar='dir', nargs=1, help='output directory')
    parser.add_argument('--stl', '-s', action='store_true', default=False, help='generate .stl files')
    args = parser.parse_args()

    for file in args.file:
        process_file(file, args)
