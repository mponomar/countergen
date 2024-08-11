/*
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
         tokheight     If specified, makes a rectangular token, with this height.
                       Otherwise you get a toksize x toksize square.
         fontsize      Font size for label.

     ArrangeCounterBox is a convenience module to arrange multiple boxes on
     the same print plate.  Usage is optional. It takes the token size as
     the only required argument. wallthick can also be provided as above.

 */

module HexBox(toksize, tokthick, sections, label, wallthick=1, slack=0.8, tolerance=0.1) {
    function sum1(list, i) = i >= 0 ? list[i] + sum1(list, i-1) : 0;
    function sum(list) = sum1(list, len(list)-1);

    ntok = sum(sections);
    nsec = len(sections);

    length = wallthick*2 + ntok*tokthick + nsec * slack + (nsec-2)*wallthick;
    offs = [ for (s = sections) s*tokthick + slack + wallthick ];

    r = (toksize/2)/tan(60);
    s = (toksize/2)/sin(60);

    // flat-top 
    // polygon([[0, 0], [r, -toksize/2], [r+s, -toksize/2], [2*r+s, 0], [r+s, toksize/2], [r, toksize/2]]);

    difference() {
        cube([2*wallthick + length, 2*wallthick + slack + toksize, r*2]);
        translate([wallthick, wallthick, r*2+wallthick]) {
            rotate([90, 0, 90]) {
                linear_extrude(length) {
                    polygon([[0, 0], 
                             [0, -s/2], 
                             [toksize/2+slack, -s/2-r], 
                             [toksize+slack, -s/2], 
                             [toksize+slack, 0]
                             ]);
                }
            }
        }
    }
    // sections
    translate([wallthick, wallthick, wallthick]) {
        for (i=[0:1:len(sections)-2]) {
            off=sum1(offs, i) - wallthick;

            translate([off, 0, 0]) {
                cube([wallthick, wallthick + toksize, r*2-wallthick]);
            }
        }
    }

    extraheadroom = 1;
    gap = 1;
    height = 4*r ;
    width = 2*wallthick + toksize + gap;

    // case
    caselen=length+2*wallthick;
    translate([- (height + 2*wallthick + tolerance + extraheadroom) - gap, 0, caselen]) {
        rotate([0, 90, 0]) {
            difference() {
                cube([caselen, width+wallthick*2, height+wallthick*2+extraheadroom]);
                translate([-1, wallthick-tolerance/2, wallthick-tolerance/2]) {
                    cube([caselen, width+tolerance, height+tolerance+extraheadroom]);
                }
                translate([caselen, (width+wallthick*2+tolerance)/2 , (height+wallthick*2+tolerance)/2]) {
                    cube([wallthick*2+1, width*(2/3), height*(2/3)], center=true);
                }
            }
        }
    }
}

module CounterBox(toksize, tokthick, sections, label="", wallthick=1, intwallthick=0, slack=0.8, gap=10,  tolerance=0.1, tokheight=0, fontsize=0, extraheadroom=1, skipcase=0) {
    function sum1(list, i) = i >= 0 ? list[i] + sum1(list, i-1) : 0;
    function sum(list) = sum1(list, len(list)-1);
    fsize = fontsize ? fontsize : 8;
    theight = tokheight == 0 ? toksize : tokheight;

    intwall = intwallthick ? intwallthick :  wallthick;

    offs = [ for (s = sections) s*tokthick + slack + intwall ];
    ntok = sum(sections);
    nsec = len(sections);

    length = wallthick*2 + ntok*tokthick + nsec * slack + (nsec-1)*intwall;
    width = wallthick*2 + toksize + slack;
    height = wallthick + theight + slack;
    partheight = wallthick + height * (2/3);


    // box
    difference()  {
        cube([length, width, partheight]);
        translate([wallthick, wallthick, wallthick]) {
            cube([length-2*wallthick, width-2*wallthick, height]);
        }
        translate([length/2, width/2, 0]) {
            linear_extrude(wallthick/3) {
                rotate([180, 0, 0]) {
                    text(label, size=fsize, halign="center", valign="center");
                }
            }
        }
    }

    // sections
    translate([wallthick, wallthick, wallthick]) {
        for (i=[0:1:len(sections)-2]) {
            off=sum1(offs, i) - wallthick;

            translate([off, 0, 0]) {
                cube([intwall, width-2*wallthick, partheight-wallthick]);
            }
        }
    }
    if (skipcase == 0) {
        // case
        caselen=length+wallthick;
        translate([- (height + 2*wallthick + tolerance + extraheadroom) - gap, 0, caselen]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([caselen, width+wallthick*2, height+wallthick*2+extraheadroom]);
                    translate([-1, wallthick-tolerance/2, wallthick-tolerance/2]) {
                        cube([caselen, width+tolerance, height+tolerance+extraheadroom]);
                    }
                    if (len(label) > 0) {
                        translate([caselen/2, width/2, height+wallthick+slack+extraheadroom]) {
                            linear_extrude(slack*2) {
                                text(label, size=fsize, halign="center", valign="center");
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
}

module ArrangeCounterBox(toksize, wallthick=1) {
        for (i=[0:$children-1]) {
            translate([0, i*(toksize+wallthick*4+5), 0]) {
            children(i);
        }
    }
}
