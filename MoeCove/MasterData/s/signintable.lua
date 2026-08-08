---@class SignInTable
---@field public id integer
---@field public type integer
---@field public awardGroud integer
---@field public isInGame integer

---@type SignInTable[]
local SignInTable = {
                [1001] = {
                        id = 1001,
                        type = 1,
                        awardGroud = 10001,
                        isInGame = 1,
                },

                [2001] = {
                        id = 2001,
                        type = 2,
                        awardGroud = 20001,
                        isInGame = 1,
                },

                [2002] = {
                        id = 2002,
                        type = 2,
                        awardGroud = 20002,
                        isInGame = 0,
                },

}
return SignInTable