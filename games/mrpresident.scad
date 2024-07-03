include <../lib_counter_trays.scad>

ArrangeCounterBox(14) {
    // Conflicts
    CounterBox(14, 2, [
            5,  // [*] War
            6,  // [*] Conflict Type
            15, // [*] Conflict Status
            10, // [*] Relative Strength
            4,  // [*] WMD Acquired
            4,  // [*] Cyber Attack Used
            1,  // [*] Cyber vs Rogue State
            20, // [*] Opponents at war
            20, // [*] Allies at war (20?)
    ], "Conflicts");
    // US Forces
    CounterBox(14, 2, [
            6,  // [*] USAF
            6,  // [*] Carrier
            5,  // [*] Army Lt
            4,  // [*] Army Hv
            5,  // [*] Specops
            5,  // [*] Intel Advisor
            6,  // [*] USMC
            2,  // [*] Focused Intel
            16, // [*] Military Footprint
    ], "US Forces");
    // Opponents
    CounterBox(14, 2, [
            3,  // [*] DARPA
            7,  // [*] US Strategic Capabilities
            7,  // [*] China Strategic Capabilities
            7,  // [*] Russia Strategic Capabilities
            26, // [*] Opponent Influence
            4,  // [*] Bases
            4,  // [*] China Setup
            5,  // [*] China Random (2 +-AP, Acted, Summit used, Economic Trend) 
            4,  // [*] Russia Setup
            5,  // [*] Russia Random
            6,  // [*] Iran Influence
            2,  // [*] Iran/NK WMD/Missile Programs
            2,  // [*] Iran/NK Can't increase this turn
    ], "World Opponents");
    // World Status
    CounterBox(14, 2, [
            4,  // [*] Trade Agreements
            1,  // [*] Economic Trend
            4,  // [*] Ally Groups
            6,  // [*] Multilateral Sanctions
            4,  // [*] Unilateral Sanctions
            20, // [*] Civil War
            8,  // [*] Ceasefire
            1,  // [*] EU SOE
            8,  // [*] Regional Alignment
            8,  // [*] Regional Stability
            8,  // [*] Regional Crises
            8,  // [*] Pro/Anti US
            1,  // [*] EU SOE
    ], "International");
    CounterBox(14, 2, [
            8,  // [*] Bill Passed
            2,  // [*] Legislative Random (No New Legislation This Turn, Impeachment Proceedings) 
            16, // [*] Bills
            6,  // [*] Advances
            6,  // [*] Cabinet Priority
            1,  // [*] Bipartisan Cooperation
            1,  // [*] Party Relations
            2,  // [*] Cabinet Status (Cabinet Effectiveness, Effectiveness Trend)
            2,  // [*] Party Status (Control of Houses, Supreme Court Nominee)
            16, // [*] Public Priority
            16, // [*] Cabinet Priority
            1,  // [*] Campaign Promise
            5,  // [*] Scandals
    ], "Politics");
    CounterBox(14, 2, [
            1,  // [*] UN Speech
            6,  // [*] UN Sanctions
            12, // [*] UN Goodwill
            8,  // [*] UN Troops
    ], "UN");
    CounterBox(14, 2, [
            6,  // [*] Rogue State 1/2
            2,  // [*] Rogue State 3/4
            32, // [*] Terror Group 1/2
            8,  // [*] Terror Group 3/4
    ], "Enemies");
    CounterBox(14, 2, [
            24, // [*] Numbers
            10, // [*] +- AP
            6,  // [*] Game State (Public Approval, State of Economy, National Security, Media Relations, Relations w/Congress, World Opinion)
            1,  // [*] US Action
            1,  // [*] Current Turn
            1,  // [*] Nobel Prize
            5,  // [*] Legacy 1x, Legacy 10x, Prestige, AP+10, AP+20
    ], "Game State");
    CounterBox(14, 2, [
            3,  // [*] Must Choose Intel
            1,  // [*] No Joint Action
            1,  // [*] Intel Rolls -1 DRM
            9,  // [*] Ally relations
            2,  // [*] +2 DRM to Espionage
    ], "Allies");
    CounterBox(14, 2, [
            12, // [*] Legislative Friends
            12, // [*] Legislative Opponents
            1,  // [*] Economic Trend
            16, // [*] POTUS Attributes
            16, // [*] Cabinet Candidates
            2,  // [*] LDI, Domestic Crisis
    ], "Domestic");
    CounterBox(14, 2, [
            56,  // [*] Tensions
            24,  // [*] Crisis Chits
    ], "Tensions");
}
