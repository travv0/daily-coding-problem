const std = @import("std");
const Allocator = std.mem.Allocator;
const testing = std.testing;

test "findResult" {
    {
        const result = try findResult(testing.allocator, &[_]isize{ 1, 2, 3, 4, 5 });
        defer testing.allocator.free(result);
        testing.expectEqualSlices(isize, &[_]isize{ 120, 60, 40, 30, 24 }, result);
    }
    {
        const result = try findResult(testing.allocator, &[_]isize{ 3, 2, 1 });
        defer testing.allocator.free(result);
        testing.expectEqualSlices(isize, &[_]isize{ 2, 3, 6 }, result);
    }
}

fn findResult(allocator: *Allocator, arr: []const isize) ![]isize {
    std.debug.assert(arr.len > 1);
    var result = try allocator.alloc(isize, arr.len);
    errdefer allocator.free(result);
    result[0] = product(arr[1..]);
    var i: usize = 1;
    while (i < arr.len) : (i += 1) {
        result[i] = @divTrunc(result[i - 1], arr[i]) * if (i > 0) arr[i - 1] else 1;
    }
    return result;
}

fn product(arr: []const isize) isize {
    std.debug.assert(arr.len > 0);
    var result: isize = arr[0];
    var i: usize = 1;
    while (i < arr.len) : (i += 1) {
        result *= arr[i];
    }
    return result;
}

test "findResultNoDiv" {
    {
        const result = try findResultNoDiv(testing.allocator, &[_]isize{ 1, 2, 3, 4, 5 });
        defer testing.allocator.free(result);
        testing.expectEqualSlices(isize, &[_]isize{ 120, 60, 40, 30, 24 }, result);
    }
    {
        const result = try findResultNoDiv(testing.allocator, &[_]isize{ 3, 2, 1 });
        defer testing.allocator.free(result);
        testing.expectEqualSlices(isize, &[_]isize{ 2, 3, 6 }, result);
    }
}

fn findResultNoDiv(allocator: *Allocator, arr: []const isize) ![]isize {
    std.debug.assert(arr.len > 1);
    var result = try allocator.alloc(isize, arr.len);
    errdefer allocator.free(result);
    for (arr) |_, i| {
        result[i] = productSkipIndex(arr, i);
    }
    return result;
}

fn productSkipIndex(arr: []const isize, skip_i: usize) isize {
    std.debug.assert(arr.len > 0);
    var result: isize = 1;
    var i: usize = 0;
    while (i < arr.len) : (i += 1) {
        if (i != skip_i)
            result *= arr[i];
    }
    return result;
}
