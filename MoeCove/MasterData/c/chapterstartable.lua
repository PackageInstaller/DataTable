---@class ChapterStarTable
---@field public id integer
---@field public chapterId integer
---@field public complete table
---@field public starAward table
---@field public sort integer

---@type ChapterStarTable[]
local ChapterStarTable = {
                [100101] = {
                        id = 100101,
                        chapterId = 1001,
                        complete = {1,6},
                        starAward = {{1,100002,50},{1,100003,5000},{1,110011,5000}},
                        sort = 1,
                },

                [100102] = {
                        id = 100102,
                        chapterId = 1001,
                        complete = {1,12},
                        starAward = {{1,110014,1},{1,100002,50},{1,110053,3}},
                        sort = 2,
                },

                [100103] = {
                        id = 100103,
                        chapterId = 1001,
                        complete = {1,21},
                        starAward = {{1,110014,2},{1,100002,80},{1,100005,1}},
                        sort = 3,
                },

                [100201] = {
                        id = 100201,
                        chapterId = 1002,
                        complete = {1,3},
                        starAward = {{1,100002,50},{1,100003,5000},{1,110011,5000}},
                        sort = 1,
                },

                [100202] = {
                        id = 100202,
                        chapterId = 1002,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100002,50},{1,170027,1}},
                        sort = 2,
                },

                [100203] = {
                        id = 100203,
                        chapterId = 1002,
                        complete = {1,12},
                        starAward = {{1,110014,2},{1,100002,80},{1,170031,1}},
                        sort = 3,
                },

                [100301] = {
                        id = 100301,
                        chapterId = 1003,
                        complete = {1,6},
                        starAward = {{1,100002,50},{1,100003,10000},{1,110011,10000}},
                        sort = 1,
                },

                [100302] = {
                        id = 100302,
                        chapterId = 1003,
                        complete = {1,9},
                        starAward = {{1,110014,1},{1,100002,50},{1,110053,5}},
                        sort = 2,
                },

                [100303] = {
                        id = 100303,
                        chapterId = 1003,
                        complete = {1,15},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,2}},
                        sort = 3,
                },

                [100401] = {
                        id = 100401,
                        chapterId = 1004,
                        complete = {1,6},
                        starAward = {{1,100002,50},{1,100003,10000},{1,110011,10000}},
                        sort = 1,
                },

                [100402] = {
                        id = 100402,
                        chapterId = 1004,
                        complete = {1,12},
                        starAward = {{1,110014,1},{1,100002,50},{1,110053,5}},
                        sort = 2,
                },

                [100403] = {
                        id = 100403,
                        chapterId = 1004,
                        complete = {1,18},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,2}},
                        sort = 3,
                },

                [100501] = {
                        id = 100501,
                        chapterId = 1005,
                        complete = {1,6},
                        starAward = {{1,100002,50},{1,100003,15000},{1,110011,15000}},
                        sort = 1,
                },

                [100502] = {
                        id = 100502,
                        chapterId = 1005,
                        complete = {1,12},
                        starAward = {{1,110014,1},{1,100002,50},{1,110053,6}},
                        sort = 2,
                },

                [100503] = {
                        id = 100503,
                        chapterId = 1005,
                        complete = {1,18},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,3}},
                        sort = 3,
                },

                [100601] = {
                        id = 100601,
                        chapterId = 1006,
                        complete = {1,6},
                        starAward = {{1,100002,50},{1,100003,15000},{1,110011,15000}},
                        sort = 1,
                },

                [100602] = {
                        id = 100602,
                        chapterId = 1006,
                        complete = {1,12},
                        starAward = {{1,110014,1},{1,100002,50},{1,110053,6}},
                        sort = 2,
                },

                [100603] = {
                        id = 100603,
                        chapterId = 1006,
                        complete = {1,18},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,3}},
                        sort = 3,
                },

                [200101] = {
                        id = 200101,
                        chapterId = 2001,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,10000},{1,110011,10000}},
                        sort = 1,
                },

                [200102] = {
                        id = 200102,
                        chapterId = 2001,
                        complete = {1,12},
                        starAward = {{1,110014,2},{1,100002,80},{1,110053,5}},
                        sort = 2,
                },

                [200103] = {
                        id = 200103,
                        chapterId = 2001,
                        complete = {1,21},
                        starAward = {{1,110014,3},{1,100002,100},{1,100005,1}},
                        sort = 3,
                },

                [200201] = {
                        id = 200201,
                        chapterId = 2002,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,10000},{1,110011,10000}},
                        sort = 1,
                },

                [200202] = {
                        id = 200202,
                        chapterId = 2002,
                        complete = {1,9},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,2}},
                        sort = 2,
                },

                [200203] = {
                        id = 200203,
                        chapterId = 2002,
                        complete = {1,15},
                        starAward = {{1,110014,3},{1,100002,100},{1,160001,3}},
                        sort = 3,
                },

                [200301] = {
                        id = 200301,
                        chapterId = 2003,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,15000},{1,110011,15000}},
                        sort = 1,
                },

                [200302] = {
                        id = 200302,
                        chapterId = 2003,
                        complete = {1,9},
                        starAward = {{1,110014,2},{1,100002,80},{1,110053,6}},
                        sort = 2,
                },

                [200303] = {
                        id = 200303,
                        chapterId = 2003,
                        complete = {1,15},
                        starAward = {{1,110014,3},{1,100002,100},{1,160002,3}},
                        sort = 3,
                },

                [200401] = {
                        id = 200401,
                        chapterId = 2004,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,15000},{1,110011,15000}},
                        sort = 1,
                },

                [200402] = {
                        id = 200402,
                        chapterId = 2004,
                        complete = {1,12},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,3}},
                        sort = 2,
                },

                [200403] = {
                        id = 200403,
                        chapterId = 2004,
                        complete = {1,18},
                        starAward = {{1,110014,3},{1,100002,100},{1,100012,100}},
                        sort = 3,
                },

                [200501] = {
                        id = 200501,
                        chapterId = 2005,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,20000},{1,110011,20000}},
                        sort = 1,
                },

                [200502] = {
                        id = 200502,
                        chapterId = 2005,
                        complete = {1,12},
                        starAward = {{1,110014,2},{1,100002,80},{1,110053,8}},
                        sort = 2,
                },

                [200503] = {
                        id = 200503,
                        chapterId = 2005,
                        complete = {1,18},
                        starAward = {{1,110014,3},{1,100002,100},{1,160003,2}},
                        sort = 3,
                },

                [200601] = {
                        id = 200601,
                        chapterId = 2006,
                        complete = {1,6},
                        starAward = {{1,110014,1},{1,100003,20000},{1,110011,20000}},
                        sort = 1,
                },

                [200602] = {
                        id = 200602,
                        chapterId = 2006,
                        complete = {1,12},
                        starAward = {{1,110014,2},{1,100002,80},{1,110010,5}},
                        sort = 2,
                },

                [200603] = {
                        id = 200603,
                        chapterId = 2006,
                        complete = {1,18},
                        starAward = {{1,110014,3},{1,100002,100},{1,100012,100}},
                        sort = 3,
                },

}
return ChapterStarTable