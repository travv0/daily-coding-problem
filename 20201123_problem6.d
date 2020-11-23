module problem6;

import core.stdc.stdlib : malloc, free;

@nogc:
nothrow:

void main() {
    LinkedList!int list;

    assert(list.get(0) is null);

    foreach (i; 1 .. 10_001)
        list.add(i);

    foreach (i; 0 .. 10_000) {
        const node = list.get(i);
        if (node !is null) {
            assert(node.val == i + 1);
        }
    }
}

private struct LinkedList(T) {
    struct Node {
        T val;
        ulong both = 0;
    }

    Node* start = null;
    Node* end = null;

    void add(T element) {
        Node* node = cast(Node*)malloc(Node.sizeof);
        *node = Node(element);
        auto oldEnd = end;
        end = node;
        if (oldEnd is null) {
            start = node;
        } else {
            end.both ^= cast(ulong)oldEnd;
            oldEnd.both ^= cast(ulong)end;
        }
    }

    Node* get(ulong index) {
        if (start is null)
            return null;
        auto node = start;
        auto next = start.both;
        foreach (i; 0 .. index) {
            if (next == 0)
                return null;
            const temp = cast(ulong)node;
            node = cast(Node*)next;
            next = node.both ^ temp;
        }
        return node;
    }

    ~this() {
        if (start is null)
            return;
        auto node = start;
        auto next = start.both;
        while (true) {
            const temp = cast(ulong)node;
            free(node);
            if (next == 0)
                break;
            node = cast(Node*)next;
            next = node.both ^ temp;
        }
    }
}
