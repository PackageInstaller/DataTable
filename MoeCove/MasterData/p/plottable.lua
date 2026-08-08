---@class PlotTable
---@field public id integer
---@field public chapter integer
---@field public content table
---@field public title LocalStrEnum
---@field public synopsis LocalStrEnum
---@field public storyImage table

---@type PlotTable[]
local PlotTable = {
                [100001] = {
                        id = 100001,
                        chapter = 101,
                        content = {101011},
                        title = LocalStrEnum.plot_title_100001,
                        synopsis = LocalStrEnum.plot_synopsis_100001,
                        storyImage = {"scene_seafloor",{}},
                },

                [100002] = {
                        id = 100002,
                        chapter = 101,
                        content = {101021},
                        title = LocalStrEnum.plot_title_100002,
                        synopsis = LocalStrEnum.plot_synopsis_100002,
                        storyImage = {"scene_sea_night",{10006}},
                },

                [100003] = {
                        id = 100003,
                        chapter = 101,
                        content = {101023},
                        title = LocalStrEnum.plot_title_100003,
                        synopsis = LocalStrEnum.plot_synopsis_100003,
                        storyImage = {"scene_sea_night",{10004,10006}},
                },

                [100004] = {
                        id = 100004,
                        chapter = 101,
                        content = {101031},
                        title = LocalStrEnum.plot_title_100004,
                        synopsis = LocalStrEnum.plot_synopsis_100004,
                        storyImage = {"scene_coco",{}},
                },

                [100005] = {
                        id = 100005,
                        chapter = 101,
                        content = {102011},
                        title = LocalStrEnum.plot_title_100005,
                        synopsis = LocalStrEnum.plot_synopsis_100005,
                        storyImage = {"scene_corridor",{10004}},
                },

                [100006] = {
                        id = 100006,
                        chapter = 101,
                        content = {102012},
                        title = LocalStrEnum.plot_title_100006,
                        synopsis = LocalStrEnum.plot_synopsis_100006,
                        storyImage = {"scene_headquarters",{10006,10004}},
                },

                [100007] = {
                        id = 100007,
                        chapter = 101,
                        content = {102021},
                        title = LocalStrEnum.plot_title_100007,
                        synopsis = LocalStrEnum.plot_synopsis_100007,
                        storyImage = {"scene_sea_day",{10002}},
                },

                [100008] = {
                        id = 100008,
                        chapter = 101,
                        content = {102031},
                        title = LocalStrEnum.plot_title_100008,
                        synopsis = LocalStrEnum.plot_synopsis_100008,
                        storyImage = {"scene_sea_day",{10006,10004,10002}},
                },

                [100009] = {
                        id = 100009,
                        chapter = 101,
                        content = {102051},
                        title = LocalStrEnum.plot_title_100009,
                        synopsis = LocalStrEnum.plot_synopsis_100009,
                        storyImage = {"scene_sea_day",{10006,10004}},
                },

                [100010] = {
                        id = 100010,
                        chapter = 101,
                        content = {102055},
                        title = LocalStrEnum.plot_title_100010,
                        synopsis = LocalStrEnum.plot_synopsis_100010,
                        storyImage = {"scene_sea_day",{10002}},
                },

                [100011] = {
                        id = 100011,
                        chapter = 101,
                        content = {102061},
                        title = LocalStrEnum.plot_title_100011,
                        synopsis = LocalStrEnum.plot_synopsis_100011,
                        storyImage = {"scene_sea_day",{10002}},
                },

                [100012] = {
                        id = 100012,
                        chapter = 101,
                        content = {102063},
                        title = LocalStrEnum.plot_title_100012,
                        synopsis = LocalStrEnum.plot_synopsis_100012,
                        storyImage = {"scene_sea_day",{10003,10002}},
                },

                [100013] = {
                        id = 100013,
                        chapter = 101,
                        content = {102071},
                        title = LocalStrEnum.plot_title_100013,
                        synopsis = LocalStrEnum.plot_synopsis_100013,
                        storyImage = {"scene_headquarters",{10006,10003,10004}},
                },

                [100014] = {
                        id = 100014,
                        chapter = 101,
                        content = {102081},
                        title = LocalStrEnum.plot_title_100014,
                        synopsis = LocalStrEnum.plot_synopsis_100014,
                        storyImage = {"scene_sea_cloudy2",{10002}},
                },

                [100015] = {
                        id = 100015,
                        chapter = 101,
                        content = {102091},
                        title = LocalStrEnum.plot_title_100015,
                        synopsis = LocalStrEnum.plot_synopsis_100015,
                        storyImage = {"scene_office",{10002,10004,10003}},
                },

                [100201] = {
                        id = 100201,
                        chapter = 102,
                        content = {103011},
                        title = LocalStrEnum.plot_title_100201,
                        synopsis = LocalStrEnum.plot_synopsis_100201,
                        storyImage = {"scene_headquarters",{10010,10001,10009}},
                },

                [100202] = {
                        id = 100202,
                        chapter = 102,
                        content = {103012},
                        title = LocalStrEnum.plot_title_100202,
                        synopsis = LocalStrEnum.plot_synopsis_100202,
                        storyImage = {"scene_office3",{10000}},
                },

                [100203] = {
                        id = 100203,
                        chapter = 102,
                        content = {103021},
                        title = LocalStrEnum.plot_title_100203,
                        synopsis = LocalStrEnum.plot_synopsis_100203,
                        storyImage = {"scene_office",{10004}},
                },

                [100204] = {
                        id = 100204,
                        chapter = 102,
                        content = {103031},
                        title = LocalStrEnum.plot_title_100204,
                        synopsis = LocalStrEnum.plot_synopsis_100204,
                        storyImage = {"scene_room",{10004,10002,10006}},
                },

                [100205] = {
                        id = 100205,
                        chapter = 102,
                        content = {103041},
                        title = LocalStrEnum.plot_title_100205,
                        synopsis = LocalStrEnum.plot_synopsis_100205,
                        storyImage = {"scene_sea_day",{10004,10006}},
                },

                [100206] = {
                        id = 100206,
                        chapter = 102,
                        content = {103042},
                        title = LocalStrEnum.plot_title_100206,
                        synopsis = LocalStrEnum.plot_synopsis_100206,
                        storyImage = {"scene_headquarters",{10004,10000,10006}},
                },

                [100207] = {
                        id = 100207,
                        chapter = 102,
                        content = {103051},
                        title = LocalStrEnum.plot_title_100207,
                        synopsis = LocalStrEnum.plot_synopsis_100207,
                        storyImage = {"scene_corridor",{20000}},
                },

                [100208] = {
                        id = 100208,
                        chapter = 102,
                        content = {103061},
                        title = LocalStrEnum.plot_title_100208,
                        synopsis = LocalStrEnum.plot_synopsis_100208,
                        storyImage = {"scene_sea_day",{10001,10018}},
                },

                [100209] = {
                        id = 100209,
                        chapter = 102,
                        content = {103062},
                        title = LocalStrEnum.plot_title_100209,
                        synopsis = LocalStrEnum.plot_synopsis_100209,
                        storyImage = {"scene_sea_day",{10001,10003}},
                },

                [100210] = {
                        id = 100210,
                        chapter = 102,
                        content = {103071},
                        title = LocalStrEnum.plot_title_100210,
                        synopsis = LocalStrEnum.plot_synopsis_100210,
                        storyImage = {"scene_headquarters",{10001}},
                },

}
return PlotTable