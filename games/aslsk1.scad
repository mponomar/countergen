include <lib_counter_trays.scad>

ArrangeCounterBox(14) {
    CounterBox(14, 1.5, [11, 9, 14, 13, 7, 5, 2, 2, 6, 11], "SK#1 US");
    CounterBox(14, 1.5, [14, 4, 8, 5, 6, 3, 5, 10], "SK#1 RU");
    CounterBox(14, 1.5, [14, 7, 10, 5, 14, 6, 14, 5, 10, 13], "SK#1 DE");
    CounterBox(14, 1.5, [4, 8, 5, 3, 10, 7, 8], "SK#1 MISC");
}
