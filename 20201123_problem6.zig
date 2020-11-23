const std = @import("std");
const testing = std.testing;
const Allocator = std.mem.Allocator;

test "" {
    const List = LinkedList(usize);
    var list = List.init(testing.allocator);
    defer list.deinit();

    testing.expectEqual(@as(?*List.Node, null), list.get(0));

    try list.add(1);

    testing.expectEqual(@as(usize, 1), list.get(0).?.val);
    testing.expectEqual(@as(?*List.Node, null), list.get(1));

    try list.add(2);
    try list.add(3);

    var i: usize = 0;
    while (i < 4) : (i += 1) {
        if (list.get(i)) |node| {
            testing.expectEqual(i + 1, node.val);
        }
    }
}

fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        const Node = struct {
            val: T,
            both: usize = 0,
        };

        start: ?*Node = null,
        end: ?*Node = null,
        allocator: *Allocator,

        fn init(allocator: *Allocator) Self {
            return .{ .allocator = allocator };
        }

        fn deinit(self: *Self) void {
            if (self.start) |start| {
                var node = start;
                var next = start.both;
                while (true) {
                    const temp = @ptrToInt(node);
                    self.allocator.destroy(node);
                    if (next == 0) return;
                    node = @intToPtr(*Node, next);
                    next = node.both ^ temp;
                }
            }
            self.* = undefined;
        }

        fn add(self: *Self, element: T) !void {
            var new_end = try self.allocator.create(Node);
            new_end.* = Node{ .val = element };
            const old_end = self.end;
            self.end = new_end;
            if (old_end) |oe| {
                new_end.both ^= @ptrToInt(oe);
                oe.both ^= @ptrToInt(new_end);
            } else {
                self.start = new_end;
            }
        }

        fn get(self: *Self, index: usize) ?*Node {
            if (self.start) |start| {
                var node = start;
                var next = start.both;
                var i: usize = 0;
                while (i < index) : (i += 1) {
                    if (next == 0) return null;
                    const temp = node;
                    node = @intToPtr(*Node, next);
                    next = node.both ^ @ptrToInt(temp);
                }
                return node;
            }
            return null;
        }
    };
}
