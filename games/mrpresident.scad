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
    ], "International");
    CounterBox(14, 2, [
            24, // Numbers
            10, // +- AP
            2,  // Can't increase this turn
            6,  // Game state
    ], "Game State");
    CounterBox(14, 2, [
            3,  // Must Choose Intel, No joint action, Joint Maneuvers
    ], "Allies");
    CounterBox(14, 2, [
            7,  // Domestic Markers
    ], "Domestic");

}
