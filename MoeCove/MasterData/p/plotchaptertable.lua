---@class PlotChapterTable
---@field public id integer
---@field public type integer
---@field public title LocalStrEnum
---@field public synopsis LocalStrEnum
---@field public tag table
---@field public timeline integer
---@field public backGround string

---@type PlotChapterTable[]
local PlotChapterTable = {
                [101] = {
                        id = 101,
                        type = 1,
                        title = LocalStrEnum.title_name_101,
                        synopsis = LocalStrEnum.plot_synopsis_100001,
                        tag = nil,
                        timeline = 1,
                        backGround = "ill_plot_main_chapter_img_01",
                },

                [102] = {
                        id = 102,
                        type = 1,
                        title = LocalStrEnum.title_name_102,
                        synopsis = LocalStrEnum.plot_synopsis_100201,
                        tag = nil,
                        timeline = 2,
                        backGround = "ill_plot_main_chapter_img_02",
                },

}
return PlotChapterTable