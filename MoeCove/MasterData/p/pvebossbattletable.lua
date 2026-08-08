---@class PveBossBattleTable
---@field public id integer
---@field public IssueNum integer
---@field public BossBattleId table

---@type PveBossBattleTable[]
local PveBossBattleTable = {
                [1001] = {
                        id = 1001,
                        IssueNum = 1,
                        BossBattleId = {1001,1002},
                },

                [1002] = {
                        id = 1002,
                        IssueNum = 2,
                        BossBattleId = {1002,1001},
                },

                [1003] = {
                        id = 1003,
                        IssueNum = 3,
                        BossBattleId = {1001,1002},
                },

                [1004] = {
                        id = 1004,
                        IssueNum = 4,
                        BossBattleId = {1002,1001},
                },

}
return PveBossBattleTable