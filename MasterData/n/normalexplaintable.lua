---@class NormalExplainTable
---@field public id integer
---@field public type integer
---@field public Offest integer
---@field public size table
---@field public des string

---@type NormalExplainTable[]
local NormalExplainTable = {
                [1001] = {
                        id = 1001,
                        type = 1,
                        Offest = 1,
                        size = {600,100},
                        des = "影响角色的伤害和维修效果，数值越大效果越强！",
                },

                [1002] = {
                        id = 1002,
                        type = 2,
                        Offest = 2,
                        size = {},
                        des = "这里是一段很长的描述",
                },

                [1003] = {
                        id = 1003,
                        type = 3,
                        Offest = 3,
                        size = {},
                        des = "这里是一段很长的描述",
                },

}
return NormalExplainTable