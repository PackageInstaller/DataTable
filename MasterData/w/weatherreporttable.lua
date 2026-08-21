---@class WeatherReportTable
---@field public id integer
---@field public character integer
---@field public textType integer
---@field public condition table
---@field public weight integer
---@field public text LocalStrEnum
---@field public duration integer
---@field public spineAction table

---@type WeatherReportTable[]
local WeatherReportTable = {
                [10001] = {
                        id = 10001,
                        character = 10000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10001,
                        duration = 3.25,
                        spineAction = {{1,"sp1_action",true},{2,"laugh_talk",true}},
                },

                [10002] = {
                        id = 10002,
                        character = 10000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10002,
                        duration = 2.86,
                        spineAction = {{1,"sp2_action",true},{2,"laugh_talk",true}},
                },

                [10003] = {
                        id = 10003,
                        character = 10000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10003,
                        duration = 2.34,
                        spineAction = {{1,"idle_action",true},{2,"laugh_talk",true}},
                },

                [10004] = {
                        id = 10004,
                        character = 10000,
                        textType = 2,
                        condition = {{5,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10004,
                        duration = 0.26,
                        spineAction = {},
                },

                [10005] = {
                        id = 10005,
                        character = 10000,
                        textType = 2,
                        condition = {{5,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10005,
                        duration = 0.26,
                        spineAction = {},
                },

                [10006] = {
                        id = 10006,
                        character = 10000,
                        textType = 3,
                        condition = {{4,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10006,
                        duration = 0.26,
                        spineAction = {},
                },

                [10007] = {
                        id = 10007,
                        character = 10000,
                        textType = 3,
                        condition = {{4,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10007,
                        duration = 0.26,
                        spineAction = {},
                },

                [10008] = {
                        id = 10008,
                        character = 10000,
                        textType = 3,
                        condition = {{4,3}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10008,
                        duration = 0.26,
                        spineAction = {},
                },

                [10009] = {
                        id = 10009,
                        character = 10000,
                        textType = 3,
                        condition = {{4,4}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10009,
                        duration = 0.39,
                        spineAction = {},
                },

                [10010] = {
                        id = 10010,
                        character = 10000,
                        textType = 3,
                        condition = {{4,5}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10010,
                        duration = 0.78,
                        spineAction = {},
                },

                [10011] = {
                        id = 10011,
                        character = 10000,
                        textType = 3,
                        condition = {{4,6}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10011,
                        duration = 0.65,
                        spineAction = {},
                },

                [10012] = {
                        id = 10012,
                        character = 10000,
                        textType = 4,
                        condition = {{3,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10012,
                        duration = 2.21,
                        spineAction = {{2,"amazed_talk",true}},
                },

                [10013] = {
                        id = 10013,
                        character = 10000,
                        textType = 4,
                        condition = {{3,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10013,
                        duration = 2.34,
                        spineAction = {{2,"amazed_talk",true}},
                },

                [10014] = {
                        id = 10014,
                        character = 10000,
                        textType = 4,
                        condition = {{3,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10014,
                        duration = 2.34,
                        spineAction = {{2,"idle_talk",true}},
                },

                [10015] = {
                        id = 10015,
                        character = 10000,
                        textType = 4,
                        condition = {{3,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10015,
                        duration = 1.69,
                        spineAction = {{2,"idle_talk",true}},
                },

                [10016] = {
                        id = 10016,
                        character = 10000,
                        textType = 4,
                        condition = {{6,2,{4,1},{4,2},{4,4},{4,6},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10016,
                        duration = 1.95,
                        spineAction = {{2,"laugh_talk",true}},
                },

                [10017] = {
                        id = 10017,
                        character = 10000,
                        textType = 4,
                        condition = {{6,2,{4,1},{4,2},{4,4},{4,6},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10017,
                        duration = 2.21,
                        spineAction = {{2,"laugh_talk",true}},
                },

                [10018] = {
                        id = 10018,
                        character = 10000,
                        textType = 4,
                        condition = {{6,2,{4,3},{4,5},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_10018,
                        duration = 1.95,
                        spineAction = {{2,"laugh_talk",true}},
                },

                [10019] = {
                        id = 10019,
                        character = 10000,
                        textType = 5,
                        condition = {{1,0,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_10019,
                        duration = 2.73,
                        spineAction = {{1,"sp1_action",true},{2,"laugh_talk",true},{2,"laugh",true,2.73}},
                },

                [10020] = {
                        id = 10020,
                        character = 10000,
                        textType = 5,
                        condition = {{1,1,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_10020,
                        duration = 4.16,
                        spineAction = {{1,"idle_action",true},{2,"sad_talk",true},{2,"sad",true,4.16}},
                },

                [10021] = {
                        id = 10021,
                        character = 10000,
                        textType = 5,
                        condition = {{1,2,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_10021,
                        duration = 3.9,
                        spineAction = {{1,"idle_action",true},{2,"laugh_talk",true},{2,"laugh",true,3.9}},
                },

                [10022] = {
                        id = 10022,
                        character = 10000,
                        textType = 5,
                        condition = {},
                        weight = 1,
                        text = LocalStrEnum.ReprotText_10022,
                        duration = 2.99,
                        spineAction = {{1,"sp2_action",true},{2,"laugh_talk",true},{2,"laugh",true,2.99}},
                },

                [20001] = {
                        id = 20001,
                        character = 20000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20001,
                        duration = 3.77,
                        spineAction = {{1,"idle_action",true},{2,"shy_talk",true}},
                },

                [20002] = {
                        id = 20002,
                        character = 20000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20002,
                        duration = 2.6,
                        spineAction = {{1,"sp2_action",true},{2,"idle_talk",true}},
                },

                [20003] = {
                        id = 20003,
                        character = 20000,
                        textType = 1,
                        condition = {},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20003,
                        duration = 1.04,
                        spineAction = {{1,"idle_action",true},{2,"closeeye_talk",true}},
                },

                [20004] = {
                        id = 20004,
                        character = 20000,
                        textType = 2,
                        condition = {{5,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20004,
                        duration = 0.26,
                        spineAction = {},
                },

                [20005] = {
                        id = 20005,
                        character = 20000,
                        textType = 2,
                        condition = {{5,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20005,
                        duration = 0.26,
                        spineAction = {},
                },

                [20006] = {
                        id = 20006,
                        character = 20000,
                        textType = 3,
                        condition = {{4,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20006,
                        duration = 0.26,
                        spineAction = {},
                },

                [20007] = {
                        id = 20007,
                        character = 20000,
                        textType = 3,
                        condition = {{4,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20007,
                        duration = 0.26,
                        spineAction = {},
                },

                [20008] = {
                        id = 20008,
                        character = 20000,
                        textType = 3,
                        condition = {{4,3}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20008,
                        duration = 0.26,
                        spineAction = {},
                },

                [20009] = {
                        id = 20009,
                        character = 20000,
                        textType = 3,
                        condition = {{4,4}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20009,
                        duration = 0.65,
                        spineAction = {},
                },

                [20010] = {
                        id = 20010,
                        character = 20000,
                        textType = 3,
                        condition = {{4,5}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20010,
                        duration = 0.52,
                        spineAction = {},
                },

                [20011] = {
                        id = 20011,
                        character = 20000,
                        textType = 3,
                        condition = {{4,6}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20011,
                        duration = 0.39,
                        spineAction = {},
                },

                [20012] = {
                        id = 20012,
                        character = 20000,
                        textType = 4,
                        condition = {{3,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20012,
                        duration = 1.82,
                        spineAction = {{2,"closeeye_talk",true}},
                },

                [20013] = {
                        id = 20013,
                        character = 20000,
                        textType = 4,
                        condition = {{3,1}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20013,
                        duration = 2.21,
                        spineAction = {{2,"sad_talk",true}},
                },

                [20014] = {
                        id = 20014,
                        character = 20000,
                        textType = 4,
                        condition = {{3,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20014,
                        duration = 2.34,
                        spineAction = {{2,"idle_talk",true}},
                },

                [20015] = {
                        id = 20015,
                        character = 20000,
                        textType = 4,
                        condition = {{3,2}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20015,
                        duration = 1.56,
                        spineAction = {{2,"idle_talk",true}},
                },

                [20016] = {
                        id = 20016,
                        character = 20000,
                        textType = 4,
                        condition = {{6,2,{4,1},{4,2},{4,4},{4,6},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20016,
                        duration = 1.17,
                        spineAction = {{2,"laugh_talk",true}},
                },

                [20017] = {
                        id = 20017,
                        character = 20000,
                        textType = 4,
                        condition = {{6,2,{4,1},{4,2},{4,4},{4,6},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20017,
                        duration = 1.82,
                        spineAction = {{2,"idle_talk",true}},
                },

                [20018] = {
                        id = 20018,
                        character = 20000,
                        textType = 4,
                        condition = {{6,2,{4,3},{4,5},{3,0}}},
                        weight = 100,
                        text = LocalStrEnum.ReprotText_20018,
                        duration = 1.04,
                        spineAction = {{2,"shy_talk",true,0.35}},
                },

                [20019] = {
                        id = 20019,
                        character = 20000,
                        textType = 5,
                        condition = {{1,0,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_20019,
                        duration = 2.99,
                        spineAction = {{2,"laugh_talk",true},{2,"laugh",true,2.99}},
                },

                [20020] = {
                        id = 20020,
                        character = 20000,
                        textType = 5,
                        condition = {{1,1,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_20020,
                        duration = 2.99,
                        spineAction = {{2,"sad_talk",true},{2,"sad",true,2.99}},
                },

                [20021] = {
                        id = 20021,
                        character = 20000,
                        textType = 5,
                        condition = {{1,2,1,3}},
                        weight = 1000,
                        text = LocalStrEnum.ReprotText_20021,
                        duration = 3.38,
                        spineAction = {{2,"closeeye_talk",true},{2,"closeeye",true,3.38}},
                },

                [20022] = {
                        id = 20022,
                        character = 20000,
                        textType = 5,
                        condition = {},
                        weight = 1,
                        text = LocalStrEnum.ReprotText_20022,
                        duration = 1.95,
                        spineAction = {{2,"idle_talk",true},{2,"idle",true,1.95}},
                },

}
return WeatherReportTable