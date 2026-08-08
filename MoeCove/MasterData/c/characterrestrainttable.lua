---@class CharacterRestraintTable
---@field public id integer
---@field public restraintType integer
---@field public ratio table
---@field public des string
---@field public restraintDes LocalStrEnum
---@field public isShow integer

---@type CharacterRestraintTable[]
local CharacterRestraintTable = {
                [11] = {
                        id = 11,
                        restraintType = 1,
                        ratio = {1,1.1,0.8,1,1,0.8,1,1},
                        des = "战列舰",
                        restraintDes = LocalStrEnum.RestraintDes_11,
                        isShow = 1,
                },

                [12] = {
                        id = 12,
                        restraintType = 1,
                        ratio = {1,1.1,0.8,1,1,0.8,1,1},
                        des = "战列巡洋舰",
                        restraintDes = LocalStrEnum.RestraintDes_12,
                        isShow = 1,
                },

                [13] = {
                        id = 13,
                        restraintType = 1,
                        ratio = {1,1.1,0.8,1,1,0.8,1,1},
                        des = "大巡洋舰",
                        restraintDes = LocalStrEnum.RestraintDes_13,
                        isShow = 0,
                },

                [14] = {
                        id = 14,
                        restraintType = 1,
                        ratio = {1,1.1,0.8,1,1,0.8,1,1},
                        des = "导弹艇",
                        restraintDes = LocalStrEnum.RestraintDes_14,
                        isShow = 1,
                },

                [15] = {
                        id = 15,
                        restraintType = 1,
                        ratio = {1,1.1,0.8,1,1,0.8,1,1},
                        des = "航空战列舰",
                        restraintDes = LocalStrEnum.RestraintDes_15,
                        isShow = 0,
                },

                [21] = {
                        id = 21,
                        restraintType = 2,
                        ratio = {0.9,1,1.2,1,1,1,1,1},
                        des = "重巡洋舰",
                        restraintDes = LocalStrEnum.RestraintDes_21,
                        isShow = 1,
                },

                [22] = {
                        id = 22,
                        restraintType = 2,
                        ratio = {0.9,1,1.2,1,1,1,1,1},
                        des = "攻击艇",
                        restraintDes = LocalStrEnum.RestraintDes_22,
                        isShow = 1,
                },

                [23] = {
                        id = 23,
                        restraintType = 2,
                        ratio = {0.9,1,1.2,1,1,1,1,1},
                        des = "轻巡洋舰",
                        restraintDes = LocalStrEnum.RestraintDes_23,
                        isShow = 1,
                },

                [24] = {
                        id = 24,
                        restraintType = 2,
                        ratio = {0.9,1,1.2,1,1,1,1,1},
                        des = "早期主力舰",
                        restraintDes = LocalStrEnum.RestraintDes_24,
                        isShow = 1,
                },

                [31] = {
                        id = 31,
                        restraintType = 3,
                        ratio = {1.1,0.8,1,1,1,1.1,1,1},
                        des = "驱逐舰",
                        restraintDes = LocalStrEnum.RestraintDes_31,
                        isShow = 1,
                },

                [32] = {
                        id = 32,
                        restraintType = 3,
                        ratio = {1.1,0.8,1,1,1,1.1,1,1},
                        des = "导弹驱逐舰",
                        restraintDes = LocalStrEnum.RestraintDes_32,
                        isShow = 1,
                },

                [33] = {
                        id = 33,
                        restraintType = 3,
                        ratio = {1.1,0.8,1,1,1,1.1,1,1},
                        des = "鱼雷艇",
                        restraintDes = LocalStrEnum.RestraintDes_33,
                        isShow = 1,
                },

                [41] = {
                        id = 41,
                        restraintType = 4,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "补给舰",
                        restraintDes = LocalStrEnum.RestraintDes_41,
                        isShow = 0,
                },

                [42] = {
                        id = 42,
                        restraintType = 4,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "维修舰",
                        restraintDes = LocalStrEnum.RestraintDes_42,
                        isShow = 1,
                },

                [43] = {
                        id = 43,
                        restraintType = 4,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "辅助舰",
                        restraintDes = LocalStrEnum.RestraintDes_43,
                        isShow = 1,
                },

                [51] = {
                        id = 51,
                        restraintType = 5,
                        ratio = {1,1,1,1,1,0.8,1,1},
                        des = "航空母舰",
                        restraintDes = LocalStrEnum.RestraintDes_51,
                        isShow = 1,
                },

                [52] = {
                        id = 52,
                        restraintType = 5,
                        ratio = {1,1,1,1,1,0.8,1,1},
                        des = "装甲航空母舰",
                        restraintDes = LocalStrEnum.RestraintDes_52,
                        isShow = 0,
                },

                [53] = {
                        id = 53,
                        restraintType = 5,
                        ratio = {1,1,1,1,1,0.8,1,1},
                        des = "轻型航空母舰",
                        restraintDes = LocalStrEnum.RestraintDes_53,
                        isShow = 0,
                },

                [61] = {
                        id = 61,
                        restraintType = 6,
                        ratio = {1.2,1,0.8,1,1.2,1,1,1},
                        des = "潜艇",
                        restraintDes = LocalStrEnum.RestraintDes_61,
                        isShow = 1,
                },

                [62] = {
                        id = 62,
                        restraintType = 6,
                        ratio = {1.2,1,0.8,1,1.2,1,1,1},
                        des = "重炮潜艇",
                        restraintDes = LocalStrEnum.RestraintDes_62,
                        isShow = 0,
                },

                [71] = {
                        id = 71,
                        restraintType = 7,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "特种",
                        restraintDes = LocalStrEnum.RestraintDes_71,
                        isShow = 1,
                },

                [81] = {
                        id = 81,
                        restraintType = 8,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "boss",
                        restraintDes = LocalStrEnum.RestraintDes_81,
                        isShow = 0,
                },

                [999] = {
                        id = 999,
                        restraintType = 1,
                        ratio = {1,1,1,1,1,1,1,1},
                        des = "特殊",
                        restraintDes = LocalStrEnum.RestraintDes_999,
                        isShow = 0,
                },

}
return CharacterRestraintTable