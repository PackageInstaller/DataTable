---@class ProsperityConstructionTable
---@field public id integer
---@field public name LocalStrEnum
---@field public icon string
---@field public group integer
---@field public includeBuild table
---@field public skip table
---@field public output integer
---@field public extraFunction integer
---@field public upType integer

---@type ProsperityConstructionTable[]
local ProsperityConstructionTable = {
                [1001] = {
                        id = 1001,
                        name = LocalStrEnum.PpConstructionName1001,
                        icon = "btn_building_icon01",
                        group = 1,
                        includeBuild = {10009},
                        skip = {1410011},
                        output = 0,
                        extraFunction = 0,
                        upType = 1,
                },

                [1002] = {
                        id = 1002,
                        name = LocalStrEnum.PpConstructionName1002,
                        icon = "btn_building_icon02",
                        group = 1,
                        includeBuild = {10003},
                        skip = {1410005},
                        output = 0,
                        extraFunction = 0,
                        upType = 1,
                },

                [1003] = {
                        id = 1003,
                        name = LocalStrEnum.PpConstructionName1003,
                        icon = "btn_building_icon08",
                        group = 1,
                        includeBuild = {10006},
                        skip = {1410013},
                        output = 0,
                        extraFunction = 0,
                        upType = 1,
                },

                [1004] = {
                        id = 1004,
                        name = LocalStrEnum.PpConstructionName1004,
                        icon = "btn_building_icon10",
                        group = 1,
                        includeBuild = {10019},
                        skip = {1410010},
                        output = 0,
                        extraFunction = 1,
                        upType = 1,
                },

                [1005] = {
                        id = 1005,
                        name = LocalStrEnum.PpConstructionName1005,
                        icon = "btn_building_icon09",
                        group = 1,
                        includeBuild = {10018},
                        skip = {1410012},
                        output = 0,
                        extraFunction = 0,
                        upType = 1,
                },

                [1006] = {
                        id = 1006,
                        name = LocalStrEnum.PpConstructionName1006,
                        icon = "btn_building_icon12",
                        group = 1,
                        includeBuild = {10015},
                        skip = nil,
                        output = 0,
                        extraFunction = 2,
                        upType = 2,
                },

                [2001] = {
                        id = 2001,
                        name = LocalStrEnum.PpConstructionName2001,
                        icon = "btn_building_icon06",
                        group = 2,
                        includeBuild = {10010},
                        skip = {1410006},
                        output = 1,
                        extraFunction = 0,
                        upType = 1,
                },

                [2002] = {
                        id = 2002,
                        name = LocalStrEnum.PpConstructionName2002,
                        icon = "btn_building_icon03",
                        group = 2,
                        includeBuild = {10011},
                        skip = {1410007},
                        output = 1,
                        extraFunction = 0,
                        upType = 1,
                },

                [2003] = {
                        id = 2003,
                        name = LocalStrEnum.PpConstructionName2003,
                        icon = "btn_building_icon04",
                        group = 2,
                        includeBuild = {10013},
                        skip = {1410009},
                        output = 1,
                        extraFunction = 0,
                        upType = 1,
                },

                [2004] = {
                        id = 2004,
                        name = LocalStrEnum.PpConstructionName2004,
                        icon = "btn_building_icon05",
                        group = 2,
                        includeBuild = {10012},
                        skip = {1410008},
                        output = 1,
                        extraFunction = 0,
                        upType = 1,
                },

                [2005] = {
                        id = 2005,
                        name = LocalStrEnum.PpConstructionName2005,
                        icon = "btn_building_icon11",
                        group = 2,
                        includeBuild = {10020,10021,10022,10023},
                        skip = nil,
                        output = 2,
                        extraFunction = 0,
                        upType = 2,
                },

}
return ProsperityConstructionTable