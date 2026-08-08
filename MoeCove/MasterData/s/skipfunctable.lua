---@class SkipFuncTable
---@field public id integer
---@field public process table
---@field public unlock table
---@field public specialShow integer
---@field public isClose integer
---@field public desc LocalStrEnum
---@field public specialSkip integer

---@type SkipFuncTable[]
local SkipFuncTable = {
                [9001] = {
                        id = 9001,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9001,
                        specialSkip = 0,
                },

                [9002] = {
                        id = 9002,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9002,
                        specialSkip = 0,
                },

                [9003] = {
                        id = 9003,
                        process = {{8,1}},
                        unlock = {1,1001},
                        specialShow = 0,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_9003,
                        specialSkip = 0,
                },

                [9004] = {
                        id = 9004,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9004,
                        specialSkip = 0,
                },

                [9005] = {
                        id = 9005,
                        process = {{15}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_9005,
                        specialSkip = 0,
                },

                [9006] = {
                        id = 9006,
                        process = {{16}},
                        unlock = nil,
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9006,
                        specialSkip = 0,
                },

                [9007] = {
                        id = 9007,
                        process = {{8,2}},
                        unlock = nil,
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9007,
                        specialSkip = 0,
                },

                [9008] = {
                        id = 9008,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_9008,
                        specialSkip = 0,
                },

                [9009] = {
                        id = 9009,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_9009,
                        specialSkip = 0,
                },

                [9901] = {
                        id = 9901,
                        process = {{24, {goodsId = 9901, minCount = 1}, true}},
                        unlock = nil,
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_9901,
                        specialSkip = 0,
                },

                [9902] = {
                        id = 9902,
                        process = {{}},
                        unlock = nil,
                        specialShow = 1,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_9902,
                        specialSkip = 0,
                },

                [110100] = {
                        id = 110100,
                        process = {{10,1001}},
                        unlock = {1,1001},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110100,
                        specialSkip = 0,
                },

                [110101] = {
                        id = 110101,
                        process = {{10,1001,10201}},
                        unlock = {2,10201},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110101,
                        specialSkip = 0,
                },

                [110102] = {
                        id = 110102,
                        process = {{10,1001,10202}},
                        unlock = {2,10202},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110102,
                        specialSkip = 0,
                },

                [110103] = {
                        id = 110103,
                        process = {{10,1001,10203}},
                        unlock = {2,10203},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110103,
                        specialSkip = 0,
                },

                [110104] = {
                        id = 110104,
                        process = {{10,1001,10204}},
                        unlock = {2,10204},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110104,
                        specialSkip = 0,
                },

                [110105] = {
                        id = 110105,
                        process = {{10,1001,10205}},
                        unlock = {2,10205},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110105,
                        specialSkip = 0,
                },

                [110106] = {
                        id = 110106,
                        process = {{10,1001,10206}},
                        unlock = {2,10206},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110106,
                        specialSkip = 0,
                },

                [110107] = {
                        id = 110107,
                        process = {{10,1001,10207}},
                        unlock = {2,10207},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110107,
                        specialSkip = 0,
                },

                [110108] = {
                        id = 110108,
                        process = {{10,1001,10208}},
                        unlock = {2,10208},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110108,
                        specialSkip = 0,
                },

                [110109] = {
                        id = 110109,
                        process = {{10,1001,10209}},
                        unlock = {2,10209},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110109,
                        specialSkip = 0,
                },

                [110110] = {
                        id = 110110,
                        process = {{10,1002,10301}},
                        unlock = {1,1002},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110110,
                        specialSkip = 0,
                },

                [110200] = {
                        id = 110200,
                        process = {{10,1002}},
                        unlock = {1,1002},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110200,
                        specialSkip = 0,
                },

                [110300] = {
                        id = 110300,
                        process = {{10,1003}},
                        unlock = {1,1003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110300,
                        specialSkip = 0,
                },

                [110400] = {
                        id = 110400,
                        process = {{10,1004}},
                        unlock = {1,1003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110400,
                        specialSkip = 0,
                },

                [110500] = {
                        id = 110500,
                        process = {{10,1005}},
                        unlock = {1,1003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_110500,
                        specialSkip = 0,
                },

                [210100] = {
                        id = 210100,
                        process = {{10,2001}},
                        unlock = {1,2001},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210100,
                        specialSkip = 0,
                },

                [210101] = {
                        id = 210101,
                        process = {{10,2001,20201}},
                        unlock = {2,20201},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210101,
                        specialSkip = 0,
                },

                [210102] = {
                        id = 210102,
                        process = {{10,2001,20203}},
                        unlock = {2,20203},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210102,
                        specialSkip = 0,
                },

                [210103] = {
                        id = 210103,
                        process = {{10,2001,20204}},
                        unlock = {2,20204},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210103,
                        specialSkip = 0,
                },

                [210104] = {
                        id = 210104,
                        process = {{10,2001,20205}},
                        unlock = {2,20205},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210104,
                        specialSkip = 0,
                },

                [210105] = {
                        id = 210105,
                        process = {{10,2001,20206}},
                        unlock = {2,20206},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210105,
                        specialSkip = 0,
                },

                [210106] = {
                        id = 210106,
                        process = {{10,2001,20207}},
                        unlock = {2,20207},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210106,
                        specialSkip = 0,
                },

                [210107] = {
                        id = 210107,
                        process = {{10,2001,20208}},
                        unlock = {2,20208},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210107,
                        specialSkip = 0,
                },

                [210200] = {
                        id = 210200,
                        process = {{10,2002}},
                        unlock = {1,2002},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210200,
                        specialSkip = 0,
                },

                [210201] = {
                        id = 210201,
                        process = {{10,2001,20301}},
                        unlock = {2,20301},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210201,
                        specialSkip = 0,
                },

                [210202] = {
                        id = 210202,
                        process = {{10,2001,20302}},
                        unlock = {2,20302},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210202,
                        specialSkip = 0,
                },

                [210203] = {
                        id = 210203,
                        process = {{10,2001,20304}},
                        unlock = {2,20304},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210203,
                        specialSkip = 0,
                },

                [210204] = {
                        id = 210204,
                        process = {{10,2001,20305}},
                        unlock = {2,20305},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210204,
                        specialSkip = 0,
                },

                [210205] = {
                        id = 210205,
                        process = {{10,2001,20306}},
                        unlock = {2,20306},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210205,
                        specialSkip = 0,
                },

                [210300] = {
                        id = 210300,
                        process = {{10,2003}},
                        unlock = {1,2003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210300,
                        specialSkip = 0,
                },

                [210301] = {
                        id = 210301,
                        process = {{10,2001,20401}},
                        unlock = {2,20401},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210301,
                        specialSkip = 0,
                },

                [210302] = {
                        id = 210302,
                        process = {{10,2001,20403}},
                        unlock = {2,20403},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210302,
                        specialSkip = 0,
                },

                [210303] = {
                        id = 210303,
                        process = {{10,2001,20405}},
                        unlock = {2,20405},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210303,
                        specialSkip = 0,
                },

                [210304] = {
                        id = 210304,
                        process = {{10,2001,20406}},
                        unlock = {2,20406},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210304,
                        specialSkip = 0,
                },

                [210305] = {
                        id = 210305,
                        process = {{10,2001,20407}},
                        unlock = {2,20407},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210305,
                        specialSkip = 0,
                },

                [210400] = {
                        id = 210400,
                        process = {{10,2004}},
                        unlock = {1,2003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210400,
                        specialSkip = 0,
                },

                [210401] = {
                        id = 210401,
                        process = {{10,2001,20501}},
                        unlock = {2,20501},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210401,
                        specialSkip = 0,
                },

                [210402] = {
                        id = 210402,
                        process = {{10,2001,20502}},
                        unlock = {2,20502},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210402,
                        specialSkip = 0,
                },

                [210403] = {
                        id = 210403,
                        process = {{10,2001,20503}},
                        unlock = {2,20503},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210403,
                        specialSkip = 0,
                },

                [210404] = {
                        id = 210404,
                        process = {{10,2001,20504}},
                        unlock = {2,20504},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210404,
                        specialSkip = 0,
                },

                [210405] = {
                        id = 210405,
                        process = {{10,2001,20506}},
                        unlock = {2,20506},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210405,
                        specialSkip = 0,
                },

                [210406] = {
                        id = 210406,
                        process = {{10,2001,20507}},
                        unlock = {2,20507},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210406,
                        specialSkip = 0,
                },

                [210500] = {
                        id = 210500,
                        process = {{10,2005}},
                        unlock = {1,2003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210500,
                        specialSkip = 0,
                },

                [210501] = {
                        id = 210501,
                        process = {{10,2001,20601}},
                        unlock = {2,20601},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210501,
                        specialSkip = 0,
                },

                [210502] = {
                        id = 210502,
                        process = {{10,2001,20602}},
                        unlock = {2,20602},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210502,
                        specialSkip = 0,
                },

                [210503] = {
                        id = 210503,
                        process = {{10,2001,20603}},
                        unlock = {2,20603},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210503,
                        specialSkip = 0,
                },

                [210504] = {
                        id = 210504,
                        process = {{10,2001,20604}},
                        unlock = {2,20604},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210504,
                        specialSkip = 0,
                },

                [210505] = {
                        id = 210505,
                        process = {{10,2001,20605}},
                        unlock = {2,20605},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210505,
                        specialSkip = 0,
                },

                [210506] = {
                        id = 210506,
                        process = {{10,2001,20606}},
                        unlock = {2,20606},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_210506,
                        specialSkip = 0,
                },

                [410000] = {
                        id = 410000,
                        process = {{8,2},{9,4,1}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410000,
                        specialSkip = 0,
                },

                [410001] = {
                        id = 410001,
                        process = {{8,2},{9,4,1,1}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410001,
                        specialSkip = 0,
                },

                [410002] = {
                        id = 410002,
                        process = {{8,2},{9,4,1,2}},
                        unlock = {2,43102},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410002,
                        specialSkip = 0,
                },

                [410003] = {
                        id = 410003,
                        process = {{8,2},{9,4,1,3}},
                        unlock = {2,43103},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410003,
                        specialSkip = 0,
                },

                [410004] = {
                        id = 410004,
                        process = {{8,2},{9,4,1,4}},
                        unlock = {2,43104},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410004,
                        specialSkip = 0,
                },

                [410005] = {
                        id = 410005,
                        process = {{8,2},{9,4,1,5}},
                        unlock = {2,43105},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410005,
                        specialSkip = 0,
                },

                [410006] = {
                        id = 410006,
                        process = {{8,2},{9,4,1,6}},
                        unlock = {2,43106},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410006,
                        specialSkip = 0,
                },

                [410007] = {
                        id = 410007,
                        process = {{8,2},{9,4,1,7}},
                        unlock = {2,43107},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410007,
                        specialSkip = 0,
                },

                [410008] = {
                        id = 410008,
                        process = {{8,2},{9,4,1,8}},
                        unlock = {2,43108},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410008,
                        specialSkip = 0,
                },

                [410009] = {
                        id = 410009,
                        process = {{8,2},{9,4,1,9}},
                        unlock = {2,43109},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410009,
                        specialSkip = 0,
                },

                [410010] = {
                        id = 410010,
                        process = {{8,2},{9,4,1,10}},
                        unlock = {2,43110},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_410010,
                        specialSkip = 0,
                },

                [420000] = {
                        id = 420000,
                        process = {{8,2},{9,4,2}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420000,
                        specialSkip = 0,
                },

                [420001] = {
                        id = 420001,
                        process = {{8,2},{9,4,2,1}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420001,
                        specialSkip = 0,
                },

                [420002] = {
                        id = 420002,
                        process = {{8,2},{9,4,2,2}},
                        unlock = {2,43202},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420002,
                        specialSkip = 0,
                },

                [420003] = {
                        id = 420003,
                        process = {{8,2},{9,4,2,3}},
                        unlock = {2,43203},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420003,
                        specialSkip = 0,
                },

                [420004] = {
                        id = 420004,
                        process = {{8,2},{9,4,2,4}},
                        unlock = {2,43204},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420004,
                        specialSkip = 0,
                },

                [420005] = {
                        id = 420005,
                        process = {{8,2},{9,4,2,5}},
                        unlock = {2,43205},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420005,
                        specialSkip = 0,
                },

                [420006] = {
                        id = 420006,
                        process = {{8,2},{9,4,2,6}},
                        unlock = {2,43206},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420006,
                        specialSkip = 0,
                },

                [420007] = {
                        id = 420007,
                        process = {{8,2},{9,4,2,7}},
                        unlock = {2,43207},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420007,
                        specialSkip = 0,
                },

                [420008] = {
                        id = 420008,
                        process = {{8,2},{9,4,2,8}},
                        unlock = {2,43208},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420008,
                        specialSkip = 0,
                },

                [420009] = {
                        id = 420009,
                        process = {{8,2},{9,4,2,9}},
                        unlock = {2,43209},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420009,
                        specialSkip = 0,
                },

                [420010] = {
                        id = 420010,
                        process = {{8,2},{9,4,2,10}},
                        unlock = {2,43210},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_420010,
                        specialSkip = 0,
                },

                [430000] = {
                        id = 430000,
                        process = {{8,2},{9,4,3}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430000,
                        specialSkip = 0,
                },

                [430001] = {
                        id = 430001,
                        process = {{8,2},{9,4,3,1}},
                        unlock = {3,4},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430001,
                        specialSkip = 0,
                },

                [430002] = {
                        id = 430002,
                        process = {{8,2},{9,4,3,2}},
                        unlock = {2,43302},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430002,
                        specialSkip = 0,
                },

                [430003] = {
                        id = 430003,
                        process = {{8,2},{9,4,3,3}},
                        unlock = {2,43303},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430003,
                        specialSkip = 0,
                },

                [430004] = {
                        id = 430004,
                        process = {{8,2},{9,4,3,4}},
                        unlock = {2,43304},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430004,
                        specialSkip = 0,
                },

                [430005] = {
                        id = 430005,
                        process = {{8,2},{9,4,3,5}},
                        unlock = {2,43305},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430005,
                        specialSkip = 0,
                },

                [430006] = {
                        id = 430006,
                        process = {{8,2},{9,4,3,6}},
                        unlock = {2,43306},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430006,
                        specialSkip = 0,
                },

                [430007] = {
                        id = 430007,
                        process = {{8,2},{9,4,3,7}},
                        unlock = {2,43307},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430007,
                        specialSkip = 0,
                },

                [430008] = {
                        id = 430008,
                        process = {{8,2},{9,4,3,8}},
                        unlock = {2,43308},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430008,
                        specialSkip = 0,
                },

                [430009] = {
                        id = 430009,
                        process = {{8,2},{9,4,3,9}},
                        unlock = {2,43309},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430009,
                        specialSkip = 0,
                },

                [430010] = {
                        id = 430010,
                        process = {{8,2},{9,4,3,10}},
                        unlock = {2,43310},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_430010,
                        specialSkip = 0,
                },

                [510001] = {
                        id = 510001,
                        process = {{8,2},{9,1,1,1}},
                        unlock = {3,3},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510001,
                        specialSkip = 0,
                },

                [510002] = {
                        id = 510002,
                        process = {{8,2},{9,1,1,2}},
                        unlock = {2,40102},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510002,
                        specialSkip = 0,
                },

                [510003] = {
                        id = 510003,
                        process = {{8,2},{9,1,1,3}},
                        unlock = {2,40103},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510003,
                        specialSkip = 0,
                },

                [510004] = {
                        id = 510004,
                        process = {{8,2},{9,1,1,4}},
                        unlock = {2,40104},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510004,
                        specialSkip = 0,
                },

                [510005] = {
                        id = 510005,
                        process = {{8,2},{9,1,1,5}},
                        unlock = {2,40105},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510005,
                        specialSkip = 0,
                },

                [510006] = {
                        id = 510006,
                        process = {{8,2},{9,1,1,6}},
                        unlock = {2,40106},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510006,
                        specialSkip = 0,
                },

                [510007] = {
                        id = 510007,
                        process = {{8,2},{9,1,1,7}},
                        unlock = {2,40107},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510007,
                        specialSkip = 0,
                },

                [510008] = {
                        id = 510008,
                        process = {{8,2},{9,1,1,8}},
                        unlock = {2,40108},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510008,
                        specialSkip = 0,
                },

                [510009] = {
                        id = 510009,
                        process = {{8,2},{9,1,1,9}},
                        unlock = {2,40109},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510009,
                        specialSkip = 0,
                },

                [510010] = {
                        id = 510010,
                        process = {{8,2},{9,1,1,10}},
                        unlock = {2,40110},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510010,
                        specialSkip = 0,
                },

                [510011] = {
                        id = 510011,
                        process = {{8,2},{9,1,1}},
                        unlock = {3,3},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_510011,
                        specialSkip = 0,
                },

                [610000] = {
                        id = 610000,
                        process = {{8,2},{9,2,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610000,
                        specialSkip = 0,
                },

                [610001] = {
                        id = 610001,
                        process = {{8,2},{9,2,1,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610001,
                        specialSkip = 0,
                },

                [610002] = {
                        id = 610002,
                        process = {{8,2},{9,2,1,2}},
                        unlock = {2,41102},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610002,
                        specialSkip = 0,
                },

                [610003] = {
                        id = 610003,
                        process = {{8,2},{9,2,1,3}},
                        unlock = {2,41103},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610003,
                        specialSkip = 0,
                },

                [610004] = {
                        id = 610004,
                        process = {{8,2},{9,2,1,4}},
                        unlock = {2,41104},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610004,
                        specialSkip = 0,
                },

                [610005] = {
                        id = 610005,
                        process = {{8,2},{9,2,1,5}},
                        unlock = {2,41105},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610005,
                        specialSkip = 0,
                },

                [610006] = {
                        id = 610006,
                        process = {{8,2},{9,2,1,6}},
                        unlock = {2,41106},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610006,
                        specialSkip = 0,
                },

                [610007] = {
                        id = 610007,
                        process = {{8,2},{9,2,1,7}},
                        unlock = {2,41107},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610007,
                        specialSkip = 0,
                },

                [610008] = {
                        id = 610008,
                        process = {{8,2},{9,2,1,8}},
                        unlock = {2,41108},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610008,
                        specialSkip = 0,
                },

                [610009] = {
                        id = 610009,
                        process = {{8,2},{9,2,1,9}},
                        unlock = {2,41109},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610009,
                        specialSkip = 0,
                },

                [610010] = {
                        id = 610010,
                        process = {{8,2},{9,2,1,10}},
                        unlock = {2,41110},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_610010,
                        specialSkip = 0,
                },

                [620000] = {
                        id = 620000,
                        process = {{8,2},{9,2,2}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620000,
                        specialSkip = 0,
                },

                [620001] = {
                        id = 620001,
                        process = {{8,2},{9,2,2,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620001,
                        specialSkip = 0,
                },

                [620002] = {
                        id = 620002,
                        process = {{8,2},{9,2,2,2}},
                        unlock = {2,41202},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620002,
                        specialSkip = 0,
                },

                [620003] = {
                        id = 620003,
                        process = {{8,2},{9,2,2,3}},
                        unlock = {2,41203},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620003,
                        specialSkip = 0,
                },

                [620004] = {
                        id = 620004,
                        process = {{8,2},{9,2,2,4}},
                        unlock = {2,41204},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620004,
                        specialSkip = 0,
                },

                [620005] = {
                        id = 620005,
                        process = {{8,2},{9,2,2,5}},
                        unlock = {2,41205},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620005,
                        specialSkip = 0,
                },

                [620006] = {
                        id = 620006,
                        process = {{8,2},{9,2,2,6}},
                        unlock = {2,41206},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620006,
                        specialSkip = 0,
                },

                [620007] = {
                        id = 620007,
                        process = {{8,2},{9,2,2,7}},
                        unlock = {2,41207},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620007,
                        specialSkip = 0,
                },

                [620008] = {
                        id = 620008,
                        process = {{8,2},{9,2,2,8}},
                        unlock = {2,41208},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620008,
                        specialSkip = 0,
                },

                [620009] = {
                        id = 620009,
                        process = {{8,2},{9,2,2,9}},
                        unlock = {2,41209},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620009,
                        specialSkip = 0,
                },

                [620010] = {
                        id = 620010,
                        process = {{8,2},{9,2,2,10}},
                        unlock = {2,41210},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_620010,
                        specialSkip = 0,
                },

                [630000] = {
                        id = 630000,
                        process = {{8,2},{9,2,3}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630000,
                        specialSkip = 0,
                },

                [630001] = {
                        id = 630001,
                        process = {{8,2},{9,2,3,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630001,
                        specialSkip = 0,
                },

                [630002] = {
                        id = 630002,
                        process = {{8,2},{9,2,3,2}},
                        unlock = {2,41302},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630002,
                        specialSkip = 0,
                },

                [630003] = {
                        id = 630003,
                        process = {{8,2},{9,2,3,3}},
                        unlock = {2,41303},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630003,
                        specialSkip = 0,
                },

                [630004] = {
                        id = 630004,
                        process = {{8,2},{9,2,3,4}},
                        unlock = {2,41304},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630004,
                        specialSkip = 0,
                },

                [630005] = {
                        id = 630005,
                        process = {{8,2},{9,2,3,5}},
                        unlock = {2,41305},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630005,
                        specialSkip = 0,
                },

                [630006] = {
                        id = 630006,
                        process = {{8,2},{9,2,3,6}},
                        unlock = {2,41306},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630006,
                        specialSkip = 0,
                },

                [630007] = {
                        id = 630007,
                        process = {{8,2},{9,2,3,7}},
                        unlock = {2,41307},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630007,
                        specialSkip = 0,
                },

                [630008] = {
                        id = 630008,
                        process = {{8,2},{9,2,3,8}},
                        unlock = {2,41308},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630008,
                        specialSkip = 0,
                },

                [630009] = {
                        id = 630009,
                        process = {{8,2},{9,2,3,9}},
                        unlock = {2,41309},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630009,
                        specialSkip = 0,
                },

                [630010] = {
                        id = 630010,
                        process = {{8,2},{9,2,3,10}},
                        unlock = {2,41310},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_630010,
                        specialSkip = 0,
                },

                [640000] = {
                        id = 640000,
                        process = {{8,2},{9,2,4}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640000,
                        specialSkip = 0,
                },

                [640001] = {
                        id = 640001,
                        process = {{8,2},{9,2,4,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640001,
                        specialSkip = 0,
                },

                [640002] = {
                        id = 640002,
                        process = {{8,2},{9,2,4,2}},
                        unlock = {2,41402},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640002,
                        specialSkip = 0,
                },

                [640003] = {
                        id = 640003,
                        process = {{8,2},{9,2,4,3}},
                        unlock = {2,41403},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640003,
                        specialSkip = 0,
                },

                [640004] = {
                        id = 640004,
                        process = {{8,2},{9,2,4,4}},
                        unlock = {2,41404},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640004,
                        specialSkip = 0,
                },

                [640005] = {
                        id = 640005,
                        process = {{8,2},{9,2,4,5}},
                        unlock = {2,41405},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640005,
                        specialSkip = 0,
                },

                [640006] = {
                        id = 640006,
                        process = {{8,2},{9,2,4,6}},
                        unlock = {2,41406},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640006,
                        specialSkip = 0,
                },

                [640007] = {
                        id = 640007,
                        process = {{8,2},{9,2,4,7}},
                        unlock = {2,41407},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640007,
                        specialSkip = 0,
                },

                [640008] = {
                        id = 640008,
                        process = {{8,2},{9,2,4,8}},
                        unlock = {2,41408},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640008,
                        specialSkip = 0,
                },

                [640009] = {
                        id = 640009,
                        process = {{8,2},{9,2,4,9}},
                        unlock = {2,41409},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640009,
                        specialSkip = 0,
                },

                [640010] = {
                        id = 640010,
                        process = {{8,2},{9,2,4,10}},
                        unlock = {2,41410},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_640010,
                        specialSkip = 0,
                },

                [650000] = {
                        id = 650000,
                        process = {{8,2},{9,2,5}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650000,
                        specialSkip = 0,
                },

                [650001] = {
                        id = 650001,
                        process = {{8,2},{9,2,5,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650001,
                        specialSkip = 0,
                },

                [650002] = {
                        id = 650002,
                        process = {{8,2},{9,2,5,2}},
                        unlock = {2,41502},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650002,
                        specialSkip = 0,
                },

                [650003] = {
                        id = 650003,
                        process = {{8,2},{9,2,5,3}},
                        unlock = {2,41503},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650003,
                        specialSkip = 0,
                },

                [650004] = {
                        id = 650004,
                        process = {{8,2},{9,2,5,4}},
                        unlock = {2,41504},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650004,
                        specialSkip = 0,
                },

                [650005] = {
                        id = 650005,
                        process = {{8,2},{9,2,5,5}},
                        unlock = {2,41505},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650005,
                        specialSkip = 0,
                },

                [650006] = {
                        id = 650006,
                        process = {{8,2},{9,2,5,6}},
                        unlock = {2,41506},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650006,
                        specialSkip = 0,
                },

                [650007] = {
                        id = 650007,
                        process = {{8,2},{9,2,5,7}},
                        unlock = {2,41507},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650007,
                        specialSkip = 0,
                },

                [650008] = {
                        id = 650008,
                        process = {{8,2},{9,2,5,8}},
                        unlock = {2,41508},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650008,
                        specialSkip = 0,
                },

                [650009] = {
                        id = 650009,
                        process = {{8,2},{9,2,5,9}},
                        unlock = {2,41509},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650009,
                        specialSkip = 0,
                },

                [650010] = {
                        id = 650010,
                        process = {{8,2},{9,2,5,10}},
                        unlock = {2,41510},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_650010,
                        specialSkip = 0,
                },

                [660000] = {
                        id = 660000,
                        process = {{8,2},{9,2,6}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660000,
                        specialSkip = 0,
                },

                [660001] = {
                        id = 660001,
                        process = {{8,2},{9,2,6,1}},
                        unlock = {3,5},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660001,
                        specialSkip = 0,
                },

                [660002] = {
                        id = 660002,
                        process = {{8,2},{9,2,6,2}},
                        unlock = {2,41602},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660002,
                        specialSkip = 0,
                },

                [660003] = {
                        id = 660003,
                        process = {{8,2},{9,2,6,3}},
                        unlock = {2,41603},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660003,
                        specialSkip = 0,
                },

                [660004] = {
                        id = 660004,
                        process = {{8,2},{9,2,6,4}},
                        unlock = {2,41604},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660004,
                        specialSkip = 0,
                },

                [660005] = {
                        id = 660005,
                        process = {{8,2},{9,2,6,5}},
                        unlock = {2,41605},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660005,
                        specialSkip = 0,
                },

                [660006] = {
                        id = 660006,
                        process = {{8,2},{9,2,6,6}},
                        unlock = {2,41606},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660006,
                        specialSkip = 0,
                },

                [660007] = {
                        id = 660007,
                        process = {{8,2},{9,2,6,7}},
                        unlock = {2,41607},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660007,
                        specialSkip = 0,
                },

                [660008] = {
                        id = 660008,
                        process = {{8,2},{9,2,6,8}},
                        unlock = {2,41608},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660008,
                        specialSkip = 0,
                },

                [660009] = {
                        id = 660009,
                        process = {{8,2},{9,2,6,9}},
                        unlock = {2,41609},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660009,
                        specialSkip = 0,
                },

                [660010] = {
                        id = 660010,
                        process = {{8,2},{9,2,6,10}},
                        unlock = {2,41610},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_660010,
                        specialSkip = 0,
                },

                [710000] = {
                        id = 710000,
                        process = {{8,2},{9,3,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710000,
                        specialSkip = 0,
                },

                [710001] = {
                        id = 710001,
                        process = {{8,2},{9,3,1,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710001,
                        specialSkip = 0,
                },

                [710002] = {
                        id = 710002,
                        process = {{8,2},{9,3,1,2}},
                        unlock = {2,42102},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710002,
                        specialSkip = 0,
                },

                [710003] = {
                        id = 710003,
                        process = {{8,2},{9,3,1,3}},
                        unlock = {2,42103},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710003,
                        specialSkip = 0,
                },

                [710004] = {
                        id = 710004,
                        process = {{8,2},{9,3,1,4}},
                        unlock = {2,42104},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710004,
                        specialSkip = 0,
                },

                [710005] = {
                        id = 710005,
                        process = {{8,2},{9,3,1,5}},
                        unlock = {2,42105},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710005,
                        specialSkip = 0,
                },

                [710006] = {
                        id = 710006,
                        process = {{8,2},{9,3,1,6}},
                        unlock = {2,42106},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710006,
                        specialSkip = 0,
                },

                [710007] = {
                        id = 710007,
                        process = {{8,2},{9,3,1,7}},
                        unlock = {2,42107},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710007,
                        specialSkip = 0,
                },

                [710008] = {
                        id = 710008,
                        process = {{8,2},{9,3,1,8}},
                        unlock = {2,42108},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710008,
                        specialSkip = 0,
                },

                [710009] = {
                        id = 710009,
                        process = {{8,2},{9,3,1,9}},
                        unlock = {2,42109},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710009,
                        specialSkip = 0,
                },

                [710010] = {
                        id = 710010,
                        process = {{8,2},{9,3,1,10}},
                        unlock = {2,42110},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_710010,
                        specialSkip = 0,
                },

                [720000] = {
                        id = 720000,
                        process = {{8,2},{9,3,2}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720000,
                        specialSkip = 0,
                },

                [720001] = {
                        id = 720001,
                        process = {{8,2},{9,3,2,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720001,
                        specialSkip = 0,
                },

                [720002] = {
                        id = 720002,
                        process = {{8,2},{9,3,2,2}},
                        unlock = {2,42202},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720002,
                        specialSkip = 0,
                },

                [720003] = {
                        id = 720003,
                        process = {{8,2},{9,3,2,3}},
                        unlock = {2,42203},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720003,
                        specialSkip = 0,
                },

                [720004] = {
                        id = 720004,
                        process = {{8,2},{9,3,2,4}},
                        unlock = {2,42204},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720004,
                        specialSkip = 0,
                },

                [720005] = {
                        id = 720005,
                        process = {{8,2},{9,3,2,5}},
                        unlock = {2,42205},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720005,
                        specialSkip = 0,
                },

                [720006] = {
                        id = 720006,
                        process = {{8,2},{9,3,2,6}},
                        unlock = {2,42206},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720006,
                        specialSkip = 0,
                },

                [720007] = {
                        id = 720007,
                        process = {{8,2},{9,3,2,7}},
                        unlock = {2,42207},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720007,
                        specialSkip = 0,
                },

                [720008] = {
                        id = 720008,
                        process = {{8,2},{9,3,2,8}},
                        unlock = {2,42208},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720008,
                        specialSkip = 0,
                },

                [720009] = {
                        id = 720009,
                        process = {{8,2},{9,3,2,9}},
                        unlock = {2,42209},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720009,
                        specialSkip = 0,
                },

                [720010] = {
                        id = 720010,
                        process = {{8,2},{9,3,2,10}},
                        unlock = {2,42210},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_720010,
                        specialSkip = 0,
                },

                [730000] = {
                        id = 730000,
                        process = {{8,2},{9,3,3}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730000,
                        specialSkip = 0,
                },

                [730001] = {
                        id = 730001,
                        process = {{8,2},{9,3,3,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730001,
                        specialSkip = 0,
                },

                [730002] = {
                        id = 730002,
                        process = {{8,2},{9,3,3,2}},
                        unlock = {2,42302},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730002,
                        specialSkip = 0,
                },

                [730003] = {
                        id = 730003,
                        process = {{8,2},{9,3,3,3}},
                        unlock = {2,42303},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730003,
                        specialSkip = 0,
                },

                [730004] = {
                        id = 730004,
                        process = {{8,2},{9,3,3,4}},
                        unlock = {2,42304},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730004,
                        specialSkip = 0,
                },

                [730005] = {
                        id = 730005,
                        process = {{8,2},{9,3,3,5}},
                        unlock = {2,42305},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730005,
                        specialSkip = 0,
                },

                [730006] = {
                        id = 730006,
                        process = {{8,2},{9,3,3,6}},
                        unlock = {2,42306},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730006,
                        specialSkip = 0,
                },

                [730007] = {
                        id = 730007,
                        process = {{8,2},{9,3,3,7}},
                        unlock = {2,42307},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730007,
                        specialSkip = 0,
                },

                [730008] = {
                        id = 730008,
                        process = {{8,2},{9,3,3,8}},
                        unlock = {2,42308},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730008,
                        specialSkip = 0,
                },

                [730009] = {
                        id = 730009,
                        process = {{8,2},{9,3,3,9}},
                        unlock = {2,42309},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730009,
                        specialSkip = 0,
                },

                [730010] = {
                        id = 730010,
                        process = {{8,2},{9,3,3,10}},
                        unlock = {2,42310},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_730010,
                        specialSkip = 0,
                },

                [740000] = {
                        id = 740000,
                        process = {{8,2},{9,3,4}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740000,
                        specialSkip = 0,
                },

                [740001] = {
                        id = 740001,
                        process = {{8,2},{9,3,4,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740001,
                        specialSkip = 0,
                },

                [740002] = {
                        id = 740002,
                        process = {{8,2},{9,3,4,2}},
                        unlock = {2,42402},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740002,
                        specialSkip = 0,
                },

                [740003] = {
                        id = 740003,
                        process = {{8,2},{9,3,4,3}},
                        unlock = {2,42403},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740003,
                        specialSkip = 0,
                },

                [740004] = {
                        id = 740004,
                        process = {{8,2},{9,3,4,4}},
                        unlock = {2,42404},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740004,
                        specialSkip = 0,
                },

                [740005] = {
                        id = 740005,
                        process = {{8,2},{9,3,4,5}},
                        unlock = {2,42405},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740005,
                        specialSkip = 0,
                },

                [740006] = {
                        id = 740006,
                        process = {{8,2},{9,3,4,6}},
                        unlock = {2,42406},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740006,
                        specialSkip = 0,
                },

                [740007] = {
                        id = 740007,
                        process = {{8,2},{9,3,4,7}},
                        unlock = {2,42407},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740007,
                        specialSkip = 0,
                },

                [740008] = {
                        id = 740008,
                        process = {{8,2},{9,3,4,8}},
                        unlock = {2,42408},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740008,
                        specialSkip = 0,
                },

                [740009] = {
                        id = 740009,
                        process = {{8,2},{9,3,4,9}},
                        unlock = {2,42409},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740009,
                        specialSkip = 0,
                },

                [740010] = {
                        id = 740010,
                        process = {{8,2},{9,3,4,10}},
                        unlock = {2,42410},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_740010,
                        specialSkip = 0,
                },

                [750000] = {
                        id = 750000,
                        process = {{8,2},{9,3,5}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750000,
                        specialSkip = 0,
                },

                [750001] = {
                        id = 750001,
                        process = {{8,2},{9,3,5,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750001,
                        specialSkip = 0,
                },

                [750002] = {
                        id = 750002,
                        process = {{8,2},{9,3,5,2}},
                        unlock = {2,42502},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750002,
                        specialSkip = 0,
                },

                [750003] = {
                        id = 750003,
                        process = {{8,2},{9,3,5,3}},
                        unlock = {2,42503},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750003,
                        specialSkip = 0,
                },

                [750004] = {
                        id = 750004,
                        process = {{8,2},{9,3,5,4}},
                        unlock = {2,42504},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750004,
                        specialSkip = 0,
                },

                [750005] = {
                        id = 750005,
                        process = {{8,2},{9,3,5,5}},
                        unlock = {2,42505},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750005,
                        specialSkip = 0,
                },

                [750006] = {
                        id = 750006,
                        process = {{8,2},{9,3,5,6}},
                        unlock = {2,42506},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750006,
                        specialSkip = 0,
                },

                [750007] = {
                        id = 750007,
                        process = {{8,2},{9,3,5,7}},
                        unlock = {2,42507},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750007,
                        specialSkip = 0,
                },

                [750008] = {
                        id = 750008,
                        process = {{8,2},{9,3,5,8}},
                        unlock = {2,42508},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750008,
                        specialSkip = 0,
                },

                [750009] = {
                        id = 750009,
                        process = {{8,2},{9,3,5,9}},
                        unlock = {2,42509},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750009,
                        specialSkip = 0,
                },

                [750010] = {
                        id = 750010,
                        process = {{8,2},{9,3,5,10}},
                        unlock = {2,42510},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_750010,
                        specialSkip = 0,
                },

                [760000] = {
                        id = 760000,
                        process = {{8,2},{9,3,6}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760000,
                        specialSkip = 0,
                },

                [760001] = {
                        id = 760001,
                        process = {{8,2},{9,3,6,1}},
                        unlock = {3,6},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760001,
                        specialSkip = 0,
                },

                [760002] = {
                        id = 760002,
                        process = {{8,2},{9,3,6,2}},
                        unlock = {2,42602},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760002,
                        specialSkip = 0,
                },

                [760003] = {
                        id = 760003,
                        process = {{8,2},{9,3,6,3}},
                        unlock = {2,42603},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760003,
                        specialSkip = 0,
                },

                [760004] = {
                        id = 760004,
                        process = {{8,2},{9,3,6,4}},
                        unlock = {2,42604},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760004,
                        specialSkip = 0,
                },

                [760005] = {
                        id = 760005,
                        process = {{8,2},{9,3,6,5}},
                        unlock = {2,42605},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760005,
                        specialSkip = 0,
                },

                [760006] = {
                        id = 760006,
                        process = {{8,2},{9,3,6,6}},
                        unlock = {2,42606},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760006,
                        specialSkip = 0,
                },

                [760007] = {
                        id = 760007,
                        process = {{8,2},{9,3,6,7}},
                        unlock = {2,42607},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760007,
                        specialSkip = 0,
                },

                [760008] = {
                        id = 760008,
                        process = {{8,2},{9,3,6,8}},
                        unlock = {2,42608},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760008,
                        specialSkip = 0,
                },

                [760009] = {
                        id = 760009,
                        process = {{8,2},{9,3,6,9}},
                        unlock = {2,42609},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760009,
                        specialSkip = 0,
                },

                [760010] = {
                        id = 760010,
                        process = {{8,2},{9,3,6,10}},
                        unlock = {2,42610},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_760010,
                        specialSkip = 0,
                },

                [800000] = {
                        id = 800000,
                        process = {{1}},
                        unlock = {3,13},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_800000,
                        specialSkip = 0,
                },

                [810001] = {
                        id = 810001,
                        process = {{1},{2,1}},
                        unlock = {3,14},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_810001,
                        specialSkip = 0,
                },

                [820001] = {
                        id = 820001,
                        process = {{1},{2,2}},
                        unlock = {3,15},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_820001,
                        specialSkip = 0,
                },

                [830001] = {
                        id = 830001,
                        process = {{1},{2,3}},
                        unlock = {3,16},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_830001,
                        specialSkip = 0,
                },

                [840001] = {
                        id = 840001,
                        process = {{1},{2,4}},
                        unlock = {3,17},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_840001,
                        specialSkip = 0,
                },

                [910001] = {
                        id = 910001,
                        process = {{5,140001}},
                        unlock = {3,19},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_910001,
                        specialSkip = 0,
                },

                [920001] = {
                        id = 920001,
                        process = {{6}},
                        unlock = {3,20},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_920001,
                        specialSkip = 0,
                },

                [1010001] = {
                        id = 1010001,
                        process = {{3}},
                        unlock = {3,9},
                        specialShow = 0,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_1010001,
                        specialSkip = 0,
                },

                [1110001] = {
                        id = 1110001,
                        process = {{7,2}},
                        unlock = {3,12},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1110001,
                        specialSkip = 0,
                },

                [1210001] = {
                        id = 1210001,
                        process = {{8,3},{11}},
                        unlock = {3,8},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1210001,
                        specialSkip = 0,
                },

                [1310001] = {
                        id = 1310001,
                        process = {{12,20002}},
                        unlock = {3,23},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310001,
                        specialSkip = 0,
                },

                [1310002] = {
                        id = 1310002,
                        process = {{12,20003}},
                        unlock = {3,99},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310002,
                        specialSkip = 0,
                },

                [1310003] = {
                        id = 1310003,
                        process = {{12,20004}},
                        unlock = {3,23},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310003,
                        specialSkip = 0,
                },

                [1310004] = {
                        id = 1310004,
                        process = {{12,20001}},
                        unlock = {3,23},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310004,
                        specialSkip = 0,
                },

                [1310005] = {
                        id = 1310005,
                        process = {{12,20005}},
                        unlock = {3,23},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310005,
                        specialSkip = 0,
                },

                [1310006] = {
                        id = 1310006,
                        process = {{12,20006}},
                        unlock = {3,23},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1310006,
                        specialSkip = 0,
                },

                [1410001] = {
                        id = 1410001,
                        process = {{13,10002}},
                        unlock = {3,22},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410001,
                        specialSkip = 0,
                },

                [1410002] = {
                        id = 1410002,
                        process = {{13,10003}},
                        unlock = {3,10003},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410002,
                        specialSkip = 0,
                },

                [1410003] = {
                        id = 1410003,
                        process = {{13,10004}},
                        unlock = {3,22},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410003,
                        specialSkip = 0,
                },

                [1410004] = {
                        id = 1410004,
                        process = {{4,{1,10009}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410004,
                        specialSkip = 0,
                },

                [1410005] = {
                        id = 1410005,
                        process = {{4,{2,10003}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410005,
                        specialSkip = 0,
                },

                [1410006] = {
                        id = 1410006,
                        process = {{4,{3,10010}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410006,
                        specialSkip = 0,
                },

                [1410007] = {
                        id = 1410007,
                        process = {{4,{3,10011}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410007,
                        specialSkip = 0,
                },

                [1410008] = {
                        id = 1410008,
                        process = {{4,{3,10012}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410008,
                        specialSkip = 0,
                },

                [1410009] = {
                        id = 1410009,
                        process = {{4,{3,10013}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410009,
                        specialSkip = 0,
                },

                [1410010] = {
                        id = 1410010,
                        process = {{22}},
                        unlock = {3,35},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410010,
                        specialSkip = 0,
                },

                [1410011] = {
                        id = 1410011,
                        process = {{4,{1,10009}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410011,
                        specialSkip = 0,
                },

                [1410012] = {
                        id = 1410012,
                        process = {{4,{4,10018}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410012,
                        specialSkip = 0,
                },

                [1410013] = {
                        id = 1410013,
                        process = {{4,{5,10006}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410013,
                        specialSkip = 0,
                },

                [1410021] = {
                        id = 1410021,
                        process = {{13,10005}},
                        unlock = {3,22},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410021,
                        specialSkip = 0,
                },

                [1410031] = {
                        id = 1410031,
                        process = {{15},{25}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1410031,
                        specialSkip = 0,
                },

                [1510001] = {
                        id = 1510001,
                        process = {{18}},
                        unlock = {3,21},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1510001,
                        specialSkip = 0,
                },

                [1610001] = {
                        id = 1610001,
                        process = {{17,5}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1610001,
                        specialSkip = 0,
                },

                [1610002] = {
                        id = 1610002,
                        process = {{17,1}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1610002,
                        specialSkip = 0,
                },

                [1610003] = {
                        id = 1610003,
                        process = {{17,2}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1610003,
                        specialSkip = 0,
                },

                [1910001] = {
                        id = 1910001,
                        process = {{19,60001}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_1910001,
                        specialSkip = 0,
                },

                [2000001] = {
                        id = 2000001,
                        process = {{15},{20,{1,10009}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000001,
                        specialSkip = 1,
                },

                [2000002] = {
                        id = 2000002,
                        process = {{15},{20,{2,10003}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000002,
                        specialSkip = 1,
                },

                [2000003] = {
                        id = 2000003,
                        process = {{15},{20,{3,10010}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000003,
                        specialSkip = 1,
                },

                [2000004] = {
                        id = 2000004,
                        process = {{15},{20,{3,10011}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000004,
                        specialSkip = 1,
                },

                [2000005] = {
                        id = 2000005,
                        process = {{15},{20,{3,10012}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000005,
                        specialSkip = 1,
                },

                [2000006] = {
                        id = 2000006,
                        process = {{15},{20,{3,10013}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000006,
                        specialSkip = 1,
                },

                [2000007] = {
                        id = 2000007,
                        process = {{15},{20,{4,10018}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000007,
                        specialSkip = 1,
                },

                [2000008] = {
                        id = 2000008,
                        process = {{15},{20,{5,10006}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000008,
                        specialSkip = 1,
                },

                [2000011] = {
                        id = 2000011,
                        process = {{15},{4,{4,10018}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000011,
                        specialSkip = 1,
                },

                [2000012] = {
                        id = 2000012,
                        process = {{15},{4,{1,10009}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000012,
                        specialSkip = 1,
                },

                [2000013] = {
                        id = 2000013,
                        process = {{15},{4,{2,10003}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000013,
                        specialSkip = 1,
                },

                [2000014] = {
                        id = 2000014,
                        process = {{15},{4,{3,10010}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000014,
                        specialSkip = 1,
                },

                [2000015] = {
                        id = 2000015,
                        process = {{15},{4,{3,10011}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000015,
                        specialSkip = 1,
                },

                [2000016] = {
                        id = 2000016,
                        process = {{15},{4,{3,10012}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000016,
                        specialSkip = 1,
                },

                [2000017] = {
                        id = 2000017,
                        process = {{15},{4,{3,10013}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000017,
                        specialSkip = 1,
                },

                [2000018] = {
                        id = 2000018,
                        process = {{15},{4,{5,10006}}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2000018,
                        specialSkip = 1,
                },

                [2000019] = {
                        id = 2000019,
                        process = {{15},{22}},
                        unlock = {},
                        specialShow = 0,
                        isClose = 1,
                        desc = LocalStrEnum.SkipFunc_2000019,
                        specialSkip = 1,
                },

                [2100001] = {
                        id = 2100001,
                        process = {{8,3},{21}},
                        unlock = {3,26},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2100001,
                        specialSkip = 0,
                },

                [2200001] = {
                        id = 2200001,
                        process = {{23,160001}},
                        unlock = {4,160001,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200001,
                        specialSkip = 0,
                },

                [2200002] = {
                        id = 2200002,
                        process = {{23,160002}},
                        unlock = {4,160002,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200002,
                        specialSkip = 0,
                },

                [2200003] = {
                        id = 2200003,
                        process = {{23,160003}},
                        unlock = {4,160003,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200003,
                        specialSkip = 0,
                },

                [2200004] = {
                        id = 2200004,
                        process = {{23,160004}},
                        unlock = {4,160004,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200004,
                        specialSkip = 0,
                },

                [2200005] = {
                        id = 2200005,
                        process = {{23,160005}},
                        unlock = {4,160005,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200005,
                        specialSkip = 0,
                },

                [2200006] = {
                        id = 2200006,
                        process = {{23,160006}},
                        unlock = {4,160006,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200006,
                        specialSkip = 0,
                },

                [2200007] = {
                        id = 2200007,
                        process = {{23,160007}},
                        unlock = {4,160007,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200007,
                        specialSkip = 0,
                },

                [2200008] = {
                        id = 2200008,
                        process = {{23,160008}},
                        unlock = {4,160008,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200008,
                        specialSkip = 0,
                },

                [2200009] = {
                        id = 2200009,
                        process = {{23,160009}},
                        unlock = {4,160009,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200009,
                        specialSkip = 0,
                },

                [2200010] = {
                        id = 2200010,
                        process = {{23,160010}},
                        unlock = {4,160010,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200010,
                        specialSkip = 0,
                },

                [2200011] = {
                        id = 2200011,
                        process = {{23,160011}},
                        unlock = {4,160011,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200011,
                        specialSkip = 0,
                },

                [2200012] = {
                        id = 2200012,
                        process = {{23,160012}},
                        unlock = {4,160012,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200012,
                        specialSkip = 0,
                },

                [2200013] = {
                        id = 2200013,
                        process = {{23,160013}},
                        unlock = {4,160013,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200013,
                        specialSkip = 0,
                },

                [2200014] = {
                        id = 2200014,
                        process = {{23,160014}},
                        unlock = {4,160014,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200014,
                        specialSkip = 0,
                },

                [2200015] = {
                        id = 2200015,
                        process = {{23,160015}},
                        unlock = {4,160015,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200015,
                        specialSkip = 0,
                },

                [2200016] = {
                        id = 2200016,
                        process = {{23,160016}},
                        unlock = {4,160016,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200016,
                        specialSkip = 0,
                },

                [2200017] = {
                        id = 2200017,
                        process = {{23,160017}},
                        unlock = {4,160017,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200017,
                        specialSkip = 0,
                },

                [2200018] = {
                        id = 2200018,
                        process = {{23,160018}},
                        unlock = {4,160018,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200018,
                        specialSkip = 0,
                },

                [2200019] = {
                        id = 2200019,
                        process = {{23,160019}},
                        unlock = {4,160019,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200019,
                        specialSkip = 0,
                },

                [2200020] = {
                        id = 2200020,
                        process = {{23,160020}},
                        unlock = {4,160020,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200020,
                        specialSkip = 0,
                },

                [2200021] = {
                        id = 2200021,
                        process = {{23,160021}},
                        unlock = {4,160021,1},
                        specialShow = 0,
                        isClose = 0,
                        desc = LocalStrEnum.SkipFunc_2200021,
                        specialSkip = 0,
                },

}
return SkipFuncTable