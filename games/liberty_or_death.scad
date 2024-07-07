include <../lib_counter_trays.scad>

ArrangeCounterBox(14) {
    CounterBox(13, 2, [20, 20], "Support");
    CounterBox(16, 2, [26, 12, 12, 7, 1, 1, 2, 2], "Control/Misc");
    CounterBox(22, 2, [1,2,3,3,3], "Leaders", tokheight=45);
}
