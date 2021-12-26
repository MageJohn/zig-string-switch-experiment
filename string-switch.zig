const std = @import("std");
const bench = @import("bench");

const debug = std.debug;
const mem = std.mem;

pub fn StringSwitchOriginal(comptime strings: []const []const u8) type {
    for (strings[1..]) |_, i| {
        if (mem.lessThan(u8, strings[i], strings[i + 1]))
            continue;

        @compileError("Input not sorted (assert(\"" ++ strings[i] ++ "\" < \"" ++ strings[i + 1] ++ "\"))");
    }

    return struct {
        pub fn match(str: []const u8) usize {
            var curr: usize = 0;
            next: for (strings) |s, i| {
                while (curr < s.len) : (curr += 1) {
                    const a = str[curr];
                    const b = s[curr];
                    if (a != b)
                        continue :next;
                }

                if (s.len == str.len)
                    return i;
            }

            return strings.len;
        }

        pub fn case(comptime str: []const u8) usize {
            const i = match(str);
            debug.assert(i < strings.len);
            return i;
        }
    };
}

pub fn StringSwitchMemEql(comptime strings: []const []const u8) type {
    return struct {
        pub fn match(str: []const u8) usize {
            inline for (strings) |s, i| {
                if (mem.eql(u8, str, s)) {
                    return i;
                }
            }

            return strings.len;
        }

        pub fn case(comptime str: []const u8) usize {
            const i = match(str);
            debug.assert(i < strings.len);
            return i;
        }
    };
}

pub fn StringSwitchComptimeMap(comptime strings: []const []const u8) type {
    const Map = std.ComptimeStringMap(usize, blk: {
        var entries: [strings.len]std.meta.Tuple(&.{ []const u8, usize }) = undefined;
        inline for (strings) |s, i| {
            entries[i] = .{ s, i };
        }
        break :blk entries;
    });
    return struct {
        pub fn match(str: []const u8) usize {
            return Map.get(str) orelse strings.len;
        }

        pub fn case(comptime str: []const u8) usize {
            const i = match(str);
            debug.assert(i < strings.len);
            return i;
        }
    };
}

test "match.StringSwitchOriginal.benchmark" {
    try bench.benchmark(struct {
        pub const args = [_][]const u8{
            "A" ** 1,
            "A" ** 2,
            "A" ** 4,
            "A" ** 8,
            "A" ** 16,
            "A" ** 32,
            "A" ** 64,
            "A" ** 128,
            "A" ** 256,
            "A" ** 512,
            "A" ** 1024,
            "abcd" ** 8,
            "abcd" ** 16,
            "abcd" ** 32,
            "abcd" ** 64,
            "abcd" ** 128,
            "abcd" ** 256,
            "abcd" ** 512,
            "abcd" ** 1024,
        };

        // copy of strings so that mem.eql has to compare strings byte by byte,
        // rather than just comparing pointers.
        pub const strings = [_][]const u8{
            "A" ** 1,
            "A" ** 2,
            "A" ** 4,
            "A" ** 8,
            "A" ** 16,
            "A" ** 32,
            "A" ** 64,
            "A" ** 128,
            "A" ** 256,
            "A" ** 512,
            "A" ** 1024,
            "abcd" ** 8,
            "abcd" ** 16,
            "abcd" ** 32,
            "abcd" ** 64,
            "abcd" ** 128,
            "abcd" ** 256,
            "abcd" ** 512,
            "abcd" ** 1024,
        };

        pub fn switch_StringSwitchOriginal(str: []const u8) usize {
            @setEvalBranchQuota(100000);
            const sw = StringSwitchOriginal(&strings);
            return switch (sw.match(str)) {
                sw.case("A" ** 1) => 21,
                sw.case("A" ** 2) => 15,
                sw.case("A" ** 4) => 31,
                sw.case("A" ** 8) => 111,
                sw.case("A" ** 16) => 400,
                sw.case("A" ** 32) => 2,
                sw.case("A" ** 64) => 100000,
                sw.case("A" ** 128) => 12345,
                sw.case("A" ** 256) => 1,
                sw.case("A" ** 512) => 35,
                sw.case("A" ** 1024) => 99999999,
                sw.case("abcd" ** 8) => 4,
                sw.case("abcd" ** 16) => 1512,
                sw.case("abcd" ** 32) => 152222,
                sw.case("abcd" ** 64) => 42566,
                sw.case("abcd" ** 128) => 66477,
                sw.case("abcd" ** 256) => 345377,
                sw.case("abcd" ** 512) => 745745,
                sw.case("abcd" ** 1024) => 3444,
                else => 2241255,
            };
        }

        pub fn switch_StringSwitchMemEql(str: []const u8) usize {
            @setEvalBranchQuota(100000);
            const sw = StringSwitchMemEql(&strings);
            return switch (sw.match(str)) {
                sw.case("A" ** 1) => 21,
                sw.case("A" ** 2) => 15,
                sw.case("A" ** 4) => 31,
                sw.case("A" ** 8) => 111,
                sw.case("A" ** 16) => 400,
                sw.case("A" ** 32) => 2,
                sw.case("A" ** 64) => 100000,
                sw.case("A" ** 128) => 12345,
                sw.case("A" ** 256) => 1,
                sw.case("A" ** 512) => 35,
                sw.case("A" ** 1024) => 99999999,
                sw.case("abcd" ** 8) => 4,
                sw.case("abcd" ** 16) => 1512,
                sw.case("abcd" ** 32) => 152222,
                sw.case("abcd" ** 64) => 42566,
                sw.case("abcd" ** 128) => 66477,
                sw.case("abcd" ** 256) => 345377,
                sw.case("abcd" ** 512) => 745745,
                sw.case("abcd" ** 1024) => 3444,
                else => 2241255,
            };
        }

        pub fn switch_mem_eql(str: []const u8) usize {
            if (mem.eql(u8, "A" ** 1, str)) {
                return 21;
            } else if (mem.eql(u8, "A" ** 2, str)) {
                return 15;
            } else if (mem.eql(u8, "A" ** 4, str)) {
                return 31;
            } else if (mem.eql(u8, "A" ** 8, str)) {
                return 111;
            } else if (mem.eql(u8, "A" ** 16, str)) {
                return 400;
            } else if (mem.eql(u8, "A" ** 32, str)) {
                return 2;
            } else if (mem.eql(u8, "A" ** 64, str)) {
                return 100000;
            } else if (mem.eql(u8, "A" ** 128, str)) {
                return 12345;
            } else if (mem.eql(u8, "A" ** 256, str)) {
                return 1;
            } else if (mem.eql(u8, "A" ** 512, str)) {
                return 35;
            } else if (mem.eql(u8, "A" ** 1024, str)) {
                return 99999999;
            } else if (mem.eql(u8, "abcd" ** 8, str)) {
                return 4;
            } else if (mem.eql(u8, "abcd" ** 16, str)) {
                return 1512;
            } else if (mem.eql(u8, "abcd" ** 32, str)) {
                return 152222;
            } else if (mem.eql(u8, "abcd" ** 64, str)) {
                return 42566;
            } else if (mem.eql(u8, "abcd" ** 128, str)) {
                return 66477;
            } else if (mem.eql(u8, "abcd" ** 256, str)) {
                return 345377;
            } else if (mem.eql(u8, "abcd" ** 512, str)) {
                return 745745;
            } else if (mem.eql(u8, "abcd" ** 1024, str)) {
                return 3444;
            } else {
                return 2241255;
            }
        }

        pub fn switch_StringSwitchComptimeMap(str: []const u8) usize {
            @setEvalBranchQuota(100000);
            const sw = StringSwitchComptimeMap(&strings);
            return switch (sw.match(str)) {
                sw.case("A" ** 1) => 21,
                sw.case("A" ** 2) => 15,
                sw.case("A" ** 4) => 31,
                sw.case("A" ** 8) => 111,
                sw.case("A" ** 16) => 400,
                sw.case("A" ** 32) => 2,
                sw.case("A" ** 64) => 100000,
                sw.case("A" ** 128) => 12345,
                sw.case("A" ** 256) => 1,
                sw.case("A" ** 512) => 35,
                sw.case("A" ** 1024) => 99999999,
                sw.case("abcd" ** 8) => 4,
                sw.case("abcd" ** 16) => 1512,
                sw.case("abcd" ** 32) => 152222,
                sw.case("abcd" ** 64) => 42566,
                sw.case("abcd" ** 128) => 66477,
                sw.case("abcd" ** 256) => 345377,
                sw.case("abcd" ** 512) => 745745,
                sw.case("abcd" ** 1024) => 3444,
                else => 2241255,
            };
        }
    });
}
