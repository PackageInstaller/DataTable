---@class HomeActionTable
---@field public id integer
---@field public characterID integer
---@field public characterCondition table
---@field public roomType table
---@field public activateCondition table
---@field public probability integer
---@field public activateList table

---@type HomeActionTable[]
local HomeActionTable = {
                [8888801] = {
                        id = 8888801,
                        characterID = 0,
                        characterCondition = {{1,0,1}},
                        roomType = {},
                        activateCondition = {ConstructionLevelLimit={{10015,1}}},
                        probability = 10000,
                        activateList = {{10601,100}},
                },

                [8888802] = {
                        id = 8888802,
                        characterID = 0,
                        characterCondition = {{3,0,1}},
                        roomType = {},
                        activateCondition = {ConstructionLevelLimit={{10005,1}}},
                        probability = 10000,
                        activateList = {{10501,200},{10502,100}},
                },

                [8888803] = {
                        id = 8888803,
                        characterID = 0,
                        characterCondition = {{4,0,1}},
                        roomType = {},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{11001,100}},
                },

                [8888804] = {
                        id = 8888804,
                        characterID = 0,
                        characterCondition = {{2,0,1}},
                        roomType = {},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10801,500},{10802,100},{10803,100}},
                },

                [9999901] = {
                        id = 9999901,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {0},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{9001,100}},
                },

                [9999902] = {
                        id = 9999902,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10003},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10201,100}},
                },

                [9999903] = {
                        id = 9999903,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10004},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10202,100}},
                },

                [9999904] = {
                        id = 9999904,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10009},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10203,100}},
                },

                [9999905] = {
                        id = 9999905,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10011},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10204,100}},
                },

                [9999906] = {
                        id = 9999906,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10012},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10205,100}},
                },

                [9999907] = {
                        id = 9999907,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10013},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10206,100}},
                },

                [9999908] = {
                        id = 9999908,
                        characterID = 0,
                        characterCondition = {},
                        roomType = {10099},
                        activateCondition = {},
                        probability = 10000,
                        activateList = {{10701,100}},
                },

}
return HomeActionTable