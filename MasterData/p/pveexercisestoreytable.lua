---@class PveExerciseStoreyTable
---@field public id integer
---@field public progressNeed integer
---@field public storeyNum integer
---@field public Reward table
---@field public passCost table
---@field public passReward table
---@field public exp integer
---@field public userExp integer

---@type PveExerciseStoreyTable[]
local PveExerciseStoreyTable = {
                [1001] = {
                        id = 1001,
                        progressNeed = 8,
                        storeyNum = 1,
                        Reward = {{1,100003,6000},{1,100002,30},{1,170035,1}},
                        passCost = {100010,18},
                        passReward = {{1,100003,6000},{1,100002,30},{1,170035,1}},
                        exp = 90,
                        userExp = 18,
                },

                [1002] = {
                        id = 1002,
                        progressNeed = 8,
                        storeyNum = 2,
                        Reward = {{1,100003,8000},{1,100002,30},{1,100012,100}},
                        passCost = {100010,18},
                        passReward = {{1,100003,8000},{1,100002,30},{1,100012,100}},
                        exp = 90,
                        userExp = 18,
                },

                [1003] = {
                        id = 1003,
                        progressNeed = 8,
                        storeyNum = 3,
                        Reward = {{1,100003,10000},{1,100002,30},{1,110016,1}},
                        passCost = {100010,18},
                        passReward = {{1,100003,10000},{1,100002,30},{1,110016,1}},
                        exp = 90,
                        userExp = 18,
                },

                [1004] = {
                        id = 1004,
                        progressNeed = 8,
                        storeyNum = 4,
                        Reward = {{1,100003,12000},{1,100002,30},{1,110053,5}},
                        passCost = {100010,18},
                        passReward = {{1,100003,12000},{1,100002,30},{1,110053,5}},
                        exp = 90,
                        userExp = 18,
                },

                [1005] = {
                        id = 1005,
                        progressNeed = 8,
                        storeyNum = 5,
                        Reward = {{1,100003,14000},{1,100002,30},{1,100012,200}},
                        passCost = {100010,18},
                        passReward = {{1,100003,14000},{1,100002,30},{1,100012,200}},
                        exp = 90,
                        userExp = 18,
                },

                [1006] = {
                        id = 1006,
                        progressNeed = 8,
                        storeyNum = 6,
                        Reward = {{1,100003,16000},{1,100002,30},{1,110016,2}},
                        passCost = {100010,18},
                        passReward = {{1,100003,16000},{1,100002,30},{1,110016,2}},
                        exp = 90,
                        userExp = 18,
                },

                [1007] = {
                        id = 1007,
                        progressNeed = 8,
                        storeyNum = 7,
                        Reward = {{1,100003,18000},{1,100002,30},{1,170036,1}},
                        passCost = {100010,18},
                        passReward = {{1,100003,18000},{1,100002,30},{1,170036,1}},
                        exp = 90,
                        userExp = 18,
                },

                [1008] = {
                        id = 1008,
                        progressNeed = 8,
                        storeyNum = 8,
                        Reward = {{1,100003,20000},{1,100002,30},{1,110004,1}},
                        passCost = {100010,18},
                        passReward = {{1,100003,20000},{1,100002,30},{1,110004,1}},
                        exp = 90,
                        userExp = 18,
                },

}
return PveExerciseStoreyTable