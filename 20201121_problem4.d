module problem4;

import std.math : abs;

@safe:
pure:
nothrow:

void main() {
    assert(findLowestMissingPosInt([3, 4, -1, 1]) == 2);
    assert(findLowestMissingPosInt([1, 2, 0]) == 3);
}

@nogc:

private void swap(T)(T* a, T* b) {
    const temp = *a;
    *a = *b;
    *b = temp;
}

private int findLowestMissingPosInt(int[] arr) {
    int findLowestMissingPosInt(int[] arr) {
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
