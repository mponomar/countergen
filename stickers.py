#!/opt/homebrew/bin/python3

import cairo

slack = 0.8

def mm_to_pt(n):
    return n/25.4 * 72;

class CounterBox:
    def __init__(self, size, thick, counts, label):
        self.size = size
        self.thick = thick
        self.counts = counts
        w = 0
        for c in range(0, len(self.counts)):
            w += self.counts[c] * self.thick
            if c != 0:
                w += 1
            if c != len(self.counts)-1:
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
        context.line_to(x+mm_to_pt(self.total_width), y+mm_to_pt(self.size))
        context.line_to(x, y+mm_to_pt(self.size))
        context.line_to(x, y)
        context.stroke()

        off = 0
        for c in range(1, len(self.counts)):
            off += self.thick * self.counts[c-1] + slack
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size))
            off += 1
            context.move_to(x+mm_to_pt(off), y)
            context.line_to(x+mm_to_pt(off), y+mm_to_pt(self.size))
            context.stroke()

        context.restore()

with cairo.PDFSurface("test.pdf", 72 * 8.5, 72 * 11) as surface:
    ctx = cairo.Context(surface)
    counters = [
        CounterBox(20, 2.2, [ 19, 10, 5, 28, 10, 3 ], "Control 1"),
        CounterBox(20, 2.2, [ 15, 5, 5, 5, 12, 5, 5, 10, 2, 4, 2, 4 ], "Control 2"),
        CounterBox(20, 2.2, [ 5, 11, 6, 5 ], "Ground"),
        CounterBox(20, 2.2, [ 5, 5, 7, 7, 5, 9, 12, 8 ], "Ordnance"),
        CounterBox(20, 2.2, [ 20, 20 ], "Huh"),
        CounterBox(20, 2.2, [ 17, 4, 4, 10, 1, 4, 4, ], "Leaders/Weapons"),
        CounterBox(20, 2.2, [ 20, 12, 14, 18, ], "Squads"),
        CounterBox(20, 2.2, [ 10, 20, 2, 2, ], "Guard"),
        CounterBox(27, 2.2, [ 4, 3, 5, 2, ], "Guns"),
        CounterBox(27, 2.2, [ 4, 9, 3, 1, ], "Tanks"),
        CounterBox(20, 2.2, [ 6, 3, 28, 4, 4, 1, 4, 2, ], "Leaders/Weapons"),
        CounterBox(20, 2.2, [ 10, 10, 10, 15, ], "Squads 1"),
        CounterBox(20, 2.2, [ 10, 20, 16, 10, 15, ], "Squads 2"),
        CounterBox(27, 2.2, [ 3, 3, 3, 2, 3, 4, ], "Guns"),
        CounterBox(27, 2.2, [ 6, 6, 3, 8, 2, 1, 2, 3, 8, ], "Tanks"),
        CounterBox(27, 2.2, [ 7, 7, ], "Emp/Hull"),
        CounterBox(27, 2.2, [ 4, 4, ], "Vic/Obj")
    ]
    ctx.set_line_width(0.2)
    off = 25.4
    for c in counters:
        ctx.move_to(25.4, mm_to_pt(off))
        c.draw(ctx)
        off += c.size + 2
        off += ctx.text_extents(c.label).height + mm_to_pt(1)
        if mm_to_pt(off + c.size + 2) > (72 * 10.5):
            off = 25.4
            surface.show_page()
