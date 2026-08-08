---@class PveBossBattleScoreTable
---@field public id integer
---@field public scoreNum integer
---@field public Reward table

---@type PveBossBattleScoreTable[]
local PveBossBattleScoreTable = {
                [1001] = {
                        id = 1001,
                        scoreNum = 12600,
                        Reward = {{1,100002,30},{1,170041,1}},
                },

                [1002] = {
                        id = 1002,
                        scoreNum = 25200,
                        Reward = {{1,100002,30},{1,170041,2}},
                },

                [1003] = {
                        id = 1003,
                        scoreNum = 43200,
                        Reward = {{1,100002,30},{1,110010,5}},
                },

                [1004] = {
                        id = 1004,
                        scoreNum = 64800,
                        Reward = {{1,100002,30},{1,110004,1}},
                },

                [1005] = {
                        id = 1005,
                        scoreNum = 93600,
                        Reward = {{1,100002,30},{1,110003,1}},
                },

                [1006] = {
                        id = 1006,
                        scoreNum = 121600,
                        Reward = {{1,100002,30},{1,170042,1}},
                },

                [1007] = {
                        id = 1007,
                        scoreNum = 149700,
                        Reward = {{1,100002,30},{1,170042,2}},
                },

                [1008] = {
                        id = 1008,
                        scoreNum = 182500,
                        Reward = {{1,100002,30},{1,170017,1}},
                },

}
return PveBossBattleScoreTable