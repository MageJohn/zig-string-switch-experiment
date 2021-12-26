This is an experiment in a way to switch on a string, building on the work from
Hejsil
[here](https://github.com/Hejsil/fun-with-zig/blob/17f524b0ea394cbf4e49b4ac81dfbd39dcb92aa4/bench/match.zig).

Running the benchmark on my machine (AMD Ryzen 7 5800HS, Linux) gives
these results:

```
1/1 test "match.StringSwitchOriginal.benchmark"... 
Benchmark                          Iterations   Mean(ns)
--------------------------------------------------------
switch_StringSwitchOriginal(0)         100000         47
switch_StringSwitchOriginal(1)         100000         54
switch_StringSwitchOriginal(2)         100000         62
switch_StringSwitchOriginal(3)         100000         80
switch_StringSwitchOriginal(4)         100000        112
switch_StringSwitchOriginal(5)         100000        179
switch_StringSwitchOriginal(6)         100000        305
switch_StringSwitchOriginal(7)         100000        586
switch_StringSwitchOriginal(8)         100000       1112
switch_StringSwitchOriginal(9)         100000       2124
switch_StringSwitchOriginal(10)        100000       4136
switch_StringSwitchOriginal(11)        100000        243
switch_StringSwitchOriginal(12)        100000        389
switch_StringSwitchOriginal(13)        100000        658
switch_StringSwitchOriginal(14)        100000       1181
switch_StringSwitchOriginal(15)        100000       2173
switch_StringSwitchOriginal(16)        100000       4198
switch_StringSwitchOriginal(17)         59758       8367
switch_StringSwitchOriginal(18)         30126      16597
switch_StringSwitchMemEql(0)           100000         49
switch_StringSwitchMemEql(1)           100000         52
switch_StringSwitchMemEql(2)           100000         63
switch_StringSwitchMemEql(3)           100000         75
switch_StringSwitchMemEql(4)           100000        102
switch_StringSwitchMemEql(5)           100000        154
switch_StringSwitchMemEql(6)           100000        255
switch_StringSwitchMemEql(7)           100000        449
switch_StringSwitchMemEql(8)           100000        829
switch_StringSwitchMemEql(9)           100000       1593
switch_StringSwitchMemEql(10)          100000       3128
switch_StringSwitchMemEql(11)          100000        166
switch_StringSwitchMemEql(12)          100000        270
switch_StringSwitchMemEql(13)          100000        480
switch_StringSwitchMemEql(14)          100000        846
switch_StringSwitchMemEql(15)          100000       1609
switch_StringSwitchMemEql(16)          100000       3169
switch_StringSwitchMemEql(17)           80759       6191
switch_StringSwitchMemEql(18)           39547      12643
switch_mem_eql(0)                      100000         45
switch_mem_eql(1)                      100000         50
switch_mem_eql(2)                      100000         58
switch_mem_eql(3)                      100000         73
switch_mem_eql(4)                      100000        100
switch_mem_eql(5)                      100000        154
switch_mem_eql(6)                      100000        258
switch_mem_eql(7)                      100000        455
switch_mem_eql(8)                      100000        849
switch_mem_eql(9)                      100000       1679
switch_mem_eql(10)                     100000       3240
switch_mem_eql(11)                     100000        166
switch_mem_eql(12)                     100000        273
switch_mem_eql(13)                     100000        464
switch_mem_eql(14)                     100000        862
switch_mem_eql(15)                     100000       1653
switch_mem_eql(16)                     100000       3194
switch_mem_eql(17)                      79029       6326
switch_mem_eql(18)                      39700      12594
switch_StringSwitchComptimeMap(0)      100000         58
switch_StringSwitchComptimeMap(1)      100000         59
switch_StringSwitchComptimeMap(2)      100000         68
switch_StringSwitchComptimeMap(3)      100000         77
switch_StringSwitchComptimeMap(4)      100000        103
switch_StringSwitchComptimeMap(5)      100000        151
switch_StringSwitchComptimeMap(6)      100000        253
switch_StringSwitchComptimeMap(7)      100000        447
switch_StringSwitchComptimeMap(8)      100000        833
switch_StringSwitchComptimeMap(9)      100000       1602
switch_StringSwitchComptimeMap(10)     100000       3193
switch_StringSwitchComptimeMap(11)     100000        163
switch_StringSwitchComptimeMap(12)     100000        265
switch_StringSwitchComptimeMap(13)     100000        455
switch_StringSwitchComptimeMap(14)     100000        848
switch_StringSwitchComptimeMap(15)     100000       1612
switch_StringSwitchComptimeMap(16)     100000       3183
switch_StringSwitchComptimeMap(17)      79389       6298
switch_StringSwitchComptimeMap(18)      43838      11405
OK
All 1 tests passed.
```
