---@class MonthCardTable
---@field public id integer
---@field public type integer
---@field public cardName LocalStrEnum
---@field public purchaseAward table
---@field public exAward table
---@field public lastTime integer
---@field public privilege table
---@field public exPrivilegeDesc string
---@field public limitDays integer
---@field public cardMailTitle string
---@field public cardMailContent string

---@type MonthCardTable[]
local MonthCardTable = {
                [1001] = {
                        id = 1001,
                        type = 1,
                        cardName = LocalStrEnum.card_name_9001,
                        purchaseAward = {{1,100001,300}},
                        exAward = {{1,100002,100}},
                        lastTime = 30,
                        privilege = {},
                        exPrivilegeDesc = "",
                        limitDays = 360,
                        cardMailTitle = "月间战略协议物资发放",
                        cardMailContent = "已积攒的月间战略协议物资，请指挥官签收。",
                },

                [1002] = {
                        id = 1002,
                        type = 2,
                        cardName = LocalStrEnum.card_name_9002,
                        purchaseAward = {{1,110013,1}},
                        exAward = {{1,110012,2}},
                        lastTime = 7,
                        privilege = {{2,3},{101,2},{102,1},{104,1}},
                        exPrivilegeDesc = "每日主线剧情困难模式关卡可领奖次数<color=#fffad8><b>+3</b></color>\n每日常规清剿经验材料额外奖励次数<color=#fffad8><b>+2</b></color>\n每日常规清剿舰装材料额外奖励次数<color=#fffad8><b>+1</b></color>\n每日常规清剿天赋树材料额外奖励次数<color=#fffad8><b>+1</b>",
                        limitDays = 364,
                        cardMailTitle = "周期作战许可物资发放",
                        cardMailContent = "已积攒的周期作战许可物资，请指挥官签收。",
                },

}
return MonthCardTable