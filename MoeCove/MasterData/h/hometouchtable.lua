---@class HomeTouchTable
---@field public id integer
---@field public character integer
---@field public actionResource string
---@field public bubbleResource string
---@field public voiceResource integer
---@field public basicWeight integer
---@field public dynamicWeight table

---@type HomeTouchTable[]
local HomeTouchTable = {
                [1000101] = {
                        id = 1000101,
                        character = 10001,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 101031,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000102] = {
                        id = 1000102,
                        character = 10001,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 101035,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000103] = {
                        id = 1000103,
                        character = 10001,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 101037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000201] = {
                        id = 1000201,
                        character = 10002,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 102031,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000202] = {
                        id = 1000202,
                        character = 10002,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 102037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000203] = {
                        id = 1000203,
                        character = 10002,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 102043,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000301] = {
                        id = 1000301,
                        character = 10003,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 103036,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000302] = {
                        id = 1000302,
                        character = 10003,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 103036,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000303] = {
                        id = 1000303,
                        character = 10003,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 103037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000401] = {
                        id = 1000401,
                        character = 10004,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 104028,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000402] = {
                        id = 1000402,
                        character = 10004,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 104035,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000403] = {
                        id = 1000403,
                        character = 10004,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 104037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000501] = {
                        id = 1000501,
                        character = 10005,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 105037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000502] = {
                        id = 1000502,
                        character = 10005,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 105040,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000503] = {
                        id = 1000503,
                        character = 10005,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 105041,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000601] = {
                        id = 1000601,
                        character = 10006,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 106042,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000602] = {
                        id = 1000602,
                        character = 10006,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 106042,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000603] = {
                        id = 1000603,
                        character = 10006,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 106042,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000701] = {
                        id = 1000701,
                        character = 10007,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 107035,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000702] = {
                        id = 1000702,
                        character = 10007,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 107038,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000703] = {
                        id = 1000703,
                        character = 10007,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 107039,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000801] = {
                        id = 1000801,
                        character = 10008,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 108042,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000802] = {
                        id = 1000802,
                        character = 10008,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 108043,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000803] = {
                        id = 1000803,
                        character = 10008,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 108043,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1000901] = {
                        id = 1000901,
                        character = 10009,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 109033,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1000902] = {
                        id = 1000902,
                        character = 10009,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 109034,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1000903] = {
                        id = 1000903,
                        character = 10009,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 109037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001001] = {
                        id = 1001001,
                        character = 10010,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110035,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001002] = {
                        id = 1001002,
                        character = 10010,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110036,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001003] = {
                        id = 1001003,
                        character = 10010,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001101] = {
                        id = 1001101,
                        character = 10011,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001102] = {
                        id = 1001102,
                        character = 10011,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001103] = {
                        id = 1001103,
                        character = 10011,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001201] = {
                        id = 1001201,
                        character = 10012,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001202] = {
                        id = 1001202,
                        character = 10012,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001203] = {
                        id = 1001203,
                        character = 10012,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001301] = {
                        id = 1001301,
                        character = 10013,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001302] = {
                        id = 1001302,
                        character = 10013,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001303] = {
                        id = 1001303,
                        character = 10013,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001401] = {
                        id = 1001401,
                        character = 10014,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001402] = {
                        id = 1001402,
                        character = 10014,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001403] = {
                        id = 1001403,
                        character = 10014,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001501] = {
                        id = 1001501,
                        character = 10015,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001502] = {
                        id = 1001502,
                        character = 10015,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001503] = {
                        id = 1001503,
                        character = 10015,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001601] = {
                        id = 1001601,
                        character = 10016,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001602] = {
                        id = 1001602,
                        character = 10016,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001603] = {
                        id = 1001603,
                        character = 10016,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001701] = {
                        id = 1001701,
                        character = 10017,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001702] = {
                        id = 1001702,
                        character = 10017,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001703] = {
                        id = 1001703,
                        character = 10017,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001801] = {
                        id = 1001801,
                        character = 10018,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001802] = {
                        id = 1001802,
                        character = 10018,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001803] = {
                        id = 1001803,
                        character = 10018,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1001901] = {
                        id = 1001901,
                        character = 10019,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1001902] = {
                        id = 1001902,
                        character = 10019,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1001903] = {
                        id = 1001903,
                        character = 10019,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002001] = {
                        id = 1002001,
                        character = 10020,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002002] = {
                        id = 1002002,
                        character = 10020,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002003] = {
                        id = 1002003,
                        character = 10020,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002101] = {
                        id = 1002101,
                        character = 10021,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002102] = {
                        id = 1002102,
                        character = 10021,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002103] = {
                        id = 1002103,
                        character = 10021,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002201] = {
                        id = 1002201,
                        character = 10022,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002202] = {
                        id = 1002202,
                        character = 10022,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002203] = {
                        id = 1002203,
                        character = 10022,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002701] = {
                        id = 1002701,
                        character = 10027,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002702] = {
                        id = 1002702,
                        character = 10027,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002703] = {
                        id = 1002703,
                        character = 10027,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002801] = {
                        id = 1002801,
                        character = 10028,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002802] = {
                        id = 1002802,
                        character = 10028,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002803] = {
                        id = 1002803,
                        character = 10028,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1002901] = {
                        id = 1002901,
                        character = 10029,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1002902] = {
                        id = 1002902,
                        character = 10029,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1002903] = {
                        id = 1002903,
                        character = 10029,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003001] = {
                        id = 1003001,
                        character = 10030,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003002] = {
                        id = 1003002,
                        character = 10030,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003003] = {
                        id = 1003003,
                        character = 10030,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003101] = {
                        id = 1003101,
                        character = 10031,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003102] = {
                        id = 1003102,
                        character = 10031,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003103] = {
                        id = 1003103,
                        character = 10031,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003201] = {
                        id = 1003201,
                        character = 10032,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003202] = {
                        id = 1003202,
                        character = 10032,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003203] = {
                        id = 1003203,
                        character = 10032,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003301] = {
                        id = 1003301,
                        character = 10033,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003302] = {
                        id = 1003302,
                        character = 10033,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003303] = {
                        id = 1003303,
                        character = 10033,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003701] = {
                        id = 1003701,
                        character = 10037,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003702] = {
                        id = 1003702,
                        character = 10037,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003703] = {
                        id = 1003703,
                        character = 10037,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003801] = {
                        id = 1003801,
                        character = 10038,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003802] = {
                        id = 1003802,
                        character = 10038,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003803] = {
                        id = 1003803,
                        character = 10038,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1003901] = {
                        id = 1003901,
                        character = 10039,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1003902] = {
                        id = 1003902,
                        character = 10039,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1003903] = {
                        id = 1003903,
                        character = 10039,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1004001] = {
                        id = 1004001,
                        character = 10040,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1004002] = {
                        id = 1004002,
                        character = 10040,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1004003] = {
                        id = 1004003,
                        character = 10040,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1004101] = {
                        id = 1004101,
                        character = 10041,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1004102] = {
                        id = 1004102,
                        character = 10041,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1004103] = {
                        id = 1004103,
                        character = 10041,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1004201] = {
                        id = 1004201,
                        character = 10042,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1004202] = {
                        id = 1004202,
                        character = 10042,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1004203] = {
                        id = 1004203,
                        character = 10042,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

                [1004301] = {
                        id = 1004301,
                        character = 10043,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{1,8},1,100}},
                },

                [1004302] = {
                        id = 1004302,
                        character = 10043,
                        actionResource = "TouchHappy",
                        bubbleResource = "shy",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,5},0,100}},
                },

                [1004303] = {
                        id = 1004303,
                        character = 10043,
                        actionResource = "TouchHappy",
                        bubbleResource = "love",
                        voiceResource = 110037,
                        basicWeight = 100,
                        dynamicWeight = {{1,{2,2},0,100},{1,{1,2},1,100}},
                },

}
return HomeTouchTable