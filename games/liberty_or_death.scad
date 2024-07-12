include <../lib_counter_trays.scad>

ArrangeCounterBox(45) {
    CounterBox(13, 2, [20, 20], "Support");
    CounterBox(16, 2, [26, 12, 12, 7], "Control/Misc");
    CounterBox(22, 2, [1,2,3,3,3], "Leaders", tokheight=45, fontsize=6); 
    CounterBox(18, 2, [1,1,2,2,2], "Leaders", tokheight=32, fontsize=5, extraheadroom=1);
}
