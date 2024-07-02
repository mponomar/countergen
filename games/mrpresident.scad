include <../lib_counter_trays.scad>

ArrangeCounterBox(14) {
    // Conflicts
    CounterBox(14, 2, [
            5,  // War
            6,  // Conflict Type
            15, // Conflict Status
            10, // Relative Strength
            2,  // WMD Acquired
            4,  // Cyber Attack Used
            20, // Opponents at war
            20, // Allies at war
    ], "Conflicts");
    // US Forces
    CounterBox(14, 2, [
            6,  // USAF
            6,  // Carrier
            5,  // Army Lt
            6,  // Army Hv
            5,  // Specops
            5,  // Intel Advisor
            6,  // USMC
            2,  // Focused Intel
            16, // Military Footprint
    ], "US Forces");
    // Opponents
    CounterBox(14, 2, [
            7,  // US Strategic Capabilities
            7,  // China Strategic Capabilities
            7,  // Russia Strategic Capabilities
            26, // Opponent Influence
            4,  // Bases
            4,  // China Setup
            5,  // China Random
            4,  // Russia Setup
            5,  // Russia Random
            6,  // Iran Influence
            2,  // Iran/NK WMD/Missil Programs
    ], "World Opponents");
    // World Status
    CounterBox(14, 2, [
            4,  // Trade Agreements
            2,  // Economic Trend
            7,  // Pro/Anti US
            2,  // Rogue WMD/Missile
            4,  // Ally Groups
            1,  // Nobel Prize
            6,  // Multilateral Sanctions
            8,  // Unilateral Sanctions
            20, // Civil War
            8,  // Ceasefire
            1,  // EU SOE
            8,  // Regional Alignment
            8,  // Regional Stability
            8,  // Regional Crises
    ], "International");
    CounterBox(14, 2, [
            12, // Legislative Friends
            12, // Legislative Opponents
            8,  // Bill Passed
            3,  // Legislative Random
            16, // Bills
            6,  // Advances
            6,  // Cabinet Priority
            1,  // Bipartisan Cooperation
            1,  // Party Relations
            2,  // Cabinet Status
            2,  // Party Status
            16, // Public Priority
            16, // Cabinet Priority
            1,  // Campaign Promise
    ], "Politics");
    CounterBox(14, 2, [
            1,  // UN Speech
            6,  // UN Sanctions
            12, // UN Goodwill
            8,  // UN Troops
    ], "UN");
    CounterBox(14, 2, [
            6,  // Rogue State 1/2
            2,  // Rogue State 3/4
            32, // Terror Group 1/2
            8,  // Terror Group 3/4
    ], "Enemies");
    CounterBox(14, 2, [
            24, // Numbers
            10, // +- AP
            2,  // Can't increase this turn
            6,  // Game State
            1,  // Current Action
    ], "Game State");
    CounterBox(14, 2, [
            3,  // Must Choose Intel, No joint action, Joint Maneuvers
            9,  // Ally relations
            1,  // Intel Rolls DRM
            1,  // DRM to Espionage
    ], "Allies");
    CounterBox(14, 2, [
            7,  // Domestic Markers
            3,  // DARPA
            1,  // Economic Trend
            16, // POTUS Attributes
            16, // Cabinet Candidates
            2,  // LDI, Domestic Crisis
    ], "Domestic");
    CounterBox(14, 2, [
            56,  // Tensions
            22,  // Crisis Chits
    ], "Tensions");
}
