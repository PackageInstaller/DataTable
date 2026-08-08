---@class FilterTable
---@field public id integer
---@field public buttonName LocalStrEnum
---@field public system integer
---@field public type integer
---@field public content table

---@type FilterTable[]
local FilterTable = {
                [1] = {
                        id = 1,
                        buttonName = LocalStrEnum.buttonName1,
                        system = 3,
                        type = 1,
                        content = {1},
                },

                [2] = {
                        id = 2,
                        buttonName = LocalStrEnum.buttonName2,
                        system = 3,
                        type = 2,
                        content = {5},
                },

                [3] = {
                        id = 3,
                        buttonName = LocalStrEnum.buttonName3,
                        system = 3,
                        type = 2,
                        content = {4},
                },

                [4] = {
                        id = 4,
                        buttonName = LocalStrEnum.buttonName4,
                        system = 3,
                        type = 2,
                        content = {3},
                },

                [5] = {
                        id = 5,
                        buttonName = LocalStrEnum.buttonName5,
                        system = 3,
                        type = 2,
                        content = {2},
                },

}
return FilterTable