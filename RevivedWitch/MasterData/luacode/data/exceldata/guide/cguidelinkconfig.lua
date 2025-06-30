-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/guide/cguidelinkconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cguidelinkconfig = {}
cguidelinkconfig.Data = {
[1] = {id = 1, notes = "【5】快捷跳转引导", guideType = 1, skip = 0, StartCondition = "106,11", EndCondition = "106,17", FinalEndCondition = 3, 
stage = {101, 102}
}
, 
[2] = {id = 2, notes = "【4】人偶升级引导", guideType = 1, skip = 0, StartCondition = "55,124,82", EndCondition = "3", FinalEndCondition = 3, 
stage = {201, 202, 203, 204}
}
, 
[4] = {id = 4, notes = "【13】装备更换", guideType = 1, skip = 0, StartCondition = "12,13,14", EndCondition = "2", FinalEndCondition = 5, 
stage = {401, 402}
}
, 
[5] = {id = 5, notes = "【8】人偶升级引导后弱引导", guideType = 0, skip = 0, StartCondition = "106,124,108,86", EndCondition = "94", FinalEndCondition = 3, 
stage = {501, 502, 503, 504}
}
, 
[6] = {id = 6, notes = "【18】委托版-成就、每日", guideType = 1, skip = 0, StartCondition = "51,117", EndCondition = "52", FinalEndCondition = 7, 
stage = {601}
}
, 
[7] = {id = 7, notes = "【3】抽卡引导", guideType = 1, skip = 0, StartCondition = "124,7,16", EndCondition = "54", FinalEndCondition = 99, 
stage = {701, 702}
}
, 
[8] = {id = 8, notes = "【20】魔女庭院引导回城", guideType = 1, skip = 0, StartCondition = "56,21", EndCondition = "58", FinalEndCondition = 9, 
stage = {801}
}
, 
[9] = {id = 9, notes = "【11】委托版功能解锁引导", guideType = 1, skip = 0, StartCondition = "5,124", EndCondition = "8", FinalEndCondition = 4, 
stage = {901, 902}
}
, 
[10] = {id = 10, notes = "【1】编队引导", guideType = 1, skip = 0, StartCondition = "22,42", EndCondition = "20", FinalEndCondition = 1, 
stage = {1001, 1002, 1003}
}
, 
[11] = {id = 11, notes = "【17】资源副本引导", guideType = 1, skip = 0, StartCondition = "9,124,123,120", EndCondition = "24", FinalEndCondition = 7, 
stage = {1101, 1102, 1103}
}
, 
[12] = {id = 12, notes = "【33】战斗难度增高引导", guideType = 1, skip = 0, StartCondition = "61,21", EndCondition = "63", FinalEndCondition = 11, 
stage = {1201}
}
, 
[13] = {id = 13, notes = "【1】编队引导-确定按钮（选人后断线重连）", guideType = 1, skip = 0, StartCondition = "42,20", EndCondition = "23", FinalEndCondition = 1, 
stage = {1301}
}
, 
[14] = {id = 14, notes = "【7】人偶技能引导", guideType = 1, skip = 0, StartCondition = "1,29", EndCondition = "30", FinalEndCondition = 17, 
stage = {1401, 1402}
}
, 
[15] = {id = 15, notes = "【10】手动回城引导", guideType = 1, skip = 0, StartCondition = "40,43", EndCondition = "41", FinalEndCondition = 4, 
stage = {1501}
}
, 
[16] = {id = 16, notes = "【22】魔女庭院引导-解锁萤火灯台", guideType = 1, skip = 0, StartCondition = "74,75", EndCondition = "44", FinalEndCondition = 9, 
stage = {1601, 1602, 1603}
}
, 
[17] = {id = 17, notes = "【2】引导进入1-2", guideType = 1, skip = 0, StartCondition = "48,49,21", EndCondition = "50", FinalEndCondition = 2, 
stage = {1701, 1702}
}
, 
[19] = {id = 19, notes = "【34】好友引导", guideType = 1, skip = 0, StartCondition = "64", EndCondition = "69", FinalEndCondition = 15, 
stage = {1902, 1903}
}
, 
[20] = {id = 20, notes = "【35】助战引导", guideType = 1, skip = 0, StartCondition = "70,67", EndCondition = "71", FinalEndCondition = 15, 
stage = {2001, 2002}
}
, 
[21] = {id = 21, notes = "【21】魔女庭院主城引导", guideType = 1, skip = 0, StartCondition = "124,125", EndCondition = "73", FinalEndCondition = 9, 
stage = {2101}
}
, 
[22] = {id = 22, notes = "【11】好感度引导", guideType = 1, skip = 0, StartCondition = "124,59", EndCondition = "77", FinalEndCondition = 4, 
stage = {2201, 2202, 2203}
}
, 
[23] = {id = 23, notes = "【40】BOSS挑战", guideType = 1, skip = 0, StartCondition = "124,78", EndCondition = "79", FinalEndCondition = 41, 
stage = {2301, 2302, 2303, 2304, 2305}
}
, 
[24] = {id = 24, notes = "【11】看板娘引导", guideType = 1, skip = 0, StartCondition = "124,47", EndCondition = "87", FinalEndCondition = 4, 
stage = {2401, 2402, 2403}
}
, 
[25] = {id = 25, notes = "【32】人偶突破引导", guideType = 1, skip = 0, StartCondition = "83,155", EndCondition = "84", FinalEndCondition = 17, 
stage = {2501, 2502, 2503, 2504}
}
, 
[27] = {id = 27, notes = "【31】炼金所引导", guideType = 1, skip = 0, StartCondition = "10", EndCondition = "89", FinalEndCondition = 91, 
stage = {2701, 2702, 2703, 2704}
}
, 
[28] = {id = 28, notes = "【28】魔女小屋引导", guideType = 1, skip = 0, StartCondition = "127,46", EndCondition = "91", FinalEndCondition = 91, 
stage = {2801, 2802, 2803}
}
, 
[29] = {id = 29, notes = "作废（事象限界）", guideType = 1, skip = 0, StartCondition = "90,92,6", EndCondition = "93", FinalEndCondition = 999, 
stage = {}
}
, 
[30] = {id = 30, notes = "【11】看板娘引导完成后左上角返回引导", guideType = 1, skip = 0, StartCondition = "57,38", EndCondition = "57,76", FinalEndCondition = 4, 
stage = {3001}
}
, 
[31] = {id = 31, notes = "共鸣引导", guideType = 1, skip = 0, StartCondition = "99,100,124", EndCondition = "101", FinalEndCondition = 999, 
stage = {}
}
, 
[32] = {id = 32, notes = "作废（事象限界）", guideType = 1, skip = 0, StartCondition = "90,65", EndCondition = "68", FinalEndCondition = 91, 
stage = {3201}
}
, 
[33] = {id = 33, notes = "作废（事象限界）", guideType = 1, skip = 0, StartCondition = "90,6,80,81", EndCondition = "72", FinalEndCondition = 91, 
stage = {3301}
}
, 
[34] = {id = 34, notes = "作废（事象限界）", guideType = 1, skip = 0, StartCondition = "90,6,68,81", EndCondition = "85", FinalEndCondition = 91, 
stage = {3401}
}
, 
[35] = {id = 35, notes = "【18】成就、每日任务引导后，引导进入地宫", guideType = 0, skip = 0, StartCondition = "124,130,108,86", EndCondition = "112", FinalEndCondition = 7, 
stage = {501, 502, 503, 504}
}
, 
[36] = {id = 36, notes = "【29】魔女小屋2级引导", guideType = 1, skip = 0, StartCondition = "128,46", EndCondition = "114", FinalEndCondition = 91, 
stage = {}
}
, 
[37] = {id = 37, notes = "【30】魔女小屋3级引导", guideType = 1, skip = 0, StartCondition = "129,46", EndCondition = "116", FinalEndCondition = 91, 
stage = {}
}
, 
[40] = {id = 40, notes = "【16】资源副本Timeline引导", guideType = 1, skip = 0, StartCondition = "122,124", EndCondition = "123", FinalEndCondition = 7, 
stage = {}
}
, 
[41] = {id = 41, notes = "【20】魔女庭院主城timeline引导", guideType = 1, skip = 0, StartCondition = "124,58", EndCondition = "125", FinalEndCondition = 9, 
stage = {}
}
, 
[42] = {id = 42, notes = "【36】打完埃舍蕾回主城引导去伊敏瑟伦之间主城timeline引导", guideType = 1, skip = 0, StartCondition = "96,124", EndCondition = "97", FinalEndCondition = 18, 
stage = {}
}
, 
[43] = {id = 43, notes = "【36】事象记忆强引导", guideType = 1, skip = 0, StartCondition = "124,102", EndCondition = "131", FinalEndCondition = 18, 
stage = {4301, 4302, 4303, 4304}
}
, 
[45] = {id = 45, notes = "【9】替补角色引导", guideType = 1, skip = 0, StartCondition = "135,106,143", EndCondition = "136", FinalEndCondition = 3, 
stage = {4501, 4502, 4503}
}
, 
[46] = {id = 46, notes = "【37】事象记忆内部引导", guideType = 1, skip = 0, StartCondition = "124,131", EndCondition = "133", FinalEndCondition = 41, 
stage = {4301, 4302, 4603}
}
, 
[47] = {id = 47, notes = "【41】幻域纷争主城引导", guideType = 1, skip = 0, StartCondition = "124,138", EndCondition = "139", FinalEndCondition = 30, 
stage = {2601, 4702, 4703}
}
, 
[49] = {id = 49, notes = "【43】破碎之境主城引导", guideType = 1, skip = 0, StartCondition = "124,62", EndCondition = "142", FinalEndCondition = 43, 
stage = {2601, 4702, 4903}
}
, 
[50] = {id = 50, notes = "【7】抽卡引导-返回主城", guideType = 1, skip = 0, StartCondition = "55,25", EndCondition = "55,82", FinalEndCondition = 3, 
stage = {5001}
}
, 
[51] = {id = 51, notes = "【11】委托版功能解锁引导-返回主城", guideType = 1, skip = 0, StartCondition = "53,117", EndCondition = "53,27", FinalEndCondition = 4, 
stage = {5101}
}
, 
[52] = {id = 52, notes = "【12】委托版功能解锁引导-返回主城后弱引导", guideType = 0, skip = 0, StartCondition = "77,124,108,86", EndCondition = "18", FinalEndCondition = 4, 
stage = {501, 502, 503, 504}
}
, 
[53] = {id = 53, notes = "【14】装备强化引导", guideType = 1, skip = 0, StartCondition = "13,14,15,2", EndCondition = "28", FinalEndCondition = 5, 
stage = {401, 5302, 5303, 5304, 5305}
}
, 
[54] = {id = 54, notes = "【15】装备强化引导后弱引导", guideType = 0, skip = 0, StartCondition = "28,11,86", EndCondition = "28,17", FinalEndCondition = 5, 
stage = {5401, 5402, 5403}
}
, 
[55] = {id = 55, notes = "【23】魔女庭院引导-收集随机光点", guideType = 1, skip = 0, StartCondition = "75,44,32", EndCondition = "33", FinalEndCondition = 9, 
stage = {5501}
}
, 
[56] = {id = 56, notes = "【24】萤火灯台引导", guideType = 1, skip = 0, StartCondition = "75,33", EndCondition = "34", FinalEndCondition = 9, 
stage = {5601, 5602}
}
, 
[57] = {id = 57, notes = "【25】萤火灯台引导-返回庭院", guideType = 1, skip = 0, StartCondition = "34,35", EndCondition = "34,37", FinalEndCondition = 9, 
stage = {5701}
}
, 
[58] = {id = 58, notes = "【26】魔女庭院引导-解锁异界之镜", guideType = 1, skip = 0, StartCondition = "39,75", EndCondition = "45", FinalEndCondition = 9, 
stage = {5801, 5802, 5803}
}
, 
[59] = {id = 59, notes = "【27】异界之境引导", guideType = 1, skip = 0, StartCondition = "75,45", EndCondition = "31", FinalEndCondition = 9, 
stage = {5901, 5902}
}
, 
[60] = {id = 60, notes = "【38】爬塔副本2级引导-选择祝福卡", guideType = 1, skip = 0, StartCondition = "65", EndCondition = "68", FinalEndCondition = 999, 
stage = {3201}
}
, 
[61] = {id = 61, notes = "【38】爬塔副本自动探索引导", guideType = 1, skip = 0, StartCondition = "6,80,81", EndCondition = "72", FinalEndCondition = 999, 
stage = {3301}
}
, 
[62] = {id = 62, notes = "【38】事项限祝福查看", guideType = 1, skip = 0, StartCondition = "6,68,81", EndCondition = "85", FinalEndCondition = 999, 
stage = {3401}
}
, 
[63] = {id = 63, notes = "爬塔副本内部引导", guideType = 1, skip = 0, StartCondition = "92,6", EndCondition = "93", FinalEndCondition = 999, 
stage = {}
}
, 
[64] = {id = 64, notes = "海岛冒险内部引导", guideType = 1, skip = 0, StartCondition = "109,110", EndCondition = "111", FinalEndCondition = 999, 
stage = {6401}
}
, 
[65] = {id = 65, notes = "人偶重塑引导", guideType = 1, skip = 0, StartCondition = "144,145", EndCondition = "146", FinalEndCondition = 999, 
stage = {6501, 6502, 6503, 6504, 6505}
}
, 
[66] = {id = 66, notes = "Boss讨伐引导", guideType = 1, skip = 0, StartCondition = "147,148,150", EndCondition = "149", FinalEndCondition = 999, 
stage = {6601, 6602, 6603}
}
}
cguidelinkconfig.AllIds = {1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 40, 41, 42, 43, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66}
return cguidelinkconfig

