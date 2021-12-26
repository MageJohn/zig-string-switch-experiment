This is an experiment in a way to switch on a string, building on the work from
Hejsil
[here](https://github.com/Hejsil/fun-with-zig/blob/17f524b0ea394cbf4e49b4ac81dfbd39dcb92aa4/bench/match.zig).

Running the benchmark on my machine (AMD Ryzen 7 5800HS, Linux) gives
these results:

```
1/1 test "match.StringSwitchOriginal.benchmark"... 
Benchmark                       Iterations   Mean(ns)
-----------------------------------------------------
switch_StringSwitchOriginal(0)      100000         36
switch_StringSwitchOriginal(1)      100000         39
switch_StringSwitchOriginal(2)      100000         46
switch_StringSwitchOriginal(3)      100000         58
switch_StringSwitchOriginal(4)      100000         84
switch_StringSwitchOriginal(5)      100000        127
switch_StringSwitchOriginal(6)      100000        222
switch_StringSwitchOriginal(7)      100000        419
switch_StringSwitchOriginal(8)      100000        810
switch_StringSwitchOriginal(9)      100000       1551
switch_StringSwitchOriginal(10)     100000       3064
switch_StringSwitchOriginal(11)     100000        165
switch_StringSwitchOriginal(12)     100000        275
switch_StringSwitchOriginal(13)     100000        475
switch_StringSwitchOriginal(14)     100000        852
switch_StringSwitchOriginal(15)     100000       1618
switch_StringSwitchOriginal(16)     100000       3135
switch_StringSwitchOriginal(17)      83163       6012
switch_StringSwitchOriginal(18)      42113      11873
switch_StringSwitchMemEql(0)        100000         34
switch_StringSwitchMemEql(1)        100000         37
switch_StringSwitchMemEql(2)        100000         45
switch_StringSwitchMemEql(3)        100000         54
switch_StringSwitchMemEql(4)        100000         72
switch_StringSwitchMemEql(5)        100000        109
switch_StringSwitchMemEql(6)        100000        183
switch_StringSwitchMemEql(7)        100000        328
switch_StringSwitchMemEql(8)        100000        607
switch_StringSwitchMemEql(9)        100000       1168
switch_StringSwitchMemEql(10)       100000       2309
switch_StringSwitchMemEql(11)       100000        121
switch_StringSwitchMemEql(12)       100000        196
switch_StringSwitchMemEql(13)       100000        339
switch_StringSwitchMemEql(14)       100000        616
switch_StringSwitchMemEql(15)       100000       1195
switch_StringSwitchMemEql(16)       100000       2322
switch_StringSwitchMemEql(17)       100000       4574
switch_StringSwitchMemEql(18)        55347       9033
switch_mem_eql(0)                   100000         32
switch_mem_eql(1)                   100000         34
switch_mem_eql(2)                   100000         41
switch_mem_eql(3)                   100000         51
switch_mem_eql(4)                   100000         71
switch_mem_eql(5)                   100000        108
switch_mem_eql(6)                   100000        182
switch_mem_eql(7)                   100000        315
switch_mem_eql(8)                   100000        594
switch_mem_eql(9)                   100000       1210
switch_mem_eql(10)                  100000       2261
switch_mem_eql(11)                  100000        119
switch_mem_eql(12)                  100000        191
switch_mem_eql(13)                  100000        329
switch_mem_eql(14)                  100000        600
switch_mem_eql(15)                  100000       1169
switch_mem_eql(16)                  100000       2256
switch_mem_eql(17)                  100000       4476
switch_mem_eql(18)                   56654       8825
OK
All 1 tests passed.
```
