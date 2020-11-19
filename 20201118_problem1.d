module problem1;

import std.stdio;

void main() {
}

unittest {
    assert([10,15,3,7].addsUpTo(17));
    assert(![10,15,3,8].addsUpTo(17));
}

bool addsUpTo(int[] nums, int check) {
    foreach (i, num; nums) {
        foreach (num2; nums[i+1..$]) {
            if (num + num2 == check) return true;
        }
    }
    return false;
}