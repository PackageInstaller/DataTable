---@class SignAwardTable
---@field public id integer
---@field public group integer
---@field public coordinate integer
---@field public award table

---@type SignAwardTable[]
local SignAwardTable = {
                [1000101] = {
                        id = 1000101,
                        group = 10001,
                        coordinate = 1,
                        award = {{1,100003,5000}},
                },

                [1000102] = {
                        id = 1000102,
                        group = 10001,
                        coordinate = 2,
                        award = {{1,110052,5}},
                },

                [1000103] = {
                        id = 1000103,
                        group = 10001,
                        coordinate = 3,
                        award = {{1,100002,30}},
                },

                [1000104] = {
                        id = 1000104,
                        group = 10001,
                        coordinate = 4,
                        award = {{1,110009,5}},
                },

                [1000105] = {
                        id = 1000105,
                        group = 10001,
                        coordinate = 5,
                        award = {{1,100002,50}},
                },

                [1000106] = {
                        id = 1000106,
                        group = 10001,
                        coordinate = 6,
                        award = {{1,100012,20}},
                },

                [1000107] = {
                        id = 1000107,
                        group = 10001,
                        coordinate = 7,
                        award = {{1,110014,1}},
                },

                [2000101] = {
                        id = 2000101,
                        group = 20001,
                        coordinate = 1,
                        award = {{1,100002,50},{1,110011,5000}},
                },

                [2000102] = {
                        id = 2000102,
                        group = 20001,
                        coordinate = 2,
                        award = {{1,110016,5},{1,110053,10}},
                },

                [2000103] = {
                        id = 2000103,
                        group = 20001,
                        coordinate = 3,
                        award = {{1,100002,50},{1,100003,5000}},
                },

                [2000104] = {
                        id = 2000104,
                        group = 20001,
                        coordinate = 4,
                        award = {{1,100002,50},{3,300001,1}},
                },

                [2000105] = {
                        id = 2000105,
                        group = 20001,
                        coordinate = 5,
                        award = {{1,110016,5},{1,110010,5}},
                },

                [2000106] = {
                        id = 2000106,
                        group = 20001,
                        coordinate = 6,
                        award = {{1,100002,50},{1,100003,5000}},
                },

                [2000107] = {
                        id = 2000107,
                        group = 20001,
                        coordinate = 7,
                        award = {{1,100002,50},{3,300002,1}},
                },

                [2000108] = {
                        id = 2000108,
                        group = 20002,
                        coordinate = 1,
                        award = {{1,100002,50},{1,110011,5000}},
                },

                [2000109] = {
                        id = 2000109,
                        group = 20002,
                        coordinate = 2,
                        award = {{1,110016,5},{1,110053,10}},
                },

                [2000110] = {
                        id = 2000110,
                        group = 20002,
                        coordinate = 3,
                        award = {{1,100002,50},{1,100003,5000}},
                },

                [2000111] = {
                        id = 2000111,
                        group = 20002,
                        coordinate = 4,
                        award = {{1,100002,50},{3,300001,1}},
                },

                [2000112] = {
                        id = 2000112,
                        group = 20002,
                        coordinate = 5,
                        award = {{1,110016,5},{1,110010,5}},
                },

                [2000113] = {
                        id = 2000113,
                        group = 20002,
                        coordinate = 6,
                        award = {{1,100002,50},{1,100003,5000}},
                },

                [2000114] = {
                        id = 2000114,
                        group = 20002,
                        coordinate = 7,
                        award = {{1,100002,50},{3,300002,1}},
                },

}
return SignAwardTable