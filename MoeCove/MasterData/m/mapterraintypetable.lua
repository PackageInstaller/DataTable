---@class MapTerrainTypeTable
---@field public id integer
---@field public name string
---@field public moveCost table
---@field public defAdd integer
---@field public tags table
---@field public isBlock integer
---@field public mapPcr string

---@type MapTerrainTypeTable[]
local MapTerrainTypeTable = {
                [1] = {
                        id = 1,
                        name = "深海",
                        moveCost = {1,1,1,1,1,99},
                        defAdd = 1,
                        tags = {1},
                        isBlock = 0,
                        mapPcr = "deep_sea",
                },

                [2] = {
                        id = 2,
                        name = "浅海",
                        moveCost = {2,1,2,2,1,99},
                        defAdd = 1,
                        tags = {2},
                        isBlock = 0,
                        mapPcr = "shallow_sea",
                },

                [3] = {
                        id = 3,
                        name = "河流",
                        moveCost = {1,1,2,2,1,99},
                        defAdd = 1,
                        tags = {3},
                        isBlock = 0,
                        mapPcr = "river",
                },

                [4] = {
                        id = 4,
                        name = "漂浮物海域",
                        moveCost = {1,2,1,1,1,99},
                        defAdd = 1.05,
                        tags = {4},
                        isBlock = 0,
                        mapPcr = "ruins_goods",
                },

                [5] = {
                        id = 5,
                        name = "礁石海域",
                        moveCost = {2,1,3,1,1,99},
                        defAdd = 1.1,
                        tags = {4},
                        isBlock = 0,
                        mapPcr = "reef_waters_little",
                },

                [6] = {
                        id = 6,
                        name = "XX海域",
                        moveCost = {2,2,1,3,1,99},
                        defAdd = 1.3,
                        tags = {4},
                        isBlock = 0,
                        mapPcr = "",
                },

                [7] = {
                        id = 7,
                        name = "XX海域",
                        moveCost = {2,2,1,3,1,99},
                        defAdd = 1.2,
                        tags = {4},
                        isBlock = 0,
                        mapPcr = "",
                },

                [8] = {
                        id = 8,
                        name = "礁石海域",
                        moveCost = {2,2,1,2,1,99},
                        defAdd = 1.1,
                        tags = {4},
                        isBlock = 0,
                        mapPcr = "reef_waters_little",
                },

                [9] = {
                        id = 9,
                        name = "XX海域",
                        moveCost = {1,1,1,1,1,99},
                        defAdd = 1,
                        tags = {9},
                        isBlock = 0,
                        mapPcr = "",
                },

                [10] = {
                        id = 10,
                        name = "浅滩",
                        moveCost = {3,2,99,99,99,99},
                        defAdd = 1,
                        tags = {10},
                        isBlock = 1,
                        mapPcr = "shoal",
                },

                [11] = {
                        id = 11,
                        name = "礁石",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {11},
                        isBlock = 1,
                        mapPcr = "reef_waters_big",
                },

                [12] = {
                        id = 12,
                        name = "陆地",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {12},
                        isBlock = 1,
                        mapPcr = "land_grassland",
                },

                [13] = {
                        id = 13,
                        name = "山脉",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {13},
                        isBlock = 1,
                        mapPcr = "montes",
                },

                [14] = {
                        id = 14,
                        name = "森林",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {14},
                        isBlock = 1,
                        mapPcr = "forest",
                },

                [15] = {
                        id = 15,
                        name = "废墟",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {15},
                        isBlock = 1,
                        mapPcr = "ruins_ship",
                },

                [16] = {
                        id = 16,
                        name = "墙壁",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {16},
                        isBlock = 1,
                        mapPcr = "wall",
                },

                [17] = {
                        id = 17,
                        name = "陆地",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {12},
                        isBlock = 1,
                        mapPcr = "land_sand",
                },

                [18] = {
                        id = 18,
                        name = "废墟",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {15},
                        isBlock = 1,
                        mapPcr = "ruins_wall",
                },

                [19] = {
                        id = 19,
                        name = "废墟",
                        moveCost = {99,99,99,99,99,99},
                        defAdd = 1,
                        tags = {15},
                        isBlock = 1,
                        mapPcr = "ruins_goods",
                },

                [99] = {
                        id = 99,
                        name = "传送带",
                        moveCost = {99,99,99,99,99,1},
                        defAdd = 1,
                        tags = {1},
                        isBlock = 0,
                        mapPcr = "",
                },

                [100] = {
                        id = 100,
                        name = "洋流",
                        moveCost = {1,1,1,1,1,1},
                        defAdd = 1,
                        tags = {1},
                        isBlock = 0,
                        mapPcr = "",
                },

}
return MapTerrainTypeTable