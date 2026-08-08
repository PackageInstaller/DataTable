---@class PassportMainTable
---@field public id integer
---@field public nameKey LocalStrEnum
---@field public PrivilegeGet table
---@field public CharacterSkin table
---@field public ActivityTag integer
---@field public imgOffset table

---@type PassportMainTable[]
local PassportMainTable = {
                [20001] = {
                        id = 20001,
                        nameKey = LocalStrEnum.ActivityName_20001,
                        PrivilegeGet = {{1,4001},{2,4002},{3,4003},{4,3001004}},
                        CharacterSkin = {1004003,1},
                        ActivityTag = 2001,
                        imgOffset = {0,0},
                },

                [20002] = {
                        id = 20002,
                        nameKey = LocalStrEnum.ActivityName_20002,
                        PrivilegeGet = {{1,4001},{2,4002},{3,4003},{4,3001004}},
                        CharacterSkin = {1004003,1},
                        ActivityTag = 2001,
                        imgOffset = {0,0},
                },

}
return PassportMainTable