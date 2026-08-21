---@class SurvivorRoleTable
---@field public id integer
---@field public role integer
---@field public roleRestraint integer
---@field public basicAttribute table
---@field public drop table
---@field public basicSkill table

---@type SurvivorRoleTable[]
local SurvivorRoleTable = {
                [10001] = {
                        id = 10001,
                        role = 1000101,
                        roleRestraint = 11,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10002] = {
                        id = 10002,
                        role = 1000201,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10003] = {
                        id = 10003,
                        role = 1000301,
                        roleRestraint = 24,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10004] = {
                        id = 10004,
                        role = 1000401,
                        roleRestraint = 42,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10005] = {
                        id = 10005,
                        role = 1000501,
                        roleRestraint = 11,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10006] = {
                        id = 10006,
                        role = 1000601,
                        roleRestraint = 23,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10007] = {
                        id = 10007,
                        role = 1000701,
                        roleRestraint = 12,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10008] = {
                        id = 10008,
                        role = 1000801,
                        roleRestraint = 51,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10009] = {
                        id = 10009,
                        role = 1000901,
                        roleRestraint = 61,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10010] = {
                        id = 10010,
                        role = 1001001,
                        roleRestraint = 43,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10011] = {
                        id = 10011,
                        role = 1001101,
                        roleRestraint = 32,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10012] = {
                        id = 10012,
                        role = 1001201,
                        roleRestraint = 21,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10013] = {
                        id = 10013,
                        role = 1001301,
                        roleRestraint = 21,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10014] = {
                        id = 10014,
                        role = 1001401,
                        roleRestraint = 51,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10015] = {
                        id = 10015,
                        role = 1001501,
                        roleRestraint = 32,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10016] = {
                        id = 10016,
                        role = 1001601,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10017] = {
                        id = 10017,
                        role = 1001701,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10018] = {
                        id = 10018,
                        role = 1001801,
                        roleRestraint = 23,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10019] = {
                        id = 10019,
                        role = 1001901,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10027] = {
                        id = 10027,
                        role = 1002701,
                        roleRestraint = 61,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10028] = {
                        id = 10028,
                        role = 1002801,
                        roleRestraint = 22,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10029] = {
                        id = 10029,
                        role = 1002901,
                        roleRestraint = 51,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10031] = {
                        id = 10031,
                        role = 1003101,
                        roleRestraint = 53,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10032] = {
                        id = 10032,
                        role = 1003201,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10033] = {
                        id = 10033,
                        role = 1003301,
                        roleRestraint = 42,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10037] = {
                        id = 10037,
                        role = 1003701,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10038] = {
                        id = 10038,
                        role = 1003801,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10039] = {
                        id = 10039,
                        role = 1003901,
                        roleRestraint = 21,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10040] = {
                        id = 10040,
                        role = 1004001,
                        roleRestraint = 53,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10042] = {
                        id = 10042,
                        role = 1004201,
                        roleRestraint = 51,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10043] = {
                        id = 10043,
                        role = 1004301,
                        roleRestraint = 42,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10052] = {
                        id = 10052,
                        role = 1005201,
                        roleRestraint = 11,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [10053] = {
                        id = 10053,
                        role = 1005301,
                        roleRestraint = 31,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=3,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

                [20001] = {
                        id = 20001,
                        role = 20003,
                        roleRestraint = 23,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=2,A13=1,A14=0,A15=0,A16=10},
                        drop = {{50, 1001}, {20,1002},{10,2001}},
                        basicSkill = {20001},
                },

                [20002] = {
                        id = 20002,
                        role = 20006,
                        roleRestraint = 11,
                        basicAttribute = {A1=100,A2=10,A3=1,A4=10,A5=10,A6=10,A7=10,A8=5,A9=0,A10=2,A11=0,A12=2,A13=1,A14=0,A15=0,A16=10},
                        drop = {},
                        basicSkill = {10001},
                },

}
return SurvivorRoleTable