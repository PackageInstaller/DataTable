---@class ShopRecommendTable
---@field public id integer
---@field public shopType integer
---@field public order integer
---@field public turnTo integer
---@field public limitCondition table
---@field public shopOpen string
---@field public shopClose string

---@type ShopRecommendTable[]
local ShopRecommendTable = {
                [10001] = {
                        id = 10001,
                        shopType = 1,
                        order = 1,
                        turnTo = 1310005,
                        limitCondition = nil,
                        shopOpen = "2025-05-20 11:00:00",
                        shopClose = "2028-03-16 11:00:00",
                },

                [20001] = {
                        id = 20001,
                        shopType = 2,
                        order = 1,
                        turnTo = 1310003,
                        limitCondition = nil,
                        shopOpen = "",
                        shopClose = "",
                },

                [30001] = {
                        id = 30001,
                        shopType = 3,
                        order = 1,
                        turnTo = 1310001,
                        limitCondition = nil,
                        shopOpen = "",
                        shopClose = "",
                },

}
return ShopRecommendTable