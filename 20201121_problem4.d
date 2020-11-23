module problem4;

import std.math : abs;

void main() {
}

unittest {
    assert(findLowestMissingPosInt([3, 4, -1, 1]) == 2);
    assert(findLowestMissingPosInt([1, 2, 0]) == 3);
}

private void swap(T)(T* a, T* b) @safe pure @nogc nothrow {
    auto temp = *a;
    *a = *b;
    *b = temp;
}

private int findLowestMissingPosInt(int[] arr) @safe pure @nogc nothrow {
    int findLowestMissingPosInt(int[] arr) @safe pure @nogc nothrow {
        foreach (elem; arr) {
            immutable i = abs(elem) - 1;
            if (i < arr.length) {
                arr[i] = -abs(arr[i]);
            }
        }
        foreach (i, elem; arr) {
            if (elem > 0)
                return i + 1;
        }
        return arr.length + 1;
    }

    auto nonPosIndex = 0;
    foreach (i, elem; arr) {
        if (elem <= 0) {
            swap(&arr[nonPosIndex++], &arr[i]);
        }
    }
    return findLowestMissingPosInt(arr[nonPosIndex .. $]);
}
