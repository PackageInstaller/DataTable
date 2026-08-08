---@class AutoChessBuffTable
---@field public id integer
---@field public name string
---@field public lv integer
---@field public disc string
---@field public showUI integer
---@field public icon string
---@field public buffType integer
---@field public duration number
---@field public maxStack integer
---@field public stackType integer
---@field public isStackDecay integer
---@field public flags integer
---@field public modifierIds table
---@field public dispellable integer

---@type AutoChessBuffTable[]
local AutoChessBuffTable = {
                [1] = {
                        id = 1,
                        name = "飞机加速buff",
                        lv = 0,
                        disc = "",
                        showUI = false,
                        icon = "1",
                        buffType = 0,
                        duration = 3,
                        maxStack = 5,
                        stackType = 3,
                        isStackDecay = 1,
                        flags = 0,
                        modifierIds = nil,
                        dispellable = 0,
                },

                [2] = {
                        id = 2,
                        name = "1",
                        lv = 0,
                        disc = "",
                        showUI = false,
                        icon = "2",
                        buffType = 0,
                        duration = 1,
                        maxStack = 0,
                        stackType = 2,
                        isStackDecay = 1,
                        flags = 0,
                        modifierIds = nil,
                        dispellable = 0,
                },

}
return AutoChessBuffTable