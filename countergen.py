#!/usr/bin/env python3

import cairo
import json5
import os
import argparse
import re
import subprocess
import math

DOTS_PER_INCH = 72
slack = 0.8


def mm_to_pt(n):
    return n/25.4 * DOTS_PER_INCH


def radians(deg):
    return deg * (math.pi / 180)

class CounterBox:
    def __init__(self, boxtype, size, thick, counters, label):
        self.size = size
        self.thick = thick
        self.counters = counters
        self.boxtype = boxtype
        self.counter_labels = []
        self.height = 0
        self.skipcase = False
        self.cards = False
        w = 0
        for c in range(0, len(self.counters)):
            size = 0
            counter_label = None
            if isinstance(self.counters[c], int):
                size = self.counters[c]
            else:
                size = self.counters[c][0]
                counter_label = self.counters[c][1]
                self.counters[c] = self.counters[c][0]
            self.counter_labels.append(counter_label)
            w += size * self.thick
            if c != 0:
                w += 1
            if c != len(self.counters)-1:
                w += slack
        self.total_width = w
        self.label = label

    def draw(self, context, scale, doLabel=False, fontSize=10):
        x, y = context.get_current_point()
        startx = x
        starty = y
        context.set_font_size(fontSize)
        if (doLabel):
            context.show_text(self.label)
            y += context.text_extents(self.label).height + mm_to_pt(1)
        context.move_to(x, y)
        context.line_to(x+mm_to_pt(self.total_width), y)
        context.line_to(x+mm_to_pt(self.total_width), y+mm_to_pt(self.size*scale+4))
        context.line_to(x, y+mm_to_pt(self.size*scale+4))
        context.line_to(x, y)
        context.stroke()

        off = 0
        for c in range(1, len(self.counters)):
            off += self.thick * self.counters[c-1] + slack
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size*scale +4))
            context.move_to(x+mm_to_pt(off), y)
            off += 1
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size*scale +4))
            context.stroke()

        off = 0
        for c in range(0, len(self.counters)):
            off += ((mm_to_pt(self.thick) * self.counters[c] + mm_to_pt(slack)) / 2)
            if self.counter_labels[c] is not None:
                off += (context.text_extents(self.counter_labels[c]).height / 2)
                context.move_to(x+off, y + mm_to_pt(self.size*scale +4)/2 + (context.text_extents(self.counter_labels[c]).width / 2))
                context.rotate(radians(-90))
                context.show_text(self.counter_labels[c])
                off -= (context.text_extents(self.counter_labels[c]).height / 2)
                context.rotate(radians(90))
            off += ((mm_to_pt(self.thick) * self.counters[c] + mm_to_pt(slack)) / 2)
            off += mm_to_pt(1)

        context.move_to(startx, starty)


def write_scad(counters, out, options):
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
            label = counter.label
            if options.skiptext:
                label = ""
            f.write("], \"%s\"" % (label,))
            # optionals
            if counter.height > 0:
                f.write(f", tokheight={counter.height}")
            if counter.skipcase > 0:
                f.write(f", skipcase=1")
            if counter.cards:
                f.write(f", cards=true")
            f.write(");\n")
        f.write("}\n")


def write_pdf(counters, out, options):
    with cairo.PDFSurface(out + ".pdf", DOTS_PER_INCH * 8.5, DOTS_PER_INCH * 11) as surface:
        ctx = cairo.Context(surface)
        ctx.set_line_width(0.2)
        off = 25.4
        for c in counters:
            ctx.move_to(25.4, mm_to_pt(off))
            c.draw(ctx, 1, doLabel=True)
            off += c.size + mm_to_pt(4)
            ctx.move_to(25.4, mm_to_pt(off))
            c.draw(ctx, 0.66, fontSize=7)
            off += (c.size * 0.66) + mm_to_pt(4)
            if c.label:
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

    write_scad(counters, out, options)
    write_pdf(counters, out, options)
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
