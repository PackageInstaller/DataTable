---@class GachaGuarantTable
---@field public id integer
---@field public group integer
---@field public countGroupID integer
---@field public type integer
---@field public num integer
---@field public grandPrize integer
---@field public commonGuarant integer
---@field public limit table
---@field public gachaGroup integer

---@type GachaGuarantTable[]
local GachaGuarantTable = {
                [10001] = {
                        id = 10001,
                        group = 10001,
                        countGroupID = 100,
                        type = 1,
                        num = 1,
                        grandPrize = 1,
                        commonGuarant = 30,
                        limit = nil,
                        gachaGroup = 3001,
                },

                [10002] = {
                        id = 10002,
                        group = 10001,
                        countGroupID = 100,
                        type = 1,
                        num = 2,
                        grandPrize = 1,
                        commonGuarant = 50,
                        limit = nil,
                        gachaGroup = 3002,
                },

                [10003] = {
                        id = 10003,
                        group = 10001,
                        countGroupID = 100,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 3000,
                },

                [10004] = {
                        id = 10004,
                        group = 10001,
                        countGroupID = 200,
                        type = 1,
                        num = 1,
                        grandPrize = 1,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2001,
                },

                [10005] = {
                        id = 10005,
                        group = 10001,
                        countGroupID = 200,
                        type = 1,
                        num = 2,
                        grandPrize = 1,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2002,
                },

                [10006] = {
                        id = 10006,
                        group = 10001,
                        countGroupID = 200,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10007] = {
                        id = 10007,
                        group = 10001,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

                [10011] = {
                        id = 10011,
                        group = 20001,
                        countGroupID = 101,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 4001,
                },

                [10012] = {
                        id = 10012,
                        group = 20001,
                        countGroupID = 201,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10013] = {
                        id = 10013,
                        group = 20001,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

                [10021] = {
                        id = 10021,
                        group = 20002,
                        countGroupID = 101,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 4002,
                },

                [10022] = {
                        id = 10022,
                        group = 20002,
                        countGroupID = 201,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10023] = {
                        id = 10023,
                        group = 20002,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

                [10031] = {
                        id = 10031,
                        group = 20003,
                        countGroupID = 101,
                        type = 1,
                        num = 1,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 9000,
                },

                [10032] = {
                        id = 10032,
                        group = 20003,
                        countGroupID = 101,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 4003,
                },

                [10033] = {
                        id = 10033,
                        group = 20003,
                        countGroupID = 201,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10034] = {
                        id = 10034,
                        group = 20003,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

                [10041] = {
                        id = 10041,
                        group = 20004,
                        countGroupID = 101,
                        type = 1,
                        num = 1,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 9001,
                },

                [10042] = {
                        id = 10042,
                        group = 20004,
                        countGroupID = 101,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 4004,
                },

                [10043] = {
                        id = 10043,
                        group = 20004,
                        countGroupID = 201,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10044] = {
                        id = 10044,
                        group = 20004,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

                [10051] = {
                        id = 10051,
                        group = 20005,
                        countGroupID = 101,
                        type = 1,
                        num = 1,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 9002,
                },

                [10052] = {
                        id = 10052,
                        group = 20005,
                        countGroupID = 101,
                        type = 2,
                        num = 0,
                        grandPrize = 1,
                        commonGuarant = 80,
                        limit = nil,
                        gachaGroup = 4005,
                },

                [10053] = {
                        id = 10053,
                        group = 20005,
                        countGroupID = 201,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 10,
                        limit = nil,
                        gachaGroup = 2000,
                },

                [10054] = {
                        id = 10054,
                        group = 20005,
                        countGroupID = 300,
                        type = 2,
                        num = 0,
                        grandPrize = 0,
                        commonGuarant = 0,
                        limit = nil,
                        gachaGroup = 1000,
                },

}
return GachaGuarantTable