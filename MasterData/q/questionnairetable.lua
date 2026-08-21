---@class QuestionnaireTable
---@field public id integer
---@field public Codeid integer
---@field public Channel string
---@field public unlock table
---@field public endCondition table
---@field public Reward table
---@field public WebUrl string

---@type QuestionnaireTable[]
local QuestionnaireTable = {
                [1] = {
                        id = 1,
                        Codeid = 15,
                        Channel = "debugtime",
                        unlock = {{2,25},{4,"2026-05-01 05:00:00"}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/cqFF5t",
                },

                [2] = {
                        id = 2,
                        Codeid = 16,
                        Channel = "debugtime",
                        unlock = {{2,50},{4,"2025-12-22 05:00:00"},{5,1}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/6MZzNo",
                },

                [3] = {
                        id = 3,
                        Codeid = 17,
                        Channel = "debugtime",
                        unlock = {{2,55},{4,"2025-12-22 05:00:00"},{5,2}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/NoeYaY",
                },

                [4] = {
                        id = 4,
                        Codeid = 18,
                        Channel = "debugtime",
                        unlock = {{2,60},{4,"2025-12-22 05:00:00"},{5,3}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/IWyPiV",
                },

                [5] = {
                        id = 5,
                        Codeid = 11,
                        Channel = "debug",
                        unlock = {{1,10201},{2,10},{4,"2025-12-22 05:00:00"}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/MAbhq6",
                },

                [6] = {
                        id = 6,
                        Codeid = 12,
                        Channel = "debug",
                        unlock = {{1,10203},{2,10},{4,"2025-12-22 05:00:00"},{5,5}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/GSuzpW",
                },

                [7] = {
                        id = 7,
                        Codeid = 13,
                        Channel = "debug",
                        unlock = {{4,"2025-12-22 05:00:00"}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/xoeoTx",
                },

                [8] = {
                        id = 8,
                        Codeid = 14,
                        Channel = "debug",
                        unlock = {{1,10205},{4,"2025-12-22 05:00:00"}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/7GrhNN",
                },

                [9] = {
                        id = 9,
                        Codeid = 19,
                        Channel = "release",
                        unlock = {{2,25},{4,"2026-05-01 05:00:00"}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/IKHg9l",
                },

                [10] = {
                        id = 10,
                        Codeid = 20,
                        Channel = "release",
                        unlock = {{2,50},{4,"2025-12-22 05:00:00"},{5,1}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/eU5cOa",
                },

                [11] = {
                        id = 11,
                        Codeid = 21,
                        Channel = "release",
                        unlock = {{2,55},{4,"2025-12-22 05:00:00"},{5,2}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/sokgRG",
                },

                [12] = {
                        id = 12,
                        Codeid = 22,
                        Channel = "release",
                        unlock = {{2,60},{4,"2025-12-22 05:00:00"},{5,3}},
                        endCondition = {{4,"2026-12-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "http://192.168.1.137:8003/s/ZP4M5k",
                },

                [13] = {
                        id = 13,
                        Codeid = 6,
                        Channel = "taptapAudit",
                        unlock = {{4,"2026-07-21 18:00:00"}},
                        endCondition = {{4,"2026-7-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "https://wj.moecove.com/s/VwblFU",
                },

                [14] = {
                        id = 14,
                        Codeid = 5,
                        Channel = "openbeta_test01",
                        unlock = {{4,"2026-07-21 18:00:00"}},
                        endCondition = {{4,"2026-7-30 05:00:00"}},
                        Reward = {{1,100002,100}},
                        WebUrl = "https://wj.moecove.com/s/oXORJX",
                },

}
return QuestionnaireTable