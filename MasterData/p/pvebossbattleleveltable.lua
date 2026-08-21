---@class PveBossBattleLevelTable
---@field public id integer
---@field public Icon integer
---@field public LevelId table
---@field public AdvantageRole table
---@field public AdvantageRoleEffect table
---@field public MainEffect table
---@field public EffectIcon table
---@field public MainEffectDesc table
---@field public Name LocalStrEnum

---@type PveBossBattleLevelTable[]
local PveBossBattleLevelTable = {
                [1001] = {
                        id = 1001,
                        Icon = 20001,
                        LevelId = {44011,44012,44013,44014},
                        AdvantageRole = {10008,10015,10011,10001,10004,10006},
                        AdvantageRoleEffect = {500339,500439},
                        MainEffect = {10001,10005,10012,10013,16006,13002,12002,20001,20004},
                        EffectIcon = {10001,10005,10012,10013,16006,13002,12002,20001,20004},
                        MainEffectDesc = {"MainEffectDesc_10001","MainEffectDesc_10005","MainEffectDesc_10012","MainEffectDesc_10013","MainEffectDesc_16006","MainEffectDesc_13002","MainEffectDesc_12002","MainEffectDesc_20001","MainEffectDesc_20004"},
                        Name = LocalStrEnum.BossBattleName_1,
                },

                [1002] = {
                        id = 1002,
                        Icon = 21001,
                        LevelId = {44021,44022,44023,44024},
                        AdvantageRole = {10005,10007,10013,10014,10002,10016,10017},
                        AdvantageRoleEffect = {500339,500439},
                        MainEffect = {10006,10002,10011,10015,13006,11001,15005,20005,20003},
                        EffectIcon = {10006,10002,10011,10015,13006,11001,15005,20005,20003},
                        MainEffectDesc = {"MainEffectDesc_10006","MainEffectDesc_10002","MainEffectDesc_10011","MainEffectDesc_10015","MainEffectDesc_13006","MainEffectDesc_11001","MainEffectDesc_15005","MainEffectDesc_20005","MainEffectDesc_20003"},
                        Name = LocalStrEnum.BossBattleName_2,
                },

}
return PveBossBattleLevelTable