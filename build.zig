const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const bench = b.addTest("string-switch.zig");
    bench.setBuildMode(mode);
    bench.addPackagePath("bench", "lib/zig-bench/bench.zig");

    const bench_step = b.step("bench", "Run the benchmark");
    bench_step.dependOn(&bench.step);

    b.default_step.dependOn(bench_step);
}
