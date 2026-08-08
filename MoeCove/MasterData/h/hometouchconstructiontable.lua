---@class HomeTouchConstructionTable
---@field public id integer
---@field public dailyAwardNum integer
---@field public randomDrop table
---@field public bubbleResource string

---@type HomeTouchConstructionTable[]
local HomeTouchConstructionTable = {
                [20001] = {
                        id = 20001,
                        dailyAwardNum = 5,
                        randomDrop = {{},{120}},
                        bubbleResource = "shy",
                },

                [20002] = {
                        id = 20002,
                        dailyAwardNum = 1,
                        randomDrop = {{},{120}},
                        bubbleResource = "shy",
                },

                [20003] = {
                        id = 20003,
                        dailyAwardNum = 1,
                        randomDrop = nil,
                        bubbleResource = "",
                },

                [20004] = {
                        id = 20004,
                        dailyAwardNum = 1,
                        randomDrop = nil,
                        bubbleResource = "",
                },

                [20005] = {
                        id = 20005,
                        dailyAwardNum = 1,
                        randomDrop = nil,
                        bubbleResource = "",
                },

                [20006] = {
                        id = 20006,
                        dailyAwardNum = 1,
                        randomDrop = nil,
                        bubbleResource = "",
                },

}
return HomeTouchConstructionTable