module problem6;

pure:
nothrow:

void main() {
    LinkedList!int list;

    assert(list.get(0) is null);

    list.add(1);

    assert(list.get(0).val == 1);
    assert(list.get(1) is null);

    list.add(2);
    list.add(3);

    foreach (i; 0 .. 4) {
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
        auto node = new Node(element);
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
            const temp = node;
            node = cast(Node*)next;
            next = node.both ^ cast(ulong)temp;
        }
        return node;
    }
}
