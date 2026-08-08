---@class AutoChessSiftConditionTable
---@field public id integer
---@field public siftConditionType integer
---@field public conditionValue table
---@field public compareType integer

---@type AutoChessSiftConditionTable[]
local AutoChessSiftConditionTable = {
                [1] = {
                        id = 1,
                        siftConditionType = 1,
                        conditionValue = nil,
                        compareType = 0,
                },

                [2] = {
                        id = 2,
                        siftConditionType = 2,
                        conditionValue = nil,
                        compareType = 0,
                },

                [3] = {
                        id = 3,
                        siftConditionType = 3,
                        conditionValue = nil,
                        compareType = 0,
                },

                [4] = {
                        id = 4,
                        siftConditionType = 4,
                        conditionValue = nil,
                        compareType = 0,
                },

                [501] = {
                        id = 501,
                        siftConditionType = 5,
                        conditionValue = {2},
                        compareType = 0,
                },

                [15] = {
                        id = 15,
                        siftConditionType = 15,
                        conditionValue = nil,
                        compareType = 0,
                },

                [16] = {
                        id = 16,
                        siftConditionType = 16,
                        conditionValue = nil,
                        compareType = 0,
                },

                [801] = {
                        id = 801,
                        siftConditionType = 8,
                        conditionValue = {2,120},
                        compareType = 3,
                },

                [802] = {
                        id = 802,
                        siftConditionType = 8,
                        conditionValue = {10,5},
                        compareType = 3,
                },

                [701] = {
                        id = 701,
                        siftConditionType = 7,
                        conditionValue = {11,12,13,14,15},
                        compareType = 1,
                },

                [702] = {
                        id = 702,
                        siftConditionType = 7,
                        conditionValue = {11,12,13,14,15},
                        compareType = 6,
                },

                [703] = {
                        id = 703,
                        siftConditionType = 7,
                        conditionValue = {51,52,53,61,62},
                        compareType = 1,
                },

                [704] = {
                        id = 704,
                        siftConditionType = 7,
                        conditionValue = {51,52,53},
                        compareType = 1,
                },

                [705] = {
                        id = 705,
                        siftConditionType = 7,
                        conditionValue = {31,32,33},
                        compareType = 1,
                },

                [706] = {
                        id = 706,
                        siftConditionType = 7,
                        conditionValue = {31,32,33},
                        compareType = 6,
                },

                [707] = {
                        id = 707,
                        siftConditionType = 7,
                        conditionValue = {21,22,23,24},
                        compareType = 1,
                },

                [708] = {
                        id = 708,
                        siftConditionType = 7,
                        conditionValue = {21,22,23,24},
                        compareType = 6,
                },

                [709] = {
                        id = 709,
                        siftConditionType = 7,
                        conditionValue = {61,62},
                        compareType = 1,
                },

                [710] = {
                        id = 710,
                        siftConditionType = 7,
                        conditionValue = {61,62},
                        compareType = 6,
                },

                [711] = {
                        id = 711,
                        siftConditionType = 7,
                        conditionValue = {41,42,43},
                        compareType = 1,
                },

                [712] = {
                        id = 712,
                        siftConditionType = 7,
                        conditionValue = {41,42,43},
                        compareType = 6,
                },

                [713] = {
                        id = 713,
                        siftConditionType = 7,
                        conditionValue = {51,52,53,71},
                        compareType = 1,
                },

                [714] = {
                        id = 714,
                        siftConditionType = 7,
                        conditionValue = {21,22,23,24,31,32,33,41,42,43},
                        compareType = 1,
                },

                [715] = {
                        id = 715,
                        siftConditionType = 7,
                        conditionValue = {71},
                        compareType = 1,
                },

                [716] = {
                        id = 716,
                        siftConditionType = 7,
                        conditionValue = {71},
                        compareType = 6,
                },

                [717] = {
                        id = 717,
                        siftConditionType = 7,
                        conditionValue = {51,52,53},
                        compareType = 6,
                },

                [718] = {
                        id = 718,
                        siftConditionType = 7,
                        conditionValue = {11,12,13,14,15,61,62},
                        compareType = 1,
                },

                [719] = {
                        id = 719,
                        siftConditionType = 7,
                        conditionValue = {11,12,13,14,15,51,52,53},
                        compareType = 1,
                },

                [901] = {
                        id = 901,
                        siftConditionType = 9,
                        conditionValue = {1},
                        compareType = 5,
                },

                [902] = {
                        id = 902,
                        siftConditionType = 9,
                        conditionValue = {2},
                        compareType = 5,
                },

                [903] = {
                        id = 903,
                        siftConditionType = 9,
                        conditionValue = {3},
                        compareType = 5,
                },

                [904] = {
                        id = 904,
                        siftConditionType = 9,
                        conditionValue = {4},
                        compareType = 5,
                },

                [1001] = {
                        id = 1001,
                        siftConditionType = 10,
                        conditionValue = {1},
                        compareType = 3,
                },

                [1002] = {
                        id = 1002,
                        siftConditionType = 10,
                        conditionValue = {0.8},
                        compareType = 5,
                },

                [1003] = {
                        id = 1003,
                        siftConditionType = 10,
                        conditionValue = {0.6},
                        compareType = 3,
                },

                [1004] = {
                        id = 1004,
                        siftConditionType = 10,
                        conditionValue = {0.3},
                        compareType = 3,
                },

                [1005] = {
                        id = 1005,
                        siftConditionType = 10,
                        conditionValue = {0.5},
                        compareType = 4,
                },

                [1201] = {
                        id = 1201,
                        siftConditionType = 12,
                        conditionValue = {1},
                        compareType = 1,
                },

                [1202] = {
                        id = 1202,
                        siftConditionType = 12,
                        conditionValue = {2},
                        compareType = 1,
                },

                [1211] = {
                        id = 1211,
                        siftConditionType = 12,
                        conditionValue = {11},
                        compareType = 1,
                },

                [1212] = {
                        id = 1212,
                        siftConditionType = 12,
                        conditionValue = {12},
                        compareType = 1,
                },

                [1213] = {
                        id = 1213,
                        siftConditionType = 12,
                        conditionValue = {13},
                        compareType = 1,
                },

                [1214] = {
                        id = 1214,
                        siftConditionType = 12,
                        conditionValue = {14},
                        compareType = 1,
                },

                [1295] = {
                        id = 1295,
                        siftConditionType = 12,
                        conditionValue = {95},
                        compareType = 1,
                },

                [1296] = {
                        id = 1296,
                        siftConditionType = 12,
                        conditionValue = {96},
                        compareType = 1,
                },

                [1297] = {
                        id = 1297,
                        siftConditionType = 12,
                        conditionValue = {97},
                        compareType = 1,
                },

                [1299] = {
                        id = 1299,
                        siftConditionType = 12,
                        conditionValue = {99},
                        compareType = 1,
                },

                [1301] = {
                        id = 1301,
                        siftConditionType = 13,
                        conditionValue = {1},
                        compareType = 1,
                },

                [1401] = {
                        id = 1401,
                        siftConditionType = 14,
                        conditionValue = {1},
                        compareType = 1,
                },

                [1402] = {
                        id = 1402,
                        siftConditionType = 14,
                        conditionValue = {0},
                        compareType = 1,
                },

                [1501] = {
                        id = 1501,
                        siftConditionType = 17,
                        conditionValue = {21,22},
                        compareType = 2,
                },

                [1502] = {
                        id = 1502,
                        siftConditionType = 17,
                        conditionValue = {23},
                        compareType = 2,
                },

                [10101] = {
                        id = 10101,
                        siftConditionType = 101,
                        conditionValue = {0},
                        compareType = 0,
                },

                [10102] = {
                        id = 10102,
                        siftConditionType = 101,
                        conditionValue = {1},
                        compareType = 0,
                },

                [10201] = {
                        id = 10201,
                        siftConditionType = 102,
                        conditionValue = {1,1},
                        compareType = 0,
                },

                [10202] = {
                        id = 10202,
                        siftConditionType = 102,
                        conditionValue = {2,1},
                        compareType = 0,
                },

                [10301] = {
                        id = 10301,
                        siftConditionType = 103,
                        conditionValue = {1},
                        compareType = 0,
                },

                [10302] = {
                        id = 10302,
                        siftConditionType = 103,
                        conditionValue = {0},
                        compareType = 0,
                },

}
return AutoChessSiftConditionTable