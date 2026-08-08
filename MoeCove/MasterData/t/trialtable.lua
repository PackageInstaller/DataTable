---@class TrialTable
---@field public id integer
---@field public type integer
---@field public content table
---@field public pveLevel integer
---@field public reward table

---@type TrialTable[]
local TrialTable = {
                [100701] = {
                        id = 100701,
                        type = 1,
                        content = {10007},
                        pveLevel = 40101,
                        reward = {{1,100002,10},{1,100003,1000}},
                },

                [100801] = {
                        id = 100801,
                        type = 1,
                        content = {10008},
                        pveLevel = 40102,
                        reward = {{1,100002,10},{1,100003,1000}},
                },

                [100703] = {
                        id = 100703,
                        type = 2,
                        content = {1000703},
                        pveLevel = 40103,
                        reward = {{1,100002,10},{1,100003,1000}},
                },

                [100803] = {
                        id = 100803,
                        type = 2,
                        content = {1000803},
                        pveLevel = 40104,
                        reward = {{1,100002,10},{1,100003,1000}},
                },

}
return TrialTable