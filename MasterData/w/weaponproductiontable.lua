---@class WeaponProductionTable
---@field public id integer
---@field public blueprintName LocalStrEnum
---@field public blueprintRare integer
---@field public itemId integer
---@field public useType integer
---@field public commonCost table
---@field public ExtraCost table
---@field public produceShow table
---@field public produce integer
---@field public ExtraProduce table

---@type WeaponProductionTable[]
local WeaponProductionTable = {
                [110003] = {
                        id = 110003,
                        blueprintName = LocalStrEnum.blueprintName_110003,
                        blueprintRare = 4,
                        itemId = 140103,
                        useType = 2,
                        commonCost = {{100006,2000},{100007,3600},{100009,3600},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {440101,440102},
                        produce = 231003,
                        ExtraProduce = {230103},
                },

                [120003] = {
                        id = 120003,
                        blueprintName = LocalStrEnum.blueprintName_120003,
                        blueprintRare = 4,
                        itemId = 140203,
                        useType = 2,
                        commonCost = {{100006,2000},{100007,3000},{100009,3000},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {440201,440202},
                        produce = 232003,
                        ExtraProduce = {230103},
                },

                [130003] = {
                        id = 130003,
                        blueprintName = LocalStrEnum.blueprintName_130003,
                        blueprintRare = 4,
                        itemId = 140303,
                        useType = 2,
                        commonCost = {{100006,2000},{100007,2400},{100009,2400},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {440301,440302},
                        produce = 233003,
                        ExtraProduce = {230103},
                },

                [140003] = {
                        id = 140003,
                        blueprintName = LocalStrEnum.blueprintName_140003,
                        blueprintRare = 4,
                        itemId = 140403,
                        useType = 2,
                        commonCost = {{100006,3000},{100007,3000},{100009,2400},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {440401,440402},
                        produce = 234003,
                        ExtraProduce = {230103},
                },

                [150003] = {
                        id = 150003,
                        blueprintName = LocalStrEnum.blueprintName_150003,
                        blueprintRare = 4,
                        itemId = 140503,
                        useType = 2,
                        commonCost = {{100006,3000},{100007,2000},{100009,2400},{100008,3600}},
                        ExtraCost = {100003,2000},
                        produceShow = {440501,440502},
                        produce = 235003,
                        ExtraProduce = {230103},
                },

                [160003] = {
                        id = 160003,
                        blueprintName = LocalStrEnum.blueprintName_160003,
                        blueprintRare = 4,
                        itemId = 140603,
                        useType = 2,
                        commonCost = {{100006,3000},{100007,2000},{100009,2400},{100008,3600}},
                        ExtraCost = {100003,2000},
                        produceShow = {440601,440602},
                        produce = 236003,
                        ExtraProduce = {230103},
                },

                [170003] = {
                        id = 170003,
                        blueprintName = LocalStrEnum.blueprintName_170003,
                        blueprintRare = 4,
                        itemId = 140703,
                        useType = 2,
                        commonCost = {{100006,3000},{100007,2000},{100009,2400},{100008,3600}},
                        ExtraCost = {100003,2000},
                        produceShow = {440701,440702},
                        produce = 237003,
                        ExtraProduce = {230103},
                },

                [180003] = {
                        id = 180003,
                        blueprintName = LocalStrEnum.blueprintName_180003,
                        blueprintRare = 4,
                        itemId = 140803,
                        useType = 2,
                        commonCost = {{100006,3000},{100007,3000},{100009,2400},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {440801,440802},
                        produce = 238003,
                        ExtraProduce = {230103},
                },

                [110004] = {
                        id = 110004,
                        blueprintName = LocalStrEnum.blueprintName_110004,
                        blueprintRare = 5,
                        itemId = 140104,
                        useType = 2,
                        commonCost = {{100006,5000},{100007,9000},{100009,9000},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450101,450102,450103},
                        produce = 231004,
                        ExtraProduce = {230104},
                },

                [120004] = {
                        id = 120004,
                        blueprintName = LocalStrEnum.blueprintName_120004,
                        blueprintRare = 5,
                        itemId = 140204,
                        useType = 2,
                        commonCost = {{100006,5000},{100007,7500},{100009,7500},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450201,450202,450203},
                        produce = 232004,
                        ExtraProduce = {230104},
                },

                [130004] = {
                        id = 130004,
                        blueprintName = LocalStrEnum.blueprintName_130004,
                        blueprintRare = 5,
                        itemId = 140304,
                        useType = 2,
                        commonCost = {{100006,5000},{100007,6000},{100009,6000},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450301,450302,450303},
                        produce = 233004,
                        ExtraProduce = {230104},
                },

                [140004] = {
                        id = 140004,
                        blueprintName = LocalStrEnum.blueprintName_140004,
                        blueprintRare = 5,
                        itemId = 140404,
                        useType = 2,
                        commonCost = {{100006,7500},{100007,7500},{100009,6000},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450401,450402,450403},
                        produce = 234004,
                        ExtraProduce = {230104},
                },

                [150004] = {
                        id = 150004,
                        blueprintName = LocalStrEnum.blueprintName_150004,
                        blueprintRare = 5,
                        itemId = 140504,
                        useType = 2,
                        commonCost = {{100006,7500},{100007,5000},{100009,6000},{100008,9000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450501,450502,450503},
                        produce = 235004,
                        ExtraProduce = {230104},
                },

                [160004] = {
                        id = 160004,
                        blueprintName = LocalStrEnum.blueprintName_160004,
                        blueprintRare = 5,
                        itemId = 140604,
                        useType = 2,
                        commonCost = {{100006,7500},{100007,5000},{100009,6000},{100008,9000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450601,450602,450603},
                        produce = 236004,
                        ExtraProduce = {230104},
                },

                [170004] = {
                        id = 170004,
                        blueprintName = LocalStrEnum.blueprintName_170004,
                        blueprintRare = 5,
                        itemId = 140704,
                        useType = 2,
                        commonCost = {{100006,7500},{100007,5000},{100009,6000},{100008,9000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450701,450702,450703},
                        produce = 237004,
                        ExtraProduce = {230104},
                },

                [180004] = {
                        id = 180004,
                        blueprintName = LocalStrEnum.blueprintName_180004,
                        blueprintRare = 5,
                        itemId = 140804,
                        useType = 2,
                        commonCost = {{100006,7500},{100007,7500},{100009,6000},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {450801,450802,450803},
                        produce = 238004,
                        ExtraProduce = {230104},
                },

                [200001] = {
                        id = 200001,
                        blueprintName = LocalStrEnum.blueprintName_200001,
                        blueprintRare = 2,
                        itemId = 140001,
                        useType = 1,
                        commonCost = {{100006,800},{100007,800},{100009,800},{100008,800}},
                        ExtraCost = {100003,800},
                        produceShow = {410101,410201,410301,410401,410501,410601,410701,410801,420101,420201,420301,420401,420501,420601,420702,420801},
                        produce = 230001,
                        ExtraProduce = {230101},
                },

                [210001] = {
                        id = 210001,
                        blueprintName = LocalStrEnum.blueprintName_210001,
                        blueprintRare = 3,
                        itemId = 140002,
                        useType = 1,
                        commonCost = {{100006,1000},{100007,1000},{100009,1000},{100008,1000}},
                        ExtraCost = {100003,1000},
                        produceShow = {420101,420201,420301,420401,420501,420601,420702,420801,430101,430201,430301,430401,430501,430601,430701,430801},
                        produce = 230002,
                        ExtraProduce = {230102},
                },

                [220001] = {
                        id = 220001,
                        blueprintName = LocalStrEnum.blueprintName_220001,
                        blueprintRare = 4,
                        itemId = 140003,
                        useType = 1,
                        commonCost = {{100006,2000},{100007,2000},{100009,2000},{100008,2000}},
                        ExtraCost = {100003,2000},
                        produceShow = {430101,430201,430301,430401,430501,430601,430701,430801,440101,440102,440201,440202,440301,440302,440401,440402,440501,440502,440601,440602,440701,440702,440801,440802},
                        produce = 230003,
                        ExtraProduce = {230103},
                },

                [230001] = {
                        id = 230001,
                        blueprintName = LocalStrEnum.blueprintName_230001,
                        blueprintRare = 5,
                        itemId = 140004,
                        useType = 1,
                        commonCost = {{100006,5000},{100007,5000},{100009,5000},{100008,5000}},
                        ExtraCost = {100003,5000},
                        produceShow = {440101,440102,440201,440202,440301,440302,440401,440402,440501,440502,440601,440602,440701,440702,440801,440802,450101,450102,450103,450201,450202,450203,450301,450302,450303,450401,450402,450403,450501,450502,450503,450601,450602,450603,450701,450702,450703,450801,450802,450803},
                        produce = 230004,
                        ExtraProduce = {230104},
                },

                [300001] = {
                        id = 300001,
                        blueprintName = LocalStrEnum.blueprintName_300001,
                        blueprintRare = 2,
                        itemId = 140011,
                        useType = 3,
                        commonCost = {{100006,800},{100007,800},{100009,800},{100008,800}},
                        ExtraCost = {100003,800},
                        produceShow = {410101,410201,410301,410401,410501,410601,410701,410801,420101,420201,420301,420401,420501,420601,420702,420801},
                        produce = 230011,
                        ExtraProduce = {},
                },

}
return WeaponProductionTable