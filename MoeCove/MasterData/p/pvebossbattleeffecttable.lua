---@class PveBossBattleEffectTable
---@field public id integer
---@field public MainEffectId integer
---@field public EffectIcon table
---@field public Effect table
---@field public ScoreAddition integer
---@field public EffectDesc LocalStrEnum

---@type PveBossBattleEffectTable[]
local PveBossBattleEffectTable = {
                [100011] = {
                        id = 100011,
                        MainEffectId = 10001,
                        EffectIcon = 1001,
                        Effect = {{4,1,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100011,
                },

                [100012] = {
                        id = 100012,
                        MainEffectId = 10001,
                        EffectIcon = 1001,
                        Effect = {{4,1,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100012,
                },

                [100013] = {
                        id = 100013,
                        MainEffectId = 10001,
                        EffectIcon = 1001,
                        Effect = {{4,1,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100013,
                },

                [100021] = {
                        id = 100021,
                        MainEffectId = 10002,
                        EffectIcon = 1001,
                        Effect = {{4,2,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100021,
                },

                [100022] = {
                        id = 100022,
                        MainEffectId = 10002,
                        EffectIcon = 1001,
                        Effect = {{4,2,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100022,
                },

                [100023] = {
                        id = 100023,
                        MainEffectId = 10002,
                        EffectIcon = 1001,
                        Effect = {{4,2,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100023,
                },

                [100031] = {
                        id = 100031,
                        MainEffectId = 10003,
                        EffectIcon = 1001,
                        Effect = {{4,3,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100031,
                },

                [100032] = {
                        id = 100032,
                        MainEffectId = 10003,
                        EffectIcon = 1001,
                        Effect = {{4,3,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100032,
                },

                [100033] = {
                        id = 100033,
                        MainEffectId = 10003,
                        EffectIcon = 1001,
                        Effect = {{4,3,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100033,
                },

                [100041] = {
                        id = 100041,
                        MainEffectId = 10004,
                        EffectIcon = 1001,
                        Effect = {{4,4,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100041,
                },

                [100042] = {
                        id = 100042,
                        MainEffectId = 10004,
                        EffectIcon = 1001,
                        Effect = {{4,4,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100042,
                },

                [100043] = {
                        id = 100043,
                        MainEffectId = 10004,
                        EffectIcon = 1001,
                        Effect = {{4,4,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100043,
                },

                [100051] = {
                        id = 100051,
                        MainEffectId = 10005,
                        EffectIcon = 1001,
                        Effect = {{4,5,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100051,
                },

                [100052] = {
                        id = 100052,
                        MainEffectId = 10005,
                        EffectIcon = 1001,
                        Effect = {{4,5,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100052,
                },

                [100053] = {
                        id = 100053,
                        MainEffectId = 10005,
                        EffectIcon = 1001,
                        Effect = {{4,5,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100053,
                },

                [100061] = {
                        id = 100061,
                        MainEffectId = 10006,
                        EffectIcon = 1001,
                        Effect = {{4,6,5,2}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100061,
                },

                [100062] = {
                        id = 100062,
                        MainEffectId = 10006,
                        EffectIcon = 1001,
                        Effect = {{4,6,5,1}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100062,
                },

                [100063] = {
                        id = 100063,
                        MainEffectId = 10006,
                        EffectIcon = 1001,
                        Effect = {{4,6,4,1}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100063,
                },

                [100111] = {
                        id = 100111,
                        MainEffectId = 10011,
                        EffectIcon = 1001,
                        Effect = {{4,1,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100111,
                },

                [100112] = {
                        id = 100112,
                        MainEffectId = 10011,
                        EffectIcon = 1001,
                        Effect = {{4,1,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100112,
                },

                [100113] = {
                        id = 100113,
                        MainEffectId = 10011,
                        EffectIcon = 1001,
                        Effect = {{4,1,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100113,
                },

                [100121] = {
                        id = 100121,
                        MainEffectId = 10012,
                        EffectIcon = 1001,
                        Effect = {{4,2,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100121,
                },

                [100122] = {
                        id = 100122,
                        MainEffectId = 10012,
                        EffectIcon = 1001,
                        Effect = {{4,2,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100122,
                },

                [100123] = {
                        id = 100123,
                        MainEffectId = 10012,
                        EffectIcon = 1001,
                        Effect = {{4,2,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100123,
                },

                [100131] = {
                        id = 100131,
                        MainEffectId = 10013,
                        EffectIcon = 1001,
                        Effect = {{4,3,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100131,
                },

                [100132] = {
                        id = 100132,
                        MainEffectId = 10013,
                        EffectIcon = 1001,
                        Effect = {{4,3,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100132,
                },

                [100133] = {
                        id = 100133,
                        MainEffectId = 10013,
                        EffectIcon = 1001,
                        Effect = {{4,3,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100133,
                },

                [100141] = {
                        id = 100141,
                        MainEffectId = 10014,
                        EffectIcon = 1001,
                        Effect = {{4,4,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100141,
                },

                [100142] = {
                        id = 100142,
                        MainEffectId = 10014,
                        EffectIcon = 1001,
                        Effect = {{4,4,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100142,
                },

                [100143] = {
                        id = 100143,
                        MainEffectId = 10014,
                        EffectIcon = 1001,
                        Effect = {{4,4,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100143,
                },

                [100151] = {
                        id = 100151,
                        MainEffectId = 10015,
                        EffectIcon = 1001,
                        Effect = {{4,5,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100151,
                },

                [100152] = {
                        id = 100152,
                        MainEffectId = 10015,
                        EffectIcon = 1001,
                        Effect = {{4,5,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100152,
                },

                [100153] = {
                        id = 100153,
                        MainEffectId = 10015,
                        EffectIcon = 1001,
                        Effect = {{4,5,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100153,
                },

                [100161] = {
                        id = 100161,
                        MainEffectId = 10016,
                        EffectIcon = 1001,
                        Effect = {{4,6,3,1}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100161,
                },

                [100162] = {
                        id = 100162,
                        MainEffectId = 10016,
                        EffectIcon = 1001,
                        Effect = {{4,6,3,2}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100162,
                },

                [100163] = {
                        id = 100163,
                        MainEffectId = 10016,
                        EffectIcon = 1001,
                        Effect = {{4,6,3,3}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_100163,
                },

                [101131] = {
                        id = 101131,
                        MainEffectId = 10113,
                        EffectIcon = 1001,
                        Effect = {{1,612101}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_101131,
                },

                [101132] = {
                        id = 101132,
                        MainEffectId = 10113,
                        EffectIcon = 1001,
                        Effect = {{1,612102}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_101132,
                },

                [101133] = {
                        id = 101133,
                        MainEffectId = 10113,
                        EffectIcon = 1001,
                        Effect = {{1,612103}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_101133,
                },

                [110011] = {
                        id = 110011,
                        MainEffectId = 11001,
                        EffectIcon = 1001,
                        Effect = {{1,611011}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110011,
                },

                [110012] = {
                        id = 110012,
                        MainEffectId = 11001,
                        EffectIcon = 1001,
                        Effect = {{1,611012}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110012,
                },

                [110013] = {
                        id = 110013,
                        MainEffectId = 11001,
                        EffectIcon = 1001,
                        Effect = {{1,611013}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110013,
                },

                [110021] = {
                        id = 110021,
                        MainEffectId = 11002,
                        EffectIcon = 1001,
                        Effect = {{1,611111}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110021,
                },

                [110022] = {
                        id = 110022,
                        MainEffectId = 11002,
                        EffectIcon = 1001,
                        Effect = {{1,611112}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110022,
                },

                [110023] = {
                        id = 110023,
                        MainEffectId = 11002,
                        EffectIcon = 1001,
                        Effect = {{1,611113}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110023,
                },

                [110031] = {
                        id = 110031,
                        MainEffectId = 11003,
                        EffectIcon = 1001,
                        Effect = {{1,611211}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110031,
                },

                [110032] = {
                        id = 110032,
                        MainEffectId = 11003,
                        EffectIcon = 1001,
                        Effect = {{1,611212}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110032,
                },

                [110033] = {
                        id = 110033,
                        MainEffectId = 11003,
                        EffectIcon = 1001,
                        Effect = {{1,611213}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110033,
                },

                [110041] = {
                        id = 110041,
                        MainEffectId = 11004,
                        EffectIcon = 1001,
                        Effect = {{1,611311}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110041,
                },

                [110042] = {
                        id = 110042,
                        MainEffectId = 11004,
                        EffectIcon = 1001,
                        Effect = {{1,611312}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110042,
                },

                [110043] = {
                        id = 110043,
                        MainEffectId = 11004,
                        EffectIcon = 1001,
                        Effect = {{1,611313}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110043,
                },

                [110051] = {
                        id = 110051,
                        MainEffectId = 11005,
                        EffectIcon = 1001,
                        Effect = {{1,611411}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110051,
                },

                [110052] = {
                        id = 110052,
                        MainEffectId = 11005,
                        EffectIcon = 1001,
                        Effect = {{1,611412}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110052,
                },

                [110053] = {
                        id = 110053,
                        MainEffectId = 11005,
                        EffectIcon = 1001,
                        Effect = {{1,611413}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110053,
                },

                [110061] = {
                        id = 110061,
                        MainEffectId = 11006,
                        EffectIcon = 1001,
                        Effect = {{1,611511}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110061,
                },

                [110062] = {
                        id = 110062,
                        MainEffectId = 11006,
                        EffectIcon = 1001,
                        Effect = {{1,611512}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110062,
                },

                [110063] = {
                        id = 110063,
                        MainEffectId = 11006,
                        EffectIcon = 1001,
                        Effect = {{1,611513}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_110063,
                },

                [120011] = {
                        id = 120011,
                        MainEffectId = 12001,
                        EffectIcon = 1001,
                        Effect = {{1,611021}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120011,
                },

                [120012] = {
                        id = 120012,
                        MainEffectId = 12001,
                        EffectIcon = 1001,
                        Effect = {{1,611022}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120012,
                },

                [120013] = {
                        id = 120013,
                        MainEffectId = 12001,
                        EffectIcon = 1001,
                        Effect = {{1,611023}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120013,
                },

                [120021] = {
                        id = 120021,
                        MainEffectId = 12002,
                        EffectIcon = 1001,
                        Effect = {{1,611121}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120021,
                },

                [120022] = {
                        id = 120022,
                        MainEffectId = 12002,
                        EffectIcon = 1001,
                        Effect = {{1,611122}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120022,
                },

                [120023] = {
                        id = 120023,
                        MainEffectId = 12002,
                        EffectIcon = 1001,
                        Effect = {{1,611123}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120023,
                },

                [120031] = {
                        id = 120031,
                        MainEffectId = 12003,
                        EffectIcon = 1001,
                        Effect = {{1,611221}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120031,
                },

                [120032] = {
                        id = 120032,
                        MainEffectId = 12003,
                        EffectIcon = 1001,
                        Effect = {{1,611222}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120032,
                },

                [120033] = {
                        id = 120033,
                        MainEffectId = 12003,
                        EffectIcon = 1001,
                        Effect = {{1,611223}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120033,
                },

                [120041] = {
                        id = 120041,
                        MainEffectId = 12004,
                        EffectIcon = 1001,
                        Effect = {{1,611321}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120041,
                },

                [120042] = {
                        id = 120042,
                        MainEffectId = 12004,
                        EffectIcon = 1001,
                        Effect = {{1,611322}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120042,
                },

                [120043] = {
                        id = 120043,
                        MainEffectId = 12004,
                        EffectIcon = 1001,
                        Effect = {{1,611323}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120043,
                },

                [120051] = {
                        id = 120051,
                        MainEffectId = 12005,
                        EffectIcon = 1001,
                        Effect = {{1,611421}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120051,
                },

                [120052] = {
                        id = 120052,
                        MainEffectId = 12005,
                        EffectIcon = 1001,
                        Effect = {{1,611422}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120052,
                },

                [120053] = {
                        id = 120053,
                        MainEffectId = 12005,
                        EffectIcon = 1001,
                        Effect = {{1,611423}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120053,
                },

                [120061] = {
                        id = 120061,
                        MainEffectId = 12006,
                        EffectIcon = 1001,
                        Effect = {{1,611521}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120061,
                },

                [120062] = {
                        id = 120062,
                        MainEffectId = 12006,
                        EffectIcon = 1001,
                        Effect = {{1,611522}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120062,
                },

                [120063] = {
                        id = 120063,
                        MainEffectId = 12006,
                        EffectIcon = 1001,
                        Effect = {{1,611523}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_120063,
                },

                [130011] = {
                        id = 130011,
                        MainEffectId = 13001,
                        EffectIcon = 1001,
                        Effect = {{1,611031}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130011,
                },

                [130012] = {
                        id = 130012,
                        MainEffectId = 13001,
                        EffectIcon = 1001,
                        Effect = {{1,611032}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130012,
                },

                [130013] = {
                        id = 130013,
                        MainEffectId = 13001,
                        EffectIcon = 1001,
                        Effect = {{1,611033}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130013,
                },

                [130021] = {
                        id = 130021,
                        MainEffectId = 13002,
                        EffectIcon = 1001,
                        Effect = {{1,611131}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130021,
                },

                [130022] = {
                        id = 130022,
                        MainEffectId = 13002,
                        EffectIcon = 1001,
                        Effect = {{1,611132}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130022,
                },

                [130023] = {
                        id = 130023,
                        MainEffectId = 13002,
                        EffectIcon = 1001,
                        Effect = {{1,611133}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130023,
                },

                [130031] = {
                        id = 130031,
                        MainEffectId = 13003,
                        EffectIcon = 1001,
                        Effect = {{1,611231}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130031,
                },

                [130032] = {
                        id = 130032,
                        MainEffectId = 13003,
                        EffectIcon = 1001,
                        Effect = {{1,611232}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130032,
                },

                [130033] = {
                        id = 130033,
                        MainEffectId = 13003,
                        EffectIcon = 1001,
                        Effect = {{1,611233}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130033,
                },

                [130041] = {
                        id = 130041,
                        MainEffectId = 13004,
                        EffectIcon = 1001,
                        Effect = {{1,611331}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130041,
                },

                [130042] = {
                        id = 130042,
                        MainEffectId = 13004,
                        EffectIcon = 1001,
                        Effect = {{1,611332}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130042,
                },

                [130043] = {
                        id = 130043,
                        MainEffectId = 13004,
                        EffectIcon = 1001,
                        Effect = {{1,611333}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130043,
                },

                [130051] = {
                        id = 130051,
                        MainEffectId = 13005,
                        EffectIcon = 1001,
                        Effect = {{1,611431}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130051,
                },

                [130052] = {
                        id = 130052,
                        MainEffectId = 13005,
                        EffectIcon = 1001,
                        Effect = {{1,611432}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130052,
                },

                [130053] = {
                        id = 130053,
                        MainEffectId = 13005,
                        EffectIcon = 1001,
                        Effect = {{1,611433}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130053,
                },

                [130061] = {
                        id = 130061,
                        MainEffectId = 13006,
                        EffectIcon = 1001,
                        Effect = {{1,611531}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130061,
                },

                [130062] = {
                        id = 130062,
                        MainEffectId = 13006,
                        EffectIcon = 1001,
                        Effect = {{1,611532}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130062,
                },

                [130063] = {
                        id = 130063,
                        MainEffectId = 13006,
                        EffectIcon = 1001,
                        Effect = {{1,611533}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_130063,
                },

                [140011] = {
                        id = 140011,
                        MainEffectId = 14001,
                        EffectIcon = 1001,
                        Effect = {{1,611041}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140011,
                },

                [140012] = {
                        id = 140012,
                        MainEffectId = 14001,
                        EffectIcon = 1001,
                        Effect = {{1,611042}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140012,
                },

                [140013] = {
                        id = 140013,
                        MainEffectId = 14001,
                        EffectIcon = 1001,
                        Effect = {{1,611043}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140013,
                },

                [140021] = {
                        id = 140021,
                        MainEffectId = 14002,
                        EffectIcon = 1001,
                        Effect = {{1,611141}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140021,
                },

                [140022] = {
                        id = 140022,
                        MainEffectId = 14002,
                        EffectIcon = 1001,
                        Effect = {{1,611142}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140022,
                },

                [140023] = {
                        id = 140023,
                        MainEffectId = 14002,
                        EffectIcon = 1001,
                        Effect = {{1,611143}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140023,
                },

                [140031] = {
                        id = 140031,
                        MainEffectId = 14003,
                        EffectIcon = 1001,
                        Effect = {{1,611241}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140031,
                },

                [140032] = {
                        id = 140032,
                        MainEffectId = 14003,
                        EffectIcon = 1001,
                        Effect = {{1,611242}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140032,
                },

                [140033] = {
                        id = 140033,
                        MainEffectId = 14003,
                        EffectIcon = 1001,
                        Effect = {{1,611243}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140033,
                },

                [140041] = {
                        id = 140041,
                        MainEffectId = 14004,
                        EffectIcon = 1001,
                        Effect = {{1,611341}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140041,
                },

                [140042] = {
                        id = 140042,
                        MainEffectId = 14004,
                        EffectIcon = 1001,
                        Effect = {{1,611342}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140042,
                },

                [140043] = {
                        id = 140043,
                        MainEffectId = 14004,
                        EffectIcon = 1001,
                        Effect = {{1,611343}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140043,
                },

                [140051] = {
                        id = 140051,
                        MainEffectId = 14005,
                        EffectIcon = 1001,
                        Effect = {{1,611441}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140051,
                },

                [140052] = {
                        id = 140052,
                        MainEffectId = 14005,
                        EffectIcon = 1001,
                        Effect = {{1,611442}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140052,
                },

                [140053] = {
                        id = 140053,
                        MainEffectId = 14005,
                        EffectIcon = 1001,
                        Effect = {{1,611443}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140053,
                },

                [140061] = {
                        id = 140061,
                        MainEffectId = 14006,
                        EffectIcon = 1001,
                        Effect = {{1,611541}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140061,
                },

                [140062] = {
                        id = 140062,
                        MainEffectId = 14006,
                        EffectIcon = 1001,
                        Effect = {{1,611542}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140062,
                },

                [140063] = {
                        id = 140063,
                        MainEffectId = 14006,
                        EffectIcon = 1001,
                        Effect = {{1,611543}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_140063,
                },

                [150011] = {
                        id = 150011,
                        MainEffectId = 15001,
                        EffectIcon = 1001,
                        Effect = {{1,611051}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150011,
                },

                [150012] = {
                        id = 150012,
                        MainEffectId = 15001,
                        EffectIcon = 1001,
                        Effect = {{1,611052}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150012,
                },

                [150013] = {
                        id = 150013,
                        MainEffectId = 15001,
                        EffectIcon = 1001,
                        Effect = {{1,611053}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150013,
                },

                [150021] = {
                        id = 150021,
                        MainEffectId = 15002,
                        EffectIcon = 1001,
                        Effect = {{1,611151}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150021,
                },

                [150022] = {
                        id = 150022,
                        MainEffectId = 15002,
                        EffectIcon = 1001,
                        Effect = {{1,611152}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150022,
                },

                [150023] = {
                        id = 150023,
                        MainEffectId = 15002,
                        EffectIcon = 1001,
                        Effect = {{1,611153}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150023,
                },

                [150031] = {
                        id = 150031,
                        MainEffectId = 15003,
                        EffectIcon = 1001,
                        Effect = {{1,611251}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150031,
                },

                [150032] = {
                        id = 150032,
                        MainEffectId = 15003,
                        EffectIcon = 1001,
                        Effect = {{1,611252}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150032,
                },

                [150033] = {
                        id = 150033,
                        MainEffectId = 15003,
                        EffectIcon = 1001,
                        Effect = {{1,611253}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150033,
                },

                [150041] = {
                        id = 150041,
                        MainEffectId = 15004,
                        EffectIcon = 1001,
                        Effect = {{1,611351}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150041,
                },

                [150042] = {
                        id = 150042,
                        MainEffectId = 15004,
                        EffectIcon = 1001,
                        Effect = {{1,611352}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150042,
                },

                [150043] = {
                        id = 150043,
                        MainEffectId = 15004,
                        EffectIcon = 1001,
                        Effect = {{1,611353}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150043,
                },

                [150051] = {
                        id = 150051,
                        MainEffectId = 15005,
                        EffectIcon = 1001,
                        Effect = {{1,611451}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150051,
                },

                [150052] = {
                        id = 150052,
                        MainEffectId = 15005,
                        EffectIcon = 1001,
                        Effect = {{1,611452}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150052,
                },

                [150053] = {
                        id = 150053,
                        MainEffectId = 15005,
                        EffectIcon = 1001,
                        Effect = {{1,611453}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150053,
                },

                [150061] = {
                        id = 150061,
                        MainEffectId = 15006,
                        EffectIcon = 1001,
                        Effect = {{1,611551}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150061,
                },

                [150062] = {
                        id = 150062,
                        MainEffectId = 15006,
                        EffectIcon = 1001,
                        Effect = {{1,611552}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150062,
                },

                [150063] = {
                        id = 150063,
                        MainEffectId = 15006,
                        EffectIcon = 1001,
                        Effect = {{1,611553}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_150063,
                },

                [160011] = {
                        id = 160011,
                        MainEffectId = 16001,
                        EffectIcon = 1001,
                        Effect = {{1,611061}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160011,
                },

                [160012] = {
                        id = 160012,
                        MainEffectId = 16001,
                        EffectIcon = 1001,
                        Effect = {{1,611062}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160012,
                },

                [160013] = {
                        id = 160013,
                        MainEffectId = 16001,
                        EffectIcon = 1001,
                        Effect = {{1,611063}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160013,
                },

                [160021] = {
                        id = 160021,
                        MainEffectId = 16002,
                        EffectIcon = 1001,
                        Effect = {{1,611161}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160021,
                },

                [160022] = {
                        id = 160022,
                        MainEffectId = 16002,
                        EffectIcon = 1001,
                        Effect = {{1,611162}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160022,
                },

                [160023] = {
                        id = 160023,
                        MainEffectId = 16002,
                        EffectIcon = 1001,
                        Effect = {{1,611163}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160023,
                },

                [160031] = {
                        id = 160031,
                        MainEffectId = 16003,
                        EffectIcon = 1001,
                        Effect = {{1,611261}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160031,
                },

                [160032] = {
                        id = 160032,
                        MainEffectId = 16003,
                        EffectIcon = 1001,
                        Effect = {{1,611262}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160032,
                },

                [160033] = {
                        id = 160033,
                        MainEffectId = 16003,
                        EffectIcon = 1001,
                        Effect = {{1,611263}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160033,
                },

                [160041] = {
                        id = 160041,
                        MainEffectId = 16004,
                        EffectIcon = 1001,
                        Effect = {{1,611361}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160041,
                },

                [160042] = {
                        id = 160042,
                        MainEffectId = 16004,
                        EffectIcon = 1001,
                        Effect = {{1,611362}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160042,
                },

                [160043] = {
                        id = 160043,
                        MainEffectId = 16004,
                        EffectIcon = 1001,
                        Effect = {{1,611363}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160043,
                },

                [160051] = {
                        id = 160051,
                        MainEffectId = 16005,
                        EffectIcon = 1001,
                        Effect = {{1,611461}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160051,
                },

                [160052] = {
                        id = 160052,
                        MainEffectId = 16005,
                        EffectIcon = 1001,
                        Effect = {{1,611462}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160052,
                },

                [160053] = {
                        id = 160053,
                        MainEffectId = 16005,
                        EffectIcon = 1001,
                        Effect = {{1,611463}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160053,
                },

                [160061] = {
                        id = 160061,
                        MainEffectId = 16006,
                        EffectIcon = 1001,
                        Effect = {{1,611561}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160061,
                },

                [160062] = {
                        id = 160062,
                        MainEffectId = 16006,
                        EffectIcon = 1001,
                        Effect = {{1,611562}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160062,
                },

                [160063] = {
                        id = 160063,
                        MainEffectId = 16006,
                        EffectIcon = 1001,
                        Effect = {{1,611563}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_160063,
                },

                [200011] = {
                        id = 200011,
                        MainEffectId = 20001,
                        EffectIcon = 1001,
                        Effect = {{2,611001}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200011,
                },

                [200012] = {
                        id = 200012,
                        MainEffectId = 20001,
                        EffectIcon = 1001,
                        Effect = {{2,611002}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200012,
                },

                [200013] = {
                        id = 200013,
                        MainEffectId = 20001,
                        EffectIcon = 1001,
                        Effect = {{2,611003}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200013,
                },

                [200021] = {
                        id = 200021,
                        MainEffectId = 20002,
                        EffectIcon = 1001,
                        Effect = {{2,611101}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200021,
                },

                [200022] = {
                        id = 200022,
                        MainEffectId = 20002,
                        EffectIcon = 1001,
                        Effect = {{2,611102}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200022,
                },

                [200023] = {
                        id = 200023,
                        MainEffectId = 20002,
                        EffectIcon = 1001,
                        Effect = {{2,611103}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200023,
                },

                [200031] = {
                        id = 200031,
                        MainEffectId = 20003,
                        EffectIcon = 1001,
                        Effect = {{2,611201}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200031,
                },

                [200032] = {
                        id = 200032,
                        MainEffectId = 20003,
                        EffectIcon = 1001,
                        Effect = {{2,611202}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200032,
                },

                [200033] = {
                        id = 200033,
                        MainEffectId = 20003,
                        EffectIcon = 1001,
                        Effect = {{2,611203}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200033,
                },

                [200041] = {
                        id = 200041,
                        MainEffectId = 20004,
                        EffectIcon = 1001,
                        Effect = {{2,611301}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200041,
                },

                [200042] = {
                        id = 200042,
                        MainEffectId = 20004,
                        EffectIcon = 1001,
                        Effect = {{2,611302}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200042,
                },

                [200043] = {
                        id = 200043,
                        MainEffectId = 20004,
                        EffectIcon = 1001,
                        Effect = {{2,611303}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200043,
                },

                [200051] = {
                        id = 200051,
                        MainEffectId = 20005,
                        EffectIcon = 1001,
                        Effect = {{2,611401}},
                        ScoreAddition = 0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200051,
                },

                [200052] = {
                        id = 200052,
                        MainEffectId = 20005,
                        EffectIcon = 1001,
                        Effect = {{2,611402}},
                        ScoreAddition = 0.2,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200052,
                },

                [200053] = {
                        id = 200053,
                        MainEffectId = 20005,
                        EffectIcon = 1001,
                        Effect = {{2,611403}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_200053,
                },

                [210011] = {
                        id = 210011,
                        MainEffectId = 21001,
                        EffectIcon = 1001,
                        Effect = {{2,611011}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210011,
                },

                [210012] = {
                        id = 210012,
                        MainEffectId = 21001,
                        EffectIcon = 1001,
                        Effect = {{2,611012}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210012,
                },

                [210013] = {
                        id = 210013,
                        MainEffectId = 21001,
                        EffectIcon = 1001,
                        Effect = {{2,611013}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210013,
                },

                [210021] = {
                        id = 210021,
                        MainEffectId = 21002,
                        EffectIcon = 1001,
                        Effect = {{2,611111}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210021,
                },

                [210022] = {
                        id = 210022,
                        MainEffectId = 21002,
                        EffectIcon = 1001,
                        Effect = {{2,611112}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210022,
                },

                [210023] = {
                        id = 210023,
                        MainEffectId = 21002,
                        EffectIcon = 1001,
                        Effect = {{2,611113}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210023,
                },

                [210031] = {
                        id = 210031,
                        MainEffectId = 21003,
                        EffectIcon = 1001,
                        Effect = {{2,611211}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210031,
                },

                [210032] = {
                        id = 210032,
                        MainEffectId = 21003,
                        EffectIcon = 1001,
                        Effect = {{2,611212}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210032,
                },

                [210033] = {
                        id = 210033,
                        MainEffectId = 21003,
                        EffectIcon = 1001,
                        Effect = {{2,611213}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210033,
                },

                [210041] = {
                        id = 210041,
                        MainEffectId = 21004,
                        EffectIcon = 1001,
                        Effect = {{2,611311}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210041,
                },

                [210042] = {
                        id = 210042,
                        MainEffectId = 21004,
                        EffectIcon = 1001,
                        Effect = {{2,611312}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210042,
                },

                [210043] = {
                        id = 210043,
                        MainEffectId = 21004,
                        EffectIcon = 1001,
                        Effect = {{2,611313}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210043,
                },

                [210051] = {
                        id = 210051,
                        MainEffectId = 21005,
                        EffectIcon = 1001,
                        Effect = {{2,611411}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210051,
                },

                [210052] = {
                        id = 210052,
                        MainEffectId = 21005,
                        EffectIcon = 1001,
                        Effect = {{2,611412}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210052,
                },

                [210053] = {
                        id = 210053,
                        MainEffectId = 21005,
                        EffectIcon = 1001,
                        Effect = {{2,611413}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210053,
                },

                [210061] = {
                        id = 210061,
                        MainEffectId = 21006,
                        EffectIcon = 1001,
                        Effect = {{2,611511}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210061,
                },

                [210062] = {
                        id = 210062,
                        MainEffectId = 21006,
                        EffectIcon = 1001,
                        Effect = {{2,611512}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210062,
                },

                [210063] = {
                        id = 210063,
                        MainEffectId = 21006,
                        EffectIcon = 1001,
                        Effect = {{2,611513}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_210063,
                },

                [220011] = {
                        id = 220011,
                        MainEffectId = 22001,
                        EffectIcon = 1001,
                        Effect = {{2,611021}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220011,
                },

                [220012] = {
                        id = 220012,
                        MainEffectId = 22001,
                        EffectIcon = 1001,
                        Effect = {{2,611022}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220012,
                },

                [220013] = {
                        id = 220013,
                        MainEffectId = 22001,
                        EffectIcon = 1001,
                        Effect = {{2,611023}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220013,
                },

                [220021] = {
                        id = 220021,
                        MainEffectId = 22002,
                        EffectIcon = 1001,
                        Effect = {{2,611121}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220021,
                },

                [220022] = {
                        id = 220022,
                        MainEffectId = 22002,
                        EffectIcon = 1001,
                        Effect = {{2,611122}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220022,
                },

                [220023] = {
                        id = 220023,
                        MainEffectId = 22002,
                        EffectIcon = 1001,
                        Effect = {{2,611123}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220023,
                },

                [220031] = {
                        id = 220031,
                        MainEffectId = 22003,
                        EffectIcon = 1001,
                        Effect = {{2,611221}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220031,
                },

                [220032] = {
                        id = 220032,
                        MainEffectId = 22003,
                        EffectIcon = 1001,
                        Effect = {{2,611222}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220032,
                },

                [220033] = {
                        id = 220033,
                        MainEffectId = 22003,
                        EffectIcon = 1001,
                        Effect = {{2,611223}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220033,
                },

                [220041] = {
                        id = 220041,
                        MainEffectId = 22004,
                        EffectIcon = 1001,
                        Effect = {{2,611321}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220041,
                },

                [220042] = {
                        id = 220042,
                        MainEffectId = 22004,
                        EffectIcon = 1001,
                        Effect = {{2,611322}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220042,
                },

                [220043] = {
                        id = 220043,
                        MainEffectId = 22004,
                        EffectIcon = 1001,
                        Effect = {{2,611323}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220043,
                },

                [220051] = {
                        id = 220051,
                        MainEffectId = 22005,
                        EffectIcon = 1001,
                        Effect = {{2,611421}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220051,
                },

                [220052] = {
                        id = 220052,
                        MainEffectId = 22005,
                        EffectIcon = 1001,
                        Effect = {{2,611422}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220052,
                },

                [220053] = {
                        id = 220053,
                        MainEffectId = 22005,
                        EffectIcon = 1001,
                        Effect = {{2,611423}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220053,
                },

                [220061] = {
                        id = 220061,
                        MainEffectId = 22006,
                        EffectIcon = 1001,
                        Effect = {{2,611521}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220061,
                },

                [220062] = {
                        id = 220062,
                        MainEffectId = 22006,
                        EffectIcon = 1001,
                        Effect = {{2,611522}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220062,
                },

                [220063] = {
                        id = 220063,
                        MainEffectId = 22006,
                        EffectIcon = 1001,
                        Effect = {{2,611523}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_220063,
                },

                [230011] = {
                        id = 230011,
                        MainEffectId = 23001,
                        EffectIcon = 1001,
                        Effect = {{2,611031}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230011,
                },

                [230012] = {
                        id = 230012,
                        MainEffectId = 23001,
                        EffectIcon = 1001,
                        Effect = {{2,611032}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230012,
                },

                [230013] = {
                        id = 230013,
                        MainEffectId = 23001,
                        EffectIcon = 1001,
                        Effect = {{2,611033}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230013,
                },

                [230021] = {
                        id = 230021,
                        MainEffectId = 23002,
                        EffectIcon = 1001,
                        Effect = {{2,611131}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230021,
                },

                [230022] = {
                        id = 230022,
                        MainEffectId = 23002,
                        EffectIcon = 1001,
                        Effect = {{2,611132}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230022,
                },

                [230023] = {
                        id = 230023,
                        MainEffectId = 23002,
                        EffectIcon = 1001,
                        Effect = {{2,611133}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230023,
                },

                [230031] = {
                        id = 230031,
                        MainEffectId = 23003,
                        EffectIcon = 1001,
                        Effect = {{2,611231}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230031,
                },

                [230032] = {
                        id = 230032,
                        MainEffectId = 23003,
                        EffectIcon = 1001,
                        Effect = {{2,611232}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230032,
                },

                [230033] = {
                        id = 230033,
                        MainEffectId = 23003,
                        EffectIcon = 1001,
                        Effect = {{2,611233}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230033,
                },

                [230041] = {
                        id = 230041,
                        MainEffectId = 23004,
                        EffectIcon = 1001,
                        Effect = {{2,611331}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230041,
                },

                [230042] = {
                        id = 230042,
                        MainEffectId = 23004,
                        EffectIcon = 1001,
                        Effect = {{2,611332}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230042,
                },

                [230043] = {
                        id = 230043,
                        MainEffectId = 23004,
                        EffectIcon = 1001,
                        Effect = {{2,611333}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230043,
                },

                [230051] = {
                        id = 230051,
                        MainEffectId = 23005,
                        EffectIcon = 1001,
                        Effect = {{2,611431}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230051,
                },

                [230052] = {
                        id = 230052,
                        MainEffectId = 23005,
                        EffectIcon = 1001,
                        Effect = {{2,611432}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230052,
                },

                [230053] = {
                        id = 230053,
                        MainEffectId = 23005,
                        EffectIcon = 1001,
                        Effect = {{2,611433}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230053,
                },

                [230061] = {
                        id = 230061,
                        MainEffectId = 23006,
                        EffectIcon = 1001,
                        Effect = {{2,611531}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230061,
                },

                [230062] = {
                        id = 230062,
                        MainEffectId = 23006,
                        EffectIcon = 1001,
                        Effect = {{2,611532}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230062,
                },

                [230063] = {
                        id = 230063,
                        MainEffectId = 23006,
                        EffectIcon = 1001,
                        Effect = {{2,611533}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_230063,
                },

                [240011] = {
                        id = 240011,
                        MainEffectId = 24001,
                        EffectIcon = 1001,
                        Effect = {{2,611041}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240011,
                },

                [240012] = {
                        id = 240012,
                        MainEffectId = 24001,
                        EffectIcon = 1001,
                        Effect = {{2,611042}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240012,
                },

                [240013] = {
                        id = 240013,
                        MainEffectId = 24001,
                        EffectIcon = 1001,
                        Effect = {{2,611043}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240013,
                },

                [240021] = {
                        id = 240021,
                        MainEffectId = 24002,
                        EffectIcon = 1001,
                        Effect = {{2,611141}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240021,
                },

                [240022] = {
                        id = 240022,
                        MainEffectId = 24002,
                        EffectIcon = 1001,
                        Effect = {{2,611142}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240022,
                },

                [240023] = {
                        id = 240023,
                        MainEffectId = 24002,
                        EffectIcon = 1001,
                        Effect = {{2,611143}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240023,
                },

                [240031] = {
                        id = 240031,
                        MainEffectId = 24003,
                        EffectIcon = 1001,
                        Effect = {{2,611241}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240031,
                },

                [240032] = {
                        id = 240032,
                        MainEffectId = 24003,
                        EffectIcon = 1001,
                        Effect = {{2,611242}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240032,
                },

                [240033] = {
                        id = 240033,
                        MainEffectId = 24003,
                        EffectIcon = 1001,
                        Effect = {{2,611243}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240033,
                },

                [240041] = {
                        id = 240041,
                        MainEffectId = 24004,
                        EffectIcon = 1001,
                        Effect = {{2,611341}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240041,
                },

                [240042] = {
                        id = 240042,
                        MainEffectId = 24004,
                        EffectIcon = 1001,
                        Effect = {{2,611342}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240042,
                },

                [240043] = {
                        id = 240043,
                        MainEffectId = 24004,
                        EffectIcon = 1001,
                        Effect = {{2,611343}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240043,
                },

                [240051] = {
                        id = 240051,
                        MainEffectId = 24005,
                        EffectIcon = 1001,
                        Effect = {{2,611441}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240051,
                },

                [240052] = {
                        id = 240052,
                        MainEffectId = 24005,
                        EffectIcon = 1001,
                        Effect = {{2,611442}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240052,
                },

                [240053] = {
                        id = 240053,
                        MainEffectId = 24005,
                        EffectIcon = 1001,
                        Effect = {{2,611443}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240053,
                },

                [240061] = {
                        id = 240061,
                        MainEffectId = 24006,
                        EffectIcon = 1001,
                        Effect = {{2,611541}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240061,
                },

                [240062] = {
                        id = 240062,
                        MainEffectId = 24006,
                        EffectIcon = 1001,
                        Effect = {{2,611542}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240062,
                },

                [240063] = {
                        id = 240063,
                        MainEffectId = 24006,
                        EffectIcon = 1001,
                        Effect = {{2,611543}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_240063,
                },

                [250011] = {
                        id = 250011,
                        MainEffectId = 25001,
                        EffectIcon = 1001,
                        Effect = {{2,611051}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250011,
                },

                [250012] = {
                        id = 250012,
                        MainEffectId = 25001,
                        EffectIcon = 1001,
                        Effect = {{2,611052}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250012,
                },

                [250013] = {
                        id = 250013,
                        MainEffectId = 25001,
                        EffectIcon = 1001,
                        Effect = {{2,611053}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250013,
                },

                [250021] = {
                        id = 250021,
                        MainEffectId = 25002,
                        EffectIcon = 1001,
                        Effect = {{2,611151}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250021,
                },

                [250022] = {
                        id = 250022,
                        MainEffectId = 25002,
                        EffectIcon = 1001,
                        Effect = {{2,611152}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250022,
                },

                [250023] = {
                        id = 250023,
                        MainEffectId = 25002,
                        EffectIcon = 1001,
                        Effect = {{2,611153}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250023,
                },

                [250031] = {
                        id = 250031,
                        MainEffectId = 25003,
                        EffectIcon = 1001,
                        Effect = {{2,611251}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250031,
                },

                [250032] = {
                        id = 250032,
                        MainEffectId = 25003,
                        EffectIcon = 1001,
                        Effect = {{2,611252}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250032,
                },

                [250033] = {
                        id = 250033,
                        MainEffectId = 25003,
                        EffectIcon = 1001,
                        Effect = {{2,611253}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250033,
                },

                [250041] = {
                        id = 250041,
                        MainEffectId = 25004,
                        EffectIcon = 1001,
                        Effect = {{2,611351}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250041,
                },

                [250042] = {
                        id = 250042,
                        MainEffectId = 25004,
                        EffectIcon = 1001,
                        Effect = {{2,611352}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250042,
                },

                [250043] = {
                        id = 250043,
                        MainEffectId = 25004,
                        EffectIcon = 1001,
                        Effect = {{2,611353}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250043,
                },

                [250051] = {
                        id = 250051,
                        MainEffectId = 25005,
                        EffectIcon = 1001,
                        Effect = {{2,611451}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250051,
                },

                [250052] = {
                        id = 250052,
                        MainEffectId = 25005,
                        EffectIcon = 1001,
                        Effect = {{2,611452}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250052,
                },

                [250053] = {
                        id = 250053,
                        MainEffectId = 25005,
                        EffectIcon = 1001,
                        Effect = {{2,611453}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250053,
                },

                [250061] = {
                        id = 250061,
                        MainEffectId = 25006,
                        EffectIcon = 1001,
                        Effect = {{2,611551}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250061,
                },

                [250062] = {
                        id = 250062,
                        MainEffectId = 25006,
                        EffectIcon = 1001,
                        Effect = {{2,611552}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250062,
                },

                [250063] = {
                        id = 250063,
                        MainEffectId = 25006,
                        EffectIcon = 1001,
                        Effect = {{2,611553}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_250063,
                },

                [260011] = {
                        id = 260011,
                        MainEffectId = 26001,
                        EffectIcon = 1001,
                        Effect = {{2,611061}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260011,
                },

                [260012] = {
                        id = 260012,
                        MainEffectId = 26001,
                        EffectIcon = 1001,
                        Effect = {{2,611062}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260012,
                },

                [260013] = {
                        id = 260013,
                        MainEffectId = 26001,
                        EffectIcon = 1001,
                        Effect = {{2,611063}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260013,
                },

                [260021] = {
                        id = 260021,
                        MainEffectId = 26002,
                        EffectIcon = 1001,
                        Effect = {{2,611161}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260021,
                },

                [260022] = {
                        id = 260022,
                        MainEffectId = 26002,
                        EffectIcon = 1001,
                        Effect = {{2,611162}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260022,
                },

                [260023] = {
                        id = 260023,
                        MainEffectId = 26002,
                        EffectIcon = 1001,
                        Effect = {{2,611163}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260023,
                },

                [260031] = {
                        id = 260031,
                        MainEffectId = 26003,
                        EffectIcon = 1001,
                        Effect = {{2,611261}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260031,
                },

                [260032] = {
                        id = 260032,
                        MainEffectId = 26003,
                        EffectIcon = 1001,
                        Effect = {{2,611262}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260032,
                },

                [260033] = {
                        id = 260033,
                        MainEffectId = 26003,
                        EffectIcon = 1001,
                        Effect = {{2,611263}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260033,
                },

                [260041] = {
                        id = 260041,
                        MainEffectId = 26004,
                        EffectIcon = 1001,
                        Effect = {{2,611361}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260041,
                },

                [260042] = {
                        id = 260042,
                        MainEffectId = 26004,
                        EffectIcon = 1001,
                        Effect = {{2,611362}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260042,
                },

                [260043] = {
                        id = 260043,
                        MainEffectId = 26004,
                        EffectIcon = 1001,
                        Effect = {{2,611363}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260043,
                },

                [260051] = {
                        id = 260051,
                        MainEffectId = 26005,
                        EffectIcon = 1001,
                        Effect = {{2,611461}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260051,
                },

                [260052] = {
                        id = 260052,
                        MainEffectId = 26005,
                        EffectIcon = 1001,
                        Effect = {{2,611462}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260052,
                },

                [260053] = {
                        id = 260053,
                        MainEffectId = 26005,
                        EffectIcon = 1001,
                        Effect = {{2,611463}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260053,
                },

                [260061] = {
                        id = 260061,
                        MainEffectId = 26006,
                        EffectIcon = 1001,
                        Effect = {{2,611561}},
                        ScoreAddition = 0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260061,
                },

                [260062] = {
                        id = 260062,
                        MainEffectId = 26006,
                        EffectIcon = 1001,
                        Effect = {{2,611562}},
                        ScoreAddition = -0.05,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260062,
                },

                [260063] = {
                        id = 260063,
                        MainEffectId = 26006,
                        EffectIcon = 1001,
                        Effect = {{2,611563}},
                        ScoreAddition = -0.1,
                        EffectDesc = LocalStrEnum.PveBossBattleEffect_260063,
                },

}
return PveBossBattleEffectTable