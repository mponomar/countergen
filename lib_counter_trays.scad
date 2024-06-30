/*
     Open this up in OpenSCAD (https://openscad.org/) to generate
     partitioned boxes for counters.  There's an option in OpenSCAD
     to export it to STL for 3D printing.

     Required parameters:
        toksize        width/height of token, in mm.  Counters must be square.
        tokthick       thickness of token, in mm.
        sections       list of how many counters should be in each section.
                       For example to have 3 sections with enough room for 
                       10, 7, and 4 counters of the size and thickness 
                       provided by the first 2 parameters, enter [10, 7, 4]

     Optional parameters: 
     Specify name=value separated by commas.  They can be listed in any order, 
     and are all optional, with default values.
         label         Surround by double quotes (can't contain double
                       quotes).  If present, will emboss the label into the
                       cover. If not specified or left blank, nothing 
                       happens.  Honestly a sticker is probably better.
         wallthick     Thickness of outer walls of the box.  Defaults to 1mm.
         intwallthick  Thickness of partitions between counters. If
                       not specified or set to zero, defaults to the same 
                       value as outer walls (1mm unless changed above).
         slack         Slop. Fiddle factor. Extra padding added to a few
                       places to account for some things not being physically
                       perfect. Defaults to 0.8mm.
         gap           How much room to leave between the boxes and the 
                       covers objects on the print plate.
         tolerance     How much extra space to leave between the box and
                       the cover to allow them to friction fit.  This is
                       probably what needs to most tuning between different
                       printers/etc.  Defaults to 0.1mm.  Adjust down if the
                       fit is too loose and the box keeps falling out. Adjust
                       up if the fit is too tight and the box doesn't fit.

     ArrangeCounterBox is a convenience module to arrange multiple boxes on
     the same print plate.  Usage is optional. It takes the token size as
     the only required argument. wallthick can also be provided as above.

     Example usage: place this file in same folder as your definitions.  For 
     the SK#1 boxed set, this works:

include <counter_trays.scad>

ArrangeCounterBox(14) {
    CounterBox(14, 1.5, [11, 8, 15, 13, 7, 6, 2, 2, 6, 11], "SK#1 US");
    CounterBox(14, 1.5, [15, 3, 8, 5, 6, 3, 5, 10], "SK#1 RU");
    CounterBox(14, 1.5, [14, 7, 10, 5, 14, 6, 14, 5, 11, 14], "SK#1 DE");
    CounterBox(14, 1.5, [4, 8, 5, 3, 10, 7, 8], "SK#1 Misc");
}
 */

module CounterBox(toksize, tokthick, sections, label="", wallthick=1, intwallthick=0, slack=0.8, gap=10,  tolerance=0.1) {
    function sum1(list, i) = i >= 0 ? list[i] + sum1(list, i-1) : 0;
    function sum(list) = sum1(list, len(list)-1);

    intwall = intwallthick ? intwallthick :  wallthick;

    offs = [ for (s = sections) s*tokthick + slack + intwall ];
    ntok = sum(sections);
    nsec = len(sections);

    length = wallthick*2 + ntok*tokthick + nsec * slack + (nsec-1)*intwall;
    width = wallthick*2 + toksize + slack;
    height = wallthick + toksize + slack;
    partheight = wallthick + toksize * (2/3);


    // box
    difference()  {
    cube([length, width, partheight]);
        translate([wallthick, wallthick, wallthick]) {
            cube([length-2*wallthick, width-2*wallthick, height]);

        }
    }

    // sections
    translate([wallthick, wallthick, wallthick]) {
        for (i=[0:1:len(sections)-2]) {
            off=sum1(offs, i) - wallthick;

            translate([off, 0, 0]) {
                cube([intwall, toksize+slack, partheight-wallthick]);
            }
        }
    }

    // case
    caselen=length+wallthick;
    translate([-(width+gap), 0, caselen]) {
        rotate([0, 90, 0]) {
            difference() {
                cube([caselen, width+wallthick*2, height+wallthick*2]);
                translate([-1, wallthick-tolerance/2, wallthick-tolerance/2]) {
                    cube([caselen, width+tolerance, height+tolerance]);
                }
                if (len(label) > 0) {
                    translate([caselen/2, width/2, height+wallthick+slack]) {
                        linear_extrude(slack*2) {
                            text(label, size=8, halign="center", valign="center");
                        }
                    }
                }
                translate([caselen, (width+wallthick*2+tolerance)/2 , (height+wallthick*2+tolerance)/2]) {
                    cube([wallthick*2+1, width*(2/3), height*(2/3)], center=true);
                }
            }
        }
    }
}

module ArrangeCounterBox(toksize, wallthick=1) {
        for (i=[0:$children-1]) {
            translate([0, i*(toksize+wallthick*4+5), 0]) {
            children(i);
        }
    }
}
