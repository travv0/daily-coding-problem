// Given a list of numbers and a number k, return whether any two numbers from
// the list add up to k.
// 
// For example, given [10, 15, 3, 7] and k of 17, return true since 10 + 7 is
// 17.
// 
// Bonus: Can you do this in one pass?

module problem1;

import std.stdio;

@safe:
pure:
nothrow:

void main() {
    assert([10, 15, 3, 7].addsUpTo(17));
    assert(![10, 15, 3, 8].addsUpTo(17));

    assert([10, 15, 3, 7].addsUpToBonus(17));
    assert(![10, 15, 3, 8].addsUpToBonus(17));
}

private bool addsUpTo(int[] nums, int check) @nogc {
    foreach (i, num; nums) {
        foreach (num2; nums[i + 1 .. $]) {
            if (num + num2 == check)
                return true;
        }
    }
    return false;
}

private bool addsUpToBonus(int[] nums, int check) {
    void[0][int] map;
    foreach (num; nums) {
        if (num !in map)
            map[check - num] = [];
        else
            return true;
    }
    return false;
}
