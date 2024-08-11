include <../lib_counter_trays.scad>

ArrangeCounterBox(14) {
    CounterBox(12.7, 1.5, [
        25,  // first fire
        21,  // prep fire
        6,   // intensive fire
    ], "Fire");
    CounterBox(12.7, 1.5, [
        14,  // 2 residual
        7,   // 4 residual
        4,   // 8 residual
        6,   // 1 fire lane
        6,   // 4 fire lane
        25,  // DM
        4,   // Shock
        6,   // Encircled
        10,  // Smoke
        6,   // fanatic
    ], "Control");
    CounterBox(12.7, 1.5, [
       24,   // blaze
       7,    // bog
       3,    // hero
       7,    // berserk
       14,   // TI
       15,   // pin
       4,    // stun
       4,    // STUN
       1,    // turn
       10,   // TCA
        6,   // mines
        3,   // Minefield 6
        3,   // Minefield 12
    ], "Control 2");
    CounterBox(12.7, 1.5, [
       20,   // TB
       16,   // motion
       4,    // abandoned
       9,    // prisoners?guards? 3 dudes
       9,    // wall advance
       8,    // labor
      10,    // bu
      12,    // ca
       6,    // breach
       1,    // wind moderate
       6,    // melee
    ], "Control 3");
    CounterBox(12.7, 1.5, [
       4,    // cmg malfunction
       4,    // bmg malfunction
       4,    // aamg malfunction
       4,    // gun malfunction
       6,    // aim orange
       6,    // aim purple
       12,   // aim red
       6,    // aim black
       6,    // aim green
       12,   // aim blue
       4,    // battery no contact
    ], "Ordnance");
}
