-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/role/cattreffectidname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cattreffectidname = {}
cattreffectidname.Data = {
[10] = {id = 10, classname = "当前生命", classnameTextID = 501729, isDecimal = 0, classIcon = 10150, attrname = "hp", initValue = 0, ablEffctId = 11, ablEffctName = "hp_value", ablLimit = 999999, pctEffctId = 12, pctEffctName = "hp_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[20] = {id = 20, classname = "生命", classnameTextID = 501730, isDecimal = 0, classIcon = 10150, attrname = "maxhp", initValue = 0, ablEffctId = 21, ablEffctName = "maxhp_value", ablLimit = 999999, pctEffctId = 22, pctEffctName = "maxhp_percent", pctLimit = 10000, classgrowthname = "生命成长", classgrowthnameTextID = 501787, basicattr = "staticmaxhp"}
, 
[30] = {id = 30, classname = "攻击", classnameTextID = 501731, isDecimal = 0, classIcon = 10153, attrname = "attack", initValue = 0, ablEffctId = 31, ablEffctName = "attack_value", ablLimit = 999999, pctEffctId = 32, pctEffctName = "attack_percent", pctLimit = 10000, classgrowthname = "攻击成长", classgrowthnameTextID = 501788, basicattr = "staticattack"}
, 
[40] = {id = 40, classname = "攻击", classnameTextID = 501732, isDecimal = 0, classIcon = 10151, attrname = "magicatk", initValue = 0, ablEffctId = 41, ablEffctName = "magicatk_value", ablLimit = 999999, pctEffctId = 42, pctEffctName = "magicatk_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = "staticmagicatk"}
, 
[50] = {id = 50, classname = "物理防御", classnameTextID = 501733, isDecimal = 0, classIcon = 10154, attrname = "defend", initValue = 0, ablEffctId = 51, ablEffctName = "defend_value", ablLimit = 999999, pctEffctId = 52, pctEffctName = "defend_percent", pctLimit = 10000, classgrowthname = "物防成长", classgrowthnameTextID = 501789, basicattr = "staticdefend"}
, 
[60] = {id = 60, classname = "魔法防御", classnameTextID = 501734, isDecimal = 0, classIcon = 10152, attrname = "magicdef", initValue = 0, ablEffctId = 61, ablEffctName = "magicdef_value", ablLimit = 999999, pctEffctId = 62, pctEffctName = "magicdef_percent", pctLimit = 10000, classgrowthname = "魔防成长", classgrowthnameTextID = 501790, basicattr = "staticmagicdef"}
, 
[70] = {id = 70, classname = "速度", classnameTextID = 501735, isDecimal = 0, classIcon = 10155, attrname = "movespeed", initValue = 0, ablEffctId = 71, ablEffctName = "movespeed_value", ablLimit = 999999, pctEffctId = 72, pctEffctName = "movespeed_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[80] = {id = 80, classname = "本次攻击造成伤害", classnameTextID = 501736, isDecimal = 0, classIcon = 10153, attrname = "damage", initValue = 0, ablEffctId = 81, ablEffctName = "damage_value", ablLimit = 999999, pctEffctId = 82, pctEffctName = "damage_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[90] = {id = 90, classname = "物伤加成", classnameTextID = 501737, isDecimal = 1, classIcon = 0, attrname = "physicalbonus", initValue = 0, ablEffctId = 91, ablEffctName = "physicalbonus_value", ablLimit = 999999, pctEffctId = 92, pctEffctName = "physicalbonus_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[100] = {id = 100, classname = "物伤减免", classnameTextID = 501738, isDecimal = 1, classIcon = 0, attrname = "physicalreduce", initValue = 0, ablEffctId = 101, ablEffctName = "physicalreduce_value", ablLimit = 999999, pctEffctId = 102, pctEffctName = "physicalreduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[110] = {id = 110, classname = "魔伤加成", classnameTextID = 501739, isDecimal = 1, classIcon = 0, attrname = "magicbonus", initValue = 0, ablEffctId = 111, ablEffctName = "magicbonus_value", ablLimit = 999999, pctEffctId = 112, pctEffctName = "magicbonus_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[120] = {id = 120, classname = "魔伤减免", classnameTextID = 501740, isDecimal = 1, classIcon = 0, attrname = "magicreduce", initValue = 0, ablEffctId = 121, ablEffctName = "magicreduce_value", ablLimit = 999999, pctEffctId = 122, pctEffctName = "magicreduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[130] = {id = 130, classname = "暴击率", classnameTextID = 501741, isDecimal = 1, classIcon = 10495, attrname = "critrate", initValue = 80, ablEffctId = 131, ablEffctName = "critrate_value", ablLimit = 999999, pctEffctId = 132, pctEffctName = "critrate_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = "staticcritrate"}
, 
[140] = {id = 140, classname = "暴击程度", classnameTextID = 501742, isDecimal = 1, classIcon = 10496, attrname = "critdegree", initValue = 1500, ablEffctId = 141, ablEffctName = "critdegree_value", ablLimit = 999999, pctEffctId = 142, pctEffctName = "critdegree_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = "staticcritdegree"}
, 
[150] = {id = 150, classname = "暴击率（废弃）", classnameTextID = 501743, isDecimal = 1, classIcon = 0, attrname = "magiccritrate", initValue = 0, ablEffctId = 151, ablEffctName = "magiccritrate_value", ablLimit = 999999, pctEffctId = 152, pctEffctName = "magiccritrate_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[160] = {id = 160, classname = "暴击程度（废弃）", classnameTextID = 501744, isDecimal = 1, classIcon = 0, attrname = "magiccritratedegree", initValue = 0, ablEffctId = 161, ablEffctName = "magiccritratedegree_value", ablLimit = 999999, pctEffctId = 162, pctEffctName = "magiccritratedegree_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[170] = {id = 170, classname = "攻击速度", classnameTextID = 501745, isDecimal = 1, classIcon = 0, attrname = "attackspeed", initValue = 0, ablEffctId = 171, ablEffctName = "attackspeed_value", ablLimit = 999999, pctEffctId = 172, pctEffctName = "attackspeed_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[180] = {id = 180, classname = "闪避率", classnameTextID = 501746, isDecimal = 1, classIcon = 0, attrname = "evasion", initValue = 0, ablEffctId = 181, ablEffctName = "evasion_value", ablLimit = 999999, pctEffctId = 182, pctEffctName = "evasion_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[190] = {id = 190, classname = "物理吸血", classnameTextID = 501747, isDecimal = 1, classIcon = 0, attrname = "physicallifesteal", initValue = 0, ablEffctId = 191, ablEffctName = "physicallifesteal_value", ablLimit = 999999, pctEffctId = 192, pctEffctName = "physicallifesteal_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[200] = {id = 200, classname = "魔法吸血", classnameTextID = 501748, isDecimal = 1, classIcon = 0, attrname = "magiclifesteal", initValue = 0, ablEffctId = 201, ablEffctName = "magiclifesteal_value", ablLimit = 999999, pctEffctId = 202, pctEffctName = "magiclifesteal_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[210] = {id = 210, classname = "物理格挡", classnameTextID = 501749, isDecimal = 0, classIcon = 0, attrname = "physicalblock", initValue = 0, ablEffctId = 211, ablEffctName = "physicalblock_value", ablLimit = 999999, pctEffctId = 212, pctEffctName = "physicalblock_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[220] = {id = 220, classname = "魔法格挡", classnameTextID = 501750, isDecimal = 0, classIcon = 0, attrname = "magicblock", initValue = 0, ablEffctId = 221, ablEffctName = "magicblock_value", ablLimit = 999999, pctEffctId = 222, pctEffctName = "magicblock_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[230] = {id = 230, classname = "承受伤害值", classnameTextID = 501751, isDecimal = 0, classIcon = 0, attrname = "totaldmg", initValue = 0, ablEffctId = 231, ablEffctName = "totaldmg_value", ablLimit = 999999, pctEffctId = 232, pctEffctName = "totaldmg_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[240] = {id = 240, classname = "魔法闪避率", classnameTextID = 501752, isDecimal = 1, classIcon = 0, attrname = "magicevasion", initValue = 0, ablEffctId = 241, ablEffctName = "magicevasion_value", ablLimit = 999999, pctEffctId = 242, pctEffctName = "magicevasion_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[250] = {id = 250, classname = "物理穿透", classnameTextID = 501753, isDecimal = 0, classIcon = 0, attrname = "physicaldefbreak", initValue = 0, ablEffctId = 251, ablEffctName = "physicaldefbreak_value", ablLimit = 999999, pctEffctId = 252, pctEffctName = "physicaldefbreak_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[260] = {id = 260, classname = "魔法穿透", classnameTextID = 501754, isDecimal = 0, classIcon = 0, attrname = "magicdefbreak", initValue = 0, ablEffctId = 261, ablEffctName = "magicdefbreak_value", ablLimit = 999999, pctEffctId = 262, pctEffctName = "magicdefbreak_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[270] = {id = 270, classname = "暴击率抗性", classnameTextID = 502803, isDecimal = 1, classIcon = 13203, attrname = "critrateresistance", initValue = 0, ablEffctId = 271, ablEffctName = "critrateresistance_value", ablLimit = 999999, pctEffctId = 272, pctEffctName = "critrateresistance_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[280] = {id = 280, classname = "暴击抗性（废弃）", classnameTextID = 501756, isDecimal = 1, classIcon = 0, attrname = "magiccritrateresistance", initValue = 0, ablEffctId = 281, ablEffctName = "magiccritrateresistance_value", ablLimit = 999999, pctEffctId = 282, pctEffctName = "magiccritrateresistance_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[290] = {id = 290, classname = "附加物理伤害", classnameTextID = 501757, isDecimal = 0, classIcon = 0, attrname = "extraphysicaldmg", initValue = 0, ablEffctId = 291, ablEffctName = "extraphysicaldmg_value", ablLimit = 999999, pctEffctId = 292, pctEffctName = "extraphysicaldmg_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[300] = {id = 300, classname = "附加魔法伤害", classnameTextID = 501758, isDecimal = 0, classIcon = 0, attrname = "extramagicdmg", initValue = 0, ablEffctId = 301, ablEffctName = "extramagicdmg_value", ablLimit = 999999, pctEffctId = 302, pctEffctName = "extramagicdmg_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[310] = {id = 310, classname = "受治疗效果加成", classnameTextID = 501759, isDecimal = 1, classIcon = 0, attrname = "curativeadd", initValue = 0, ablEffctId = 311, ablEffctName = "curativeadd_value", ablLimit = 999999, pctEffctId = 312, pctEffctName = "curativeadd_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[320] = {id = 320, classname = "命中率", classnameTextID = 501760, isDecimal = 1, classIcon = 0, attrname = "accuracy", initValue = 0, ablEffctId = 321, ablEffctName = "accuracy_value", ablLimit = 999999, pctEffctId = 322, pctEffctName = "accuracy_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[330] = {id = 330, classname = "秩序能量", classnameTextID = 501761, isDecimal = 0, classIcon = 0, attrname = "orderpwr", initValue = 0, ablEffctId = 331, ablEffctName = "orderpwr_value", ablLimit = 999999, pctEffctId = 332, pctEffctName = "orderpwr_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[340] = {id = 340, classname = "混沌能量", classnameTextID = 501762, isDecimal = 0, classIcon = 0, attrname = "chaospwr", initValue = 0, ablEffctId = 341, ablEffctName = "chaospwr_value", ablLimit = 999999, pctEffctId = 342, pctEffctName = "chaospwr_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[350] = {id = 350, classname = "伤害技能加成", classnameTextID = 501763, isDecimal = 1, classIcon = 0, attrname = "dmgskilladd", initValue = 0, ablEffctId = 351, ablEffctName = "dmgskilladd_value", ablLimit = 999999, pctEffctId = 352, pctEffctName = "dmgskilladd_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[360] = {id = 360, classname = "恢复技能加成", classnameTextID = 501764, isDecimal = 1, classIcon = 0, attrname = "healskilladd", initValue = 0, ablEffctId = 361, ablEffctName = "healskilladd_value", ablLimit = 999999, pctEffctId = 362, pctEffctName = "healskilladd_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[370] = {id = 370, classname = "单次技能伤害", classnameTextID = 501765, isDecimal = 0, classIcon = 0, attrname = "skilldamage", initValue = 0, ablEffctId = 371, ablEffctName = "skilldamage_value", ablLimit = 999999, pctEffctId = 372, pctEffctName = "skilldamage_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[380] = {id = 380, classname = "消耗秩序能量", classnameTextID = 501766, isDecimal = 0, classIcon = 0, attrname = "ordercost", initValue = 0, ablEffctId = 381, ablEffctName = "ordercost_value", ablLimit = 999999, pctEffctId = 382, pctEffctName = "ordercost_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[390] = {id = 390, classname = "消耗混沌能量", classnameTextID = 501767, isDecimal = 0, classIcon = 0, attrname = "chaoscost", initValue = 0, ablEffctId = 391, ablEffctName = "chaoscost_value", ablLimit = 999999, pctEffctId = 392, pctEffctName = "chaoscost_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[400] = {id = 400, classname = "驱散buff数量", classnameTextID = 501768, isDecimal = 0, classIcon = 0, attrname = "dispelbuffnum", initValue = 0, ablEffctId = 401, ablEffctName = "dispelbuffnum_value", ablLimit = 999999, pctEffctId = 402, pctEffctName = "dispelbuffnum_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[410] = {id = 410, classname = "怪物类型", classnameTextID = 501769, isDecimal = 0, classIcon = 0, attrname = "monstertype", initValue = 0, ablEffctId = 411, ablEffctName = "monstertype_value", ablLimit = 999999, pctEffctId = 412, pctEffctName = "monstertype_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[420] = {id = 420, classname = "护盾值", classnameTextID = 501770, isDecimal = 0, classIcon = 0, attrname = "shield", initValue = 0, ablEffctId = 421, ablEffctName = "shield_value", ablLimit = 999999, pctEffctId = 423, pctEffctName = "shield_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[430] = {id = 430, classname = "连击点", classnameTextID = 501771, isDecimal = 0, classIcon = 0, attrname = "combonum", initValue = 0, ablEffctId = 431, ablEffctName = "combonum_value", ablLimit = 999999, pctEffctId = 433, pctEffctName = "combonum_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[440] = {id = 440, classname = "冷却缩短", classnameTextID = 501772, isDecimal = 0, classIcon = 0, attrname = "cooldownreduce", initValue = 0, ablEffctId = 441, ablEffctName = "cooldownreduce_value", ablLimit = 999999, pctEffctId = 441, pctEffctName = "cooldownreduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[450] = {id = 450, classname = "被动技能生效", classnameTextID = 501773, isDecimal = 0, classIcon = 0, attrname = "passiveskill", initValue = 0, ablEffctId = 451, ablEffctName = "passiveskill_value", ablLimit = 999999, pctEffctId = 452, pctEffctName = "passiveskill_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[460] = {id = 460, classname = "是否包含负面状态", classnameTextID = 501774, isDecimal = 0, classIcon = 0, attrname = "isdebuff", initValue = 0, ablEffctId = 461, ablEffctName = "isdebuff_value", ablLimit = 999999, pctEffctId = 462, pctEffctName = "isdebuff_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[470] = {id = 470, classname = "秩序能量消耗减少", classnameTextID = 501775, isDecimal = 0, classIcon = 0, attrname = "ordercostreduce", initValue = 0, ablEffctId = 471, ablEffctName = "ordercostreduce_value", ablLimit = 999999, pctEffctId = 472, pctEffctName = "ordercostreduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[480] = {id = 480, classname = "混沌能量消耗减少", classnameTextID = 501776, isDecimal = 0, classIcon = 0, attrname = "chaoscostreduce", initValue = 0, ablEffctId = 481, ablEffctName = "chaoscostreduce_value", ablLimit = 999999, pctEffctId = 482, pctEffctName = "chaoscostreduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[490] = {id = 490, classname = "BOSS连击点", classnameTextID = 501777, isDecimal = 0, classIcon = 0, attrname = "bosscombonum", initValue = 0, ablEffctId = 491, ablEffctName = "bosscombonum_value", ablLimit = 999999, pctEffctId = 492, pctEffctName = "bosscombonum_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[500] = {id = 500, classname = "暴击等级", classnameTextID = 501778, isDecimal = 0, classIcon = 0, attrname = "critratelev", initValue = 0, ablEffctId = 501, ablEffctName = "critratelev_value", ablLimit = 999999, pctEffctId = 502, pctEffctName = "critratelev_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[510] = {id = 510, classname = "暴击伤害等级", classnameTextID = 501779, isDecimal = 0, classIcon = 0, attrname = "critdegreelev", initValue = 0, ablEffctId = 511, ablEffctName = "critdegreelev_value", ablLimit = 999999, pctEffctId = 512, pctEffctName = "critdegreelev_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[520] = {id = 520, classname = "BUFF层数", classnameTextID = 501780, isDecimal = 0, classIcon = 0, attrname = "buff1num", initValue = 0, ablEffctId = 521, ablEffctName = "buff1num_value", ablLimit = 999999, pctEffctId = 522, pctEffctName = "buff1num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[530] = {id = 530, classname = "治疗量", classnameTextID = 501781, isDecimal = 0, classIcon = 0, attrname = "healingpower", initValue = 0, ablEffctId = 531, ablEffctName = "healingpower_value", ablLimit = 999999, pctEffctId = 532, pctEffctName = "healingpower_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[540] = {id = 540, classname = "秩序能量增长速度", classnameTextID = 501782, isDecimal = 0, classIcon = 0, attrname = "orderpwrgrow", initValue = 0, ablEffctId = 541, ablEffctName = "orderpwrgrow_value", ablLimit = 999999, pctEffctId = 542, pctEffctName = "orderpwrgrow_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[550] = {id = 550, classname = "攻击百分比", classnameTextID = 501783, isDecimal = 1, classIcon = 0, attrname = "basicattack", initValue = 0, ablEffctId = 551, ablEffctName = "basicattack_value", ablLimit = 999999, pctEffctId = 552, pctEffctName = "basicattack_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[560] = {id = 560, classname = "物防百分比", classnameTextID = 501784, isDecimal = 1, classIcon = 0, attrname = "basicdefend", initValue = 0, ablEffctId = 561, ablEffctName = "basicdefend_value", ablLimit = 999999, pctEffctId = 562, pctEffctName = "basicdefend_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[570] = {id = 570, classname = "魔防百分比", classnameTextID = 501785, isDecimal = 1, classIcon = 0, attrname = "basicmagicdef", initValue = 0, ablEffctId = 571, ablEffctName = "basicmagicdef_value", ablLimit = 999999, pctEffctId = 572, pctEffctName = "basicmagicdef_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[580] = {id = 580, classname = "生命百分比", classnameTextID = 501786, isDecimal = 1, classIcon = 0, attrname = "basicmaxhp", initValue = 0, ablEffctId = 581, ablEffctName = "basicmaxhp_value", ablLimit = 999999, pctEffctId = 582, pctEffctName = "basicmaxhp_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[590] = {id = 590, classname = "物理闪避率", classnameTextID = 501835, isDecimal = 1, classIcon = 0, attrname = "physicalevasion", initValue = 0, ablEffctId = 591, ablEffctName = "physicalevasion_value", ablLimit = 999999, pctEffctId = 592, pctEffctName = "physicalevasion_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[600] = {id = 600, classname = "BUFF层数", classnameTextID = 501780, isDecimal = 0, classIcon = 0, attrname = "buff2num", initValue = 0, ablEffctId = 601, ablEffctName = "buff2num_value", ablLimit = 999999, pctEffctId = 602, pctEffctName = "buff2num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[610] = {id = 610, classname = "受到物理伤害上限", classnameTextID = 501852, isDecimal = 0, classIcon = 0, attrname = "phydmglimit", initValue = 0, ablEffctId = 611, ablEffctName = "phydmglimit_value", ablLimit = 999999, pctEffctId = 612, pctEffctName = "phydmglimit_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[620] = {id = 620, classname = "受到魔法伤害上限", classnameTextID = 502378, isDecimal = 0, classIcon = 0, attrname = "magicdmglimit", initValue = 0, ablEffctId = 621, ablEffctName = "magicdmglimit_value", ablLimit = 999999, pctEffctId = 622, pctEffctName = "magicdmglimit_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[630] = {id = 630, classname = "受伤上限触发概率", classnameTextID = 502379, isDecimal = 0, classIcon = 0, attrname = "dmglimitrate", initValue = 0, ablEffctId = 631, ablEffctName = "dmglimitrate_value", ablLimit = 999999, pctEffctId = 632, pctEffctName = "dmglimitrate_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[640] = {id = 640, classname = "沉默标记", classnameTextID = 502634, isDecimal = 0, classIcon = 0, attrname = "silent", initValue = 0, ablEffctId = 641, ablEffctName = "silent_value", ablLimit = 999999, pctEffctId = 642, pctEffctName = "slient_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[650] = {id = 650, classname = "普通攻击计数", classnameTextID = 502635, isDecimal = 0, classIcon = 0, attrname = "attacktime", initValue = 0, ablEffctId = 651, ablEffctName = "attacktime_value", ablLimit = 999999, pctEffctId = 652, pctEffctName = "attacktime_value", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[660] = {id = 660, classname = "BUFF层数", classnameTextID = 501780, isDecimal = 0, classIcon = 0, attrname = "buff3num", initValue = 0, ablEffctId = 661, ablEffctName = "buff3num_value", ablLimit = 999999, pctEffctId = 662, pctEffctName = "buff3num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[670] = {id = 670, classname = "1技能协同概率", classnameTextID = 502699, isDecimal = 0, classIcon = 0, attrname = "comborate1", initValue = 0, ablEffctId = 671, ablEffctName = "comborate1_value", ablLimit = 999999, pctEffctId = 672, pctEffctName = "comborate1_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[680] = {id = 680, classname = "2技能协同概率", classnameTextID = 502700, isDecimal = 0, classIcon = 0, attrname = "comborate2", initValue = 0, ablEffctId = 681, ablEffctName = "comborate2_value", ablLimit = 999999, pctEffctId = 682, pctEffctName = "comborate2_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[690] = {id = 690, classname = "造成物理伤害上限", classnameTextID = 502703, isDecimal = 0, classIcon = 0, attrname = "phydmgmax", initValue = 0, ablEffctId = 691, ablEffctName = "phydmgmax_value", ablLimit = 999999, pctEffctId = 692, pctEffctName = "phydmgmax_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[700] = {id = 700, classname = "造成魔法伤害上限", classnameTextID = 502704, isDecimal = 0, classIcon = 0, attrname = "magicdmgmax", initValue = 0, ablEffctId = 701, ablEffctName = "magicdmgmax_value", ablLimit = 999999, pctEffctId = 702, pctEffctName = "magicdmgmax_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[710] = {id = 710, classname = "秩序能量对敌生效", classnameTextID = 501761, isDecimal = 0, classIcon = 0, attrname = "enemyorderpwr", initValue = 0, ablEffctId = 711, ablEffctName = "enemyorderpwr_value", ablLimit = 999999, pctEffctId = 712, pctEffctName = "enemyorderpwr_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[720] = {id = 720, classname = "混沌能量对敌生效", classnameTextID = 501762, isDecimal = 0, classIcon = 0, attrname = "enemychaospwr", initValue = 0, ablEffctId = 721, ablEffctName = "enemychaospwr_value", ablLimit = 999999, pctEffctId = 722, pctEffctName = "enemychaospwr_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[730] = {id = 730, classname = "秩序能量增长速度", classnameTextID = 501782, isDecimal = 0, classIcon = 0, attrname = "enemyorderpwrgrow", initValue = 0, ablEffctId = 731, ablEffctName = "enemyorderpwrgrow_value", ablLimit = 999999, pctEffctId = 732, pctEffctName = "enemyorderpwrgrow_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[740] = {id = 740, classname = "是否存在护盾buff", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "isshieldbuff", initValue = 0, ablEffctId = 741, ablEffctName = "isshieldbuff_value", ablLimit = 999999, pctEffctId = 742, pctEffctName = "isshieldbuff_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[750] = {id = 750, classname = "等级", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "level", initValue = 0, ablEffctId = 751, ablEffctName = "level_value", ablLimit = 999999, pctEffctId = 752, pctEffctName = "level_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[760] = {id = 760, classname = "减防层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff4num", initValue = 0, ablEffctId = 761, ablEffctName = "buff4num_value", ablLimit = 999999, pctEffctId = 762, pctEffctName = "buff4num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[770] = {id = 770, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff5num", initValue = 0, ablEffctId = 771, ablEffctName = "buff5num_value", ablLimit = 999999, pctEffctId = 772, pctEffctName = "buff5num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[780] = {id = 780, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff6num", initValue = 0, ablEffctId = 781, ablEffctName = "buff6num_value", ablLimit = 999999, pctEffctId = 782, pctEffctName = "buff6num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[790] = {id = 790, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff7num", initValue = 0, ablEffctId = 791, ablEffctName = "buff7num_value", ablLimit = 999999, pctEffctId = 792, pctEffctName = "buff7num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[800] = {id = 800, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff8num", initValue = 0, ablEffctId = 801, ablEffctName = "buff8num_value", ablLimit = 999999, pctEffctId = 802, pctEffctName = "buff8num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[810] = {id = 810, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff9num", initValue = 0, ablEffctId = 811, ablEffctName = "buff9num_value", ablLimit = 999999, pctEffctId = 812, pctEffctName = "buff9num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[820] = {id = 820, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff10num", initValue = 0, ablEffctId = 821, ablEffctName = "buff10num_value", ablLimit = 999999, pctEffctId = 822, pctEffctName = "buff10num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[830] = {id = 830, classname = "暴击程度抗性", classnameTextID = 502804, isDecimal = 1, classIcon = 13202, attrname = "critdegreeresistance", initValue = 0, ablEffctId = 831, ablEffctName = "critdegreeresistance_value", ablLimit = 999999, pctEffctId = 832, pctEffctName = "critdegreeresistance_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[840] = {id = 840, classname = "最大生命值比例", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "maxhpscale", initValue = 0, ablEffctId = 841, ablEffctName = "maxhpscale_value", ablLimit = 999999, pctEffctId = 842, pctEffctName = "maxhpscale_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[860] = {id = 860, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff11num", initValue = 0, ablEffctId = 861, ablEffctName = "buff11num_value", ablLimit = 999999, pctEffctId = 862, pctEffctName = "buff11num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[870] = {id = 870, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff12num", initValue = 0, ablEffctId = 871, ablEffctName = "buff12num_value", ablLimit = 999999, pctEffctId = 872, pctEffctName = "buff12num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[880] = {id = 880, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff13num", initValue = 0, ablEffctId = 881, ablEffctName = "buff13num_value", ablLimit = 999999, pctEffctId = 882, pctEffctName = "buff13num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[890] = {id = 890, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff14num", initValue = 0, ablEffctId = 891, ablEffctName = "buff14num_value", ablLimit = 999999, pctEffctId = 892, pctEffctName = "buff14num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[900] = {id = 900, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff15num", initValue = 0, ablEffctId = 901, ablEffctName = "buff15num_value", ablLimit = 999999, pctEffctId = 902, pctEffctName = "buff15num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[910] = {id = 910, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff16num", initValue = 0, ablEffctId = 911, ablEffctName = "buff16num_value", ablLimit = 999999, pctEffctId = 912, pctEffctName = "buff16num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[920] = {id = 920, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff17num", initValue = 0, ablEffctId = 921, ablEffctName = "buff17num_value", ablLimit = 999999, pctEffctId = 922, pctEffctName = "buff17num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[930] = {id = 930, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff18num", initValue = 0, ablEffctId = 931, ablEffctName = "buff18num_value", ablLimit = 999999, pctEffctId = 932, pctEffctName = "buff18num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[940] = {id = 940, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff19num", initValue = 0, ablEffctId = 941, ablEffctName = "buff19num_value", ablLimit = 999999, pctEffctId = 942, pctEffctName = "buff19num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[950] = {id = 950, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff20num", initValue = 0, ablEffctId = 951, ablEffctName = "buff20num_value", ablLimit = 999999, pctEffctId = 952, pctEffctName = "buff20num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[960] = {id = 960, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff21num", initValue = 0, ablEffctId = 961, ablEffctName = "buff21num_value", ablLimit = 999999, pctEffctId = 962, pctEffctName = "buff21num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[970] = {id = 970, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff22num", initValue = 0, ablEffctId = 971, ablEffctName = "buff22num_value", ablLimit = 999999, pctEffctId = 972, pctEffctName = "buff22num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[980] = {id = 980, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff23num", initValue = 0, ablEffctId = 981, ablEffctName = "buff23num_value", ablLimit = 999999, pctEffctId = 982, pctEffctName = "buff23num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[990] = {id = 990, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff24num", initValue = 0, ablEffctId = 991, ablEffctName = "buff24num_value", ablLimit = 999999, pctEffctId = 992, pctEffctName = "buff24num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1000] = {id = 1000, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff25num", initValue = 0, ablEffctId = 1001, ablEffctName = "buff25num_value", ablLimit = 999999, pctEffctId = 1002, pctEffctName = "buff25num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1010] = {id = 1010, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff26num", initValue = 0, ablEffctId = 1011, ablEffctName = "buff26num_value", ablLimit = 999999, pctEffctId = 1012, pctEffctName = "buff26num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1020] = {id = 1020, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff27num", initValue = 0, ablEffctId = 1021, ablEffctName = "buff27num_value", ablLimit = 999999, pctEffctId = 1022, pctEffctName = "buff27num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1030] = {id = 1030, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff28num", initValue = 0, ablEffctId = 1031, ablEffctName = "buff28num_value", ablLimit = 999999, pctEffctId = 1032, pctEffctName = "buff28num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1040] = {id = 1040, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff29num", initValue = 0, ablEffctId = 1041, ablEffctName = "buff29num_value", ablLimit = 999999, pctEffctId = 1042, pctEffctName = "buff29num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1050] = {id = 1050, classname = "BUFF层数", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "buff30num", initValue = 0, ablEffctId = 1051, ablEffctName = "buff30num_value", ablLimit = 999999, pctEffctId = 1052, pctEffctName = "buff30num_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1060] = {id = 1060, classname = "最终伤害减免减免", classnameTextID = 502935, isDecimal = 1, classIcon = 0, attrname = "damagereduce", initValue = 0, ablEffctId = 1061, ablEffctName = "damagereduce_value", ablLimit = 999999, pctEffctId = 1062, pctEffctName = "damagereduce_percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
, 
[1070] = {id = 1070, classname = "素体进阶符文等级", classnameTextID = -1, isDecimal = 0, classIcon = 0, attrname = "runelv", initValue = 0, ablEffctId = 1071, ablEffctName = "runelv_value", ablLimit = 999999, pctEffctId = 1072, pctEffctName = "runelv)percent", pctLimit = 10000, classgrowthname = "", classgrowthnameTextID = -1, basicattr = ""}
}
cattreffectidname.AllIds = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370, 380, 390, 400, 410, 420, 430, 440, 450, 460, 470, 480, 490, 500, 510, 520, 530, 540, 550, 560, 570, 580, 590, 600, 610, 620, 630, 640, 650, 660, 670, 680, 690, 700, 710, 720, 730, 740, 750, 760, 770, 780, 790, 800, 810, 820, 830, 840, 860, 870, 880, 890, 900, 910, 920, 930, 940, 950, 960, 970, 980, 990, 1000, 1010, 1020, 1030, 1040, 1050, 1060, 1070}
return cattreffectidname

