#include <../lib_counter_trays.scad>

ArrangeCounterBox(14) {
    CounterBox(13, 1.5, [
        3,    // Hero
        15,   // DM
        7,    // Berzerk
        8,    // Stun
        14,   // TI/Disrupt
        15,   // PIN
        7,    // BOG/Mired
        8,    // Labor
        7,    // Game State
    ], "Status");

    CounterBox(13, 1.5, [
        14,    // 1/2
        7,     // 4/6
        4,     // 8
        6,     // Intense Fire
        6,     // Fire lane 1/2
        6,     // Fire lane 4/6
        3,     // Mines
    ], "Fire");

    CounterBox(13, 1.5, [
        8,     // BMG malfunction
    ], "Misc");

}
