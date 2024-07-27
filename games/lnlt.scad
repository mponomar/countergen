include <../lib_counter_trays.scad>

ArrangeCounterBox(19) {
    // Utility
    CounterBox(16, 2.2, [
        19,   // skills
        10,   // Melee / Upper Level
        5,    // Melee / Stealth
        28,   // fired / moved
        10,   // assault move / low crawl
        3,    // wounded
    ], "Control 1");

    CounterBox(16, 2.2, [
        15,   // ops complete / spotted
        5,    // hit and run / mines
        5,    // hit and run / immobilized
        5,    // hit and run / abandoned
        12,   // fire for effect  / spotting round
        5,    // shaken / continuous move
        5,    // shaken / low crawl
        10,   // shaken / abandoned
        2,    // event
        4,    // objective
        2,    // turn, SoP
        4,    // rp heros
    ], "Control 2");

    // Ground/conditions
    CounterBox(16, 2.2, [
        5,    // Foxholes
        11,   // Wreck
        6,    // Roadblock
        5,    // Emplaced
    ], "Ground");

    // ordnance
    CounterBox(16, 2.2, [
        5,    // acquiring
        5,    // target
        7,    // acquiring
        7,    // target
        5,    // fire
        9,    // FIRE
        12,   // Smoke
        8,    // Starshell
    ], "Ordnance");

    // huh
    CounterBox(16, 2.2, [
        20,
        20
    ], "Huh");

    // Russian
    CounterBox(16, 2.2, [
        17,   // turrets
        4,    // PTRS
        4,    // DP 28
        10,   // leaders
        1,    // sniper
        4,    // hero
        4,    // crew
    ], "Leaders/Weapons");
    // control
    CounterBox(16, 2.2, [
        20,   // 0-3-4-6
        12,   // 0-4-4-6
        14,   // 1-3-4-4
        18,   // 1-4-4-5
    ], "Squads");
    // guard
    CounterBox(16, 2.2, [
        10,   // 1-3-4-5
        20,   // 2-2-4-6
        2,    // leaders
        2,    // heros
    ], "Guard");
    CounterBox(19, 2.2, [
        4,    // Tachanka
        3,    // 12.7mm
        5,    // 45mm ATG
        2,    // 76mm ATG
    ], "Guns");

    CounterBox(23, 2.2, [
        4,    // KV 1C
        9,    // T34
        3,    // T70 
        1,    // IL-2
    ], "Tanks");

    // German
    CounterBox(16, 2.2, [
        6,    // leaders
        3,    // heroes
        28,   // turrets
        4,    // flamethrower
        4,    // mg34
        1,    // sniper
        4,    // crew
        2,    // crew
    ], "Leaders/Weapons");

    CounterBox(16, 2.2, [
        10,   // 0-5-4-5
        10,   // 1-3-4-5
        10,   // 1-3-4-6
        15,   // 1-4-4-5
    ], "Squads 1");

    CounterBox(16, 2.2, [
        10,   // 1-5-4-5
        20,   // 1-6-4-5
        16,   // 2-3-4-6
        10,  // 1-3-20-5
        15,  // 1-4-20-5
    ], "Squads 2");

    CounterBox(19, 2.2, [
        3,   // LelG-18
        3,   // Pak-40
        3,   // 50 mm
        2,   // 88 mm ATG
        3,   // 7.92 MG
        4,   // 50 mm ATG
    ], "Guns");

    CounterBox(23, 2.2, [
        6,   // Pz IV F
        6,   // Pz IV G
        3,   // Pz II F
        8,   // Pz III J
        2,   // Pz III J (SS)
        1,   // Sig 33 B
        2,   // Marder II
        3,   // Stug 3F
        8,   // SdKfz 231
    ], "Tanks");

    CounterBox(23, 2.2, [
        7,   // Emplacement
        7,   // Hull down
    ], "Emp/Hull");

    CounterBox(19, 2.2, [
        4,   // Victory
        4,   // Objective
    ], "Vic/Obj");
}
