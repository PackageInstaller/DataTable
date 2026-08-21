---@class ProsperityTable
---@field public id integer
---@field public levelTask integer
---@field public levelEffect table
---@field public effectShow table
---@field public coinProduction table
---@field public storyId integer

---@type ProsperityTable[]
local ProsperityTable = {
                [1] = {
                        id = 1,
                        levelTask = 14000001,
                        levelEffect = {{10004,1}},
                        effectShow = {"PpEffect_0101","PpEffect_0102"},
                        coinProduction = {},
                        storyId = 41301,
                },

                [2] = {
                        id = 2,
                        levelTask = 14000002,
                        levelEffect = {{10015,1},{20001,1}},
                        effectShow = {"PpEffect_0201","PpEffect_0202"},
                        coinProduction = {},
                        storyId = 41101,
                },

                [3] = {
                        id = 3,
                        levelTask = 14000003,
                        levelEffect = {{10005,1},{10002,1},{10020,1}},
                        effectShow = {"PpEffect_0301","PpEffect_0302","PpEffect_0303"},
                        coinProduction = {},
                        storyId = 41201,
                },

                [4] = {
                        id = 4,
                        levelTask = 14000004,
                        levelEffect = {{10021,1},{10025,1}},
                        effectShow = {"PpEffect_0401","PpEffect_0402"},
                        coinProduction = {1,100003,203},
                        storyId = 41501,
                },

                [5] = {
                        id = 5,
                        levelTask = 14000005,
                        levelEffect = {{10022,1}},
                        effectShow = {"PpEffect_0501"},
                        coinProduction = {1,100003,204},
                        storyId = 0,
                },

                [6] = {
                        id = 6,
                        levelTask = 14000006,
                        levelEffect = {{10023,1}},
                        effectShow = {"PpEffect_0601","PpEffect_0602"},
                        coinProduction = {1,100003,205},
                        storyId = 0,
                },

                [7] = {
                        id = 7,
                        levelTask = 14000007,
                        levelEffect = {{10020,2},{10021,2},{10022,2},{10023,2}},
                        effectShow = {"PpEffect_0701"},
                        coinProduction = {1,100003,206},
                        storyId = 0,
                },

                [8] = {
                        id = 8,
                        levelTask = 14000008,
                        levelEffect = {{10020,3},{10021,3},{10022,3},{10023,3}},
                        effectShow = {"PpEffect_0801","PpEffect_0802"},
                        coinProduction = {1,100003,207},
                        storyId = 0,
                },

                [9] = {
                        id = 9,
                        levelTask = 14000009,
                        levelEffect = {{10020,4},{10021,4},{10022,4},{10023,4}},
                        effectShow = {"PpEffect_0901"},
                        coinProduction = {1,100003,208},
                        storyId = 0,
                },

                [10] = {
                        id = 10,
                        levelTask = 14000010,
                        levelEffect = {{10020,5},{10021,5},{10022,5},{10023,5}},
                        effectShow = {"PpEffect_1001","PpEffect_1002"},
                        coinProduction = {1,100003,209},
                        storyId = 0,
                },

                [11] = {
                        id = 11,
                        levelTask = 14000011,
                        levelEffect = {{10020,6},{10021,6},{10022,6},{10023,6}},
                        effectShow = {"PpEffect_1101"},
                        coinProduction = {1,100003,210},
                        storyId = 0,
                },

                [12] = {
                        id = 12,
                        levelTask = 14000012,
                        levelEffect = {{10020,7},{10021,7},{10022,7},{10023,7}},
                        effectShow = {"PpEffect_1201","PpEffect_1202"},
                        coinProduction = {1,100003,211},
                        storyId = 0,
                },

                [13] = {
                        id = 13,
                        levelTask = 14000013,
                        levelEffect = {{10020,8},{10021,8},{10022,8},{10023,8}},
                        effectShow = {"PpEffect_1301"},
                        coinProduction = {1,100003,212},
                        storyId = 0,
                },

                [14] = {
                        id = 14,
                        levelTask = 14000014,
                        levelEffect = {{10020,9},{10021,9},{10022,9},{10023,9}},
                        effectShow = {"PpEffect_1401"},
                        coinProduction = {1,100003,213},
                        storyId = 0,
                },

                [15] = {
                        id = 15,
                        levelTask = 14000015,
                        levelEffect = {{10020,10},{10021,10},{10022,10},{10023,10}},
                        effectShow = {"PpEffect_1501"},
                        coinProduction = {1,100003,214},
                        storyId = 0,
                },

}
return ProsperityTable