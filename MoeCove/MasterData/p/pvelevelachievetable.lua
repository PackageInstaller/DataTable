---@class PveLevelAchieveTable
---@field public id integer
---@field public award table
---@field public type integer
---@field public achiveDesKey LocalStrEnum
---@field public triggerClose table

---@type PveLevelAchieveTable[]
local PveLevelAchieveTable = {
                [1000003] = {
                        id = 1000003,
                        award = {{1,110012,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_1000003,
                        triggerClose = {1000003},
                },

                [1000004] = {
                        id = 1000004,
                        award = {{1,110013,2}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_1000004,
                        triggerClose = {1000004,1000005},
                },

                [1000103] = {
                        id = 1000103,
                        award = {{1,130001,10}},
                        type = 1,
                        achiveDesKey = LocalStrEnum.achiveDes_1000103,
                        triggerClose = {1000103,1000104},
                },

                [3] = {
                        id = 3,
                        award = {{3,330101,1}},
                        type = 1,
                        achiveDesKey = LocalStrEnum.achiveDes_3,
                        triggerClose = {10101012},
                },

                [4] = {
                        id = 4,
                        award = {{1,110014,3}},
                        type = 1,
                        achiveDesKey = LocalStrEnum.achiveDes_4,
                        triggerClose = {10101013},
                },

                [2020101] = {
                        id = 2020101,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020101,
                        triggerClose = {2020103,2020104},
                },

                [2020301] = {
                        id = 2020301,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020301,
                        triggerClose = {2020304,2020305},
                },

                [2020302] = {
                        id = 2020302,
                        award = {{1,110052,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020302,
                        triggerClose = {2020306},
                },

                [2020401] = {
                        id = 2020401,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020401,
                        triggerClose = {2020403,2020404},
                },

                [2020402] = {
                        id = 2020402,
                        award = {{1,100003,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020402,
                        triggerClose = {2020405,2020406},
                },

                [2020501] = {
                        id = 2020501,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020501,
                        triggerClose = {2020503,2020504},
                },

                [2020502] = {
                        id = 2020502,
                        award = {{1,110011,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020502,
                        triggerClose = {2020503,2020506},
                },

                [2020601] = {
                        id = 2020601,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020601,
                        triggerClose = {2020604,2020605},
                },

                [2020602] = {
                        id = 2020602,
                        award = {{1,100003,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020602,
                        triggerClose = {2020606,2020607},
                },

                [2020603] = {
                        id = 2020603,
                        award = {{1,160018,2}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020603,
                        triggerClose = {2020608,2020609},
                },

                [2020701] = {
                        id = 2020701,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020701,
                        triggerClose = {2020703,2020704},
                },

                [2020702] = {
                        id = 2020702,
                        award = {{1,110052,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020702,
                        triggerClose = {2020705,2020706},
                },

                [2020801] = {
                        id = 2020801,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020801,
                        triggerClose = {2020804,2020805},
                },

                [2020802] = {
                        id = 2020802,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2020802,
                        triggerClose = {2020806,2020807},
                },

                [2030101] = {
                        id = 2030101,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030101,
                        triggerClose = {2030108,2030109},
                },

                [2030102] = {
                        id = 2030102,
                        award = {{1,100003,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030102,
                        triggerClose = {2030110,2030111},
                },

                [2030201] = {
                        id = 2030201,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030201,
                        triggerClose = {2030207,2030208},
                },

                [2030202] = {
                        id = 2030202,
                        award = {{1,110052,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030202,
                        triggerClose = {2030209},
                },

                [2030401] = {
                        id = 2030401,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030401,
                        triggerClose = {2030403,2030404},
                },

                [2030402] = {
                        id = 2030402,
                        award = {{1,110011,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030402,
                        triggerClose = {2030406,2030407},
                },

                [2030501] = {
                        id = 2030501,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030501,
                        triggerClose = {2030505,2030506},
                },

                [2030502] = {
                        id = 2030502,
                        award = {{1,100003,5000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030502,
                        triggerClose = {2030507,2030508},
                },

                [2030601] = {
                        id = 2030601,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030601,
                        triggerClose = {2030603,2030604},
                },

                [2030602] = {
                        id = 2030602,
                        award = {{1,110052,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030602,
                        triggerClose = {2030605,2030606},
                },

                [2030603] = {
                        id = 2030603,
                        award = {{1,160018,2}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2030603,
                        triggerClose = {2030607,2030608},
                },

                [2040101] = {
                        id = 2040101,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040101,
                        triggerClose = {2040103,2040104},
                },

                [2040102] = {
                        id = 2040102,
                        award = {{1,100003,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040102,
                        triggerClose = {2040105,2040106},
                },

                [2040301] = {
                        id = 2040301,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040301,
                        triggerClose = {2040303,2040304},
                },

                [2040302] = {
                        id = 2040302,
                        award = {{1,110052,5}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040302,
                        triggerClose = {2040305,2040306},
                },

                [2040501] = {
                        id = 2040501,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040501,
                        triggerClose = {2040503,2040504},
                },

                [2040502] = {
                        id = 2040502,
                        award = {{1,110011,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040502,
                        triggerClose = {2040505,2040506},
                },

                [2040601] = {
                        id = 2040601,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040601,
                        triggerClose = {2040603,2040604},
                },

                [2040602] = {
                        id = 2040602,
                        award = {{1,100003,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040602,
                        triggerClose = {2040605,2040606},
                },

                [2040701] = {
                        id = 2040701,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040701,
                        triggerClose = {2040703,2040704},
                },

                [2040702] = {
                        id = 2040702,
                        award = {{1,110052,5}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2040702,
                        triggerClose = {2040705,2040706},
                },

                [2050101] = {
                        id = 2050101,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050101,
                        triggerClose = {2050103,2050104},
                },

                [2050102] = {
                        id = 2050102,
                        award = {{1,100003,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050102,
                        triggerClose = {2050105,2050106},
                },

                [2050201] = {
                        id = 2050201,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050201,
                        triggerClose = {2050204,2050205},
                },

                [2050202] = {
                        id = 2050202,
                        award = {{1,110052,5}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050202,
                        triggerClose = {2050206,2050207},
                },

                [2050301] = {
                        id = 2050301,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050301,
                        triggerClose = {2050303,2050304},
                },

                [2050302] = {
                        id = 2050302,
                        award = {{1,110011,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050302,
                        triggerClose = {2050305,2050306},
                },

                [2050401] = {
                        id = 2050401,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050401,
                        triggerClose = {2050403,2050404},
                },

                [2050402] = {
                        id = 2050402,
                        award = {{1,100003,10000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050402,
                        triggerClose = {2050405,2050406},
                },

                [2050601] = {
                        id = 2050601,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050601,
                        triggerClose = {2050603,2050604},
                },

                [2050602] = {
                        id = 2050602,
                        award = {{1,110052,5}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050602,
                        triggerClose = {2050605,2050606},
                },

                [2050701] = {
                        id = 2050701,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050701,
                        triggerClose = {2050703,2050704},
                },

                [2050702] = {
                        id = 2050702,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2050702,
                        triggerClose = {2050705,2050706},
                },

                [2060101] = {
                        id = 2060101,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060101,
                        triggerClose = {2060113,2060114},
                },

                [2060102] = {
                        id = 2060102,
                        award = {{1,100003,15000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060102,
                        triggerClose = {2060115,2060116},
                },

                [2060103] = {
                        id = 2060103,
                        award = {{1,100011,100}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060103,
                        triggerClose = {2060117,2060118},
                },

                [2060201] = {
                        id = 2060201,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060201,
                        triggerClose = {2060203,2060204},
                },

                [2060202] = {
                        id = 2060202,
                        award = {{1,110053,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060202,
                        triggerClose = {2060205,2060206},
                },

                [2060301] = {
                        id = 2060301,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060301,
                        triggerClose = {2060313,2060314},
                },

                [2060302] = {
                        id = 2060302,
                        award = {{1,110011,15000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060302,
                        triggerClose = {2060315,2060316},
                },

                [2060303] = {
                        id = 2060303,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060303,
                        triggerClose = {2060317,2060318},
                },

                [2060401] = {
                        id = 2060401,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060401,
                        triggerClose = {2060403,2060404},
                },

                [2060402] = {
                        id = 2060402,
                        award = {{1,100003,15000}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060402,
                        triggerClose = {2060405,2060406},
                },

                [2060403] = {
                        id = 2060403,
                        award = {{1,160018,2}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060403,
                        triggerClose = {2060407,2060408},
                },

                [2060501] = {
                        id = 2060501,
                        award = {{1,110014,1}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060501,
                        triggerClose = {2060503,2060504},
                },

                [2060502] = {
                        id = 2060502,
                        award = {{1,110053,3}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060502,
                        triggerClose = {2060505,2060506},
                },

                [2060601] = {
                        id = 2060601,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060601,
                        triggerClose = {2060605,2060606},
                },

                [2060602] = {
                        id = 2060602,
                        award = {{1,100002,30}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060602,
                        triggerClose = {2060607,2060608},
                },

                [2060603] = {
                        id = 2060603,
                        award = {{1,100012,100}},
                        type = 2,
                        achiveDesKey = LocalStrEnum.achiveDes_2060603,
                        triggerClose = {2060609,2060610},
                },

}
return PveLevelAchieveTable