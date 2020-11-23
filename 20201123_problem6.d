module problem6;

pure:
nothrow:

void main() {
    LinkedList!int list;
    list.add(1);
    list.add(2);
    list.add(3);

    foreach (i; 0 .. 3) {
        assert(list.get(i).val == i + 1);
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
        if (oldEnd == null) {
            start = node;
        } else {
            end.both ^= cast(ulong)oldEnd;
            oldEnd.both ^= cast(ulong)end;
        }
    }

    Node* get(ulong index) {
        auto node = start;
        auto next = start.both;
        foreach (i; 0 .. index) {
            const temp = node;
            node = cast(Node*)next;
            next = node.both ^ cast(ulong)temp;
        }
        return node;
    }
}
