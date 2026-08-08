---@class SurvivorItemTable
---@field public id integer
---@field public model string
---@field public effectType integer
---@field public effectParameter table

---@type SurvivorItemTable[]
local SurvivorItemTable = {
                [1001] = {
                        id = 1001,
                        model = "SurvivalExp1",
                        effectType = 1,
                        effectParameter = {20},
                },

                [1002] = {
                        id = 1002,
                        model = "SurvivalExp2",
                        effectType = 1,
                        effectParameter = {50},
                },

                [2001] = {
                        id = 2001,
                        model = "SurvivalHeal",
                        effectType = 2,
                        effectParameter = {10},
                },

}
return SurvivorItemTable