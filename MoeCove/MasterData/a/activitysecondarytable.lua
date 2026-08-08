---@class ActivitySecondaryTable
---@field public id integer
---@field public name LocalStrEnum
---@field public group integer
---@field public type integer
---@field public parameter table
---@field public StartTime string
---@field public EndTime string

---@type ActivitySecondaryTable[]
local ActivitySecondaryTable = {
                [10001] = {
                        id = 10001,
                        name = LocalStrEnum.activitySecondaryName_10001,
                        group = 1001,
                        type = 1,
                        parameter = {{1,10001,10203},{1,10018,31002},{1,10020,31003},{2,10039,1003903,31004},{2,10029,1002903,31004}},
                        StartTime = "2025-10-20 11:00:00",
                        EndTime = "2026-08-08 10:00:00",
                },

                [10002] = {
                        id = 10002,
                        name = LocalStrEnum.activitySecondaryName_10002,
                        group = 1001,
                        type = 2,
                        parameter = {40001,40002},
                        StartTime = "2025-05-20 11:00:00",
                        EndTime = "2026-08-08 10:00:00",
                },

                [10003] = {
                        id = 10003,
                        name = LocalStrEnum.activitySecondaryName_10003,
                        group = 1001,
                        type = 3,
                        parameter = {1,2,3},
                        StartTime = "2025-10-20 11:00:00",
                        EndTime = "2026-08-08 10:00:00",
                },

                [10004] = {
                        id = 10004,
                        name = LocalStrEnum.activitySecondaryName_10004,
                        group = 1001,
                        type = 4,
                        parameter = {4201},
                        StartTime = "2025-10-20 11:00:00",
                        EndTime = "2026-08-08 10:00:00",
                },

}
return ActivitySecondaryTable