-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/equip/cword_equip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cword_equip = {}
cword_equip.Data = {
[1500001] = {id = 1500001, ch = "守护", en = "Guardian"}
, 
[1500002] = {id = 1500002, ch = "破坏", en = "Destroyer"}
, 
[1500003] = {id = 1500003, ch = "刺杀", en = "Assassin"}
, 
[1500004] = {id = 1500004, ch = "妨害", en = "Compeller"}
, 
[1500005] = {id = 1500005, ch = "恢复", en = "Healer"}
, 
[1500006] = {id = 1500006, ch = "魔导", en = "Mage"}
, 
[1500007] = {id = 1500007, ch = "魔女", en = "Witch"}
, 
[1500008] = {id = 1500008, ch = "全体", en = "All"}
, 
[1500009] = {id = 1500009, ch = "强化属性", en = "Enhancement Attribute"}
, 
[1500010] = {id = 1500010, ch = "附加属性", en = "Additional Attribute"}
, 
[1500011] = {id = 1500011, ch = "附加技能", en = "Additional Skill"}
, 
[1500012] = {id = 1500012, ch = "套装效果", en = "Set Bonus"}
, 
[1500013] = {id = 1500013, ch = "无", en = "Null"}
, 
[1500014] = {id = 1500014, ch = "生命上限提高$parameter1$点", en = "Increases Max. Health by $parameter1$"}
, 
[1500015] = {id = 1500015, ch = "物理攻击提高$parameter1$点", en = "Increases Physical ATK by $parameter1$"}
, 
[1500016] = {id = 1500016, ch = "魔法攻击提高$parameter1$点", en = "Increases Magic ATK by $parameter1$"}
, 
[1500017] = {id = 1500017, ch = "物理防御提高$parameter1$点", en = "Increases Physical DEF by $parameter1$"}
, 
[1500018] = {id = 1500018, ch = "魔法防御提高$parameter1$点", en = "Increases Magical DEF by $parameter1$"}
, 
[1500019] = {id = 1500019, ch = "金", en = "Gold"}
, 
[1500020] = {id = 1500020, ch = "银", en = "Silver"}
, 
[1500021] = {id = 1500021, ch = "铜", en = "Copper"}
, 
[1500022] = {id = 1500022, ch = "N", en = "N"}
, 
[1500023] = {id = 1500023, ch = "守护型", en = "Guardian"}
, 
[1500024] = {id = 1500024, ch = "破坏型", en = "Destroyer"}
, 
[1500025] = {id = 1500025, ch = "刺杀型", en = "Assassin"}
, 
[1500026] = {id = 1500026, ch = "妨害型", en = "Compeller"}
, 
[1500027] = {id = 1500027, ch = "恢复型", en = "Healer"}
, 
[1500028] = {id = 1500028, ch = "魔导型", en = "Mage"}
, 
[1500029] = {id = 1500029, ch = "魔女", en = "Witch"}
, 
[1500030] = {id = 1500030, ch = "全体", en = "All"}
, 
[1500031] = {id = 1500031, ch = "素材", en = "Materials"}
, 
[1500032] = {id = 1500032, ch = "稀有度", en = "Rarity"}
, 
[1500033] = {id = 1500033, ch = "强化等级", en = "Enhancement Level"}
, 
[1500034] = {id = 1500034, ch = "持有数", en = "Owned"}
, 
[1500035] = {id = 1500035, ch = "获得顺序", en = "Acquisition"}
, 
[1500036] = {id = 1500036, ch = "适用职业", en = "Class"}
, 
[1500037] = {id = 1500037, ch = "生命", en = "Health"}
, 
[1500038] = {id = 1500038, ch = "物理攻击", en = "Physical ATK"}
, 
[1500039] = {id = 1500039, ch = "魔法攻击", en = "Magic ATK"}
, 
[1500040] = {id = 1500040, ch = "物理防御", en = "Physical DEF"}
, 
[1500041] = {id = 1500041, ch = "魔法防御", en = "Magical DEF"}
, 
[1500042] = {id = 1500042, ch = "装备评分", en = "Equipment Rating"}
, 
[1500043] = {id = 1500043, ch = "武器", en = "Weapon"}
, 
[1500044] = {id = 1500044, ch = "防具", en = "Armor"}
, 
[1500045] = {id = 1500045, ch = "饰品", en = "Accessory"}
, 
[1500046] = {id = 1500046, ch = "获得经验", en = "Acquire EXP"}
, 
[1500047] = {id = 1500047, ch = "金", en = "Gold"}
, 
[1500048] = {id = 1500048, ch = "紫", en = "Purple"}
, 
[1500049] = {id = 1500049, ch = "蓝", en = "Blue"}
, 
[1500050] = {id = 1500050, ch = "攻击", en = "Attack"}
, 
[1500051] = {id = 1500051, ch = "暴击率", en = "Crit Chance"}
, 
[1500052] = {id = 1500052, ch = "暴击伤害", en = "Crit DMG"}
, 
[1500053] = {id = 1500053, ch = "物理闪避", en = "Physical Dodge"}
, 
[1500054] = {id = 1500054, ch = "魔法闪避", en = "Magic Dodge"}
, 
[1500055] = {id = 1500055, ch = "物理格挡", en = "Physical Block"}
, 
[1500056] = {id = 1500056, ch = "魔法格挡", en = "Magic Block"}
, 
[1500057] = {id = 1500057, ch = "物防穿透", en = "Physical Penetration"}
, 
[1500058] = {id = 1500058, ch = "魔防穿透", en = "Magic Penetration"}
, 
[1500059] = {id = 1500059, ch = "暴击抗性", en = "Crit Resistance"}
, 
[1500060] = {id = 1500060, ch = "品质：", en = "Quality:"}
, 
[1500061] = {id = 1500061, ch = "类型：", en = "Type:"}
, 
[1500062] = {id = 1500062, ch = "传奇", en = "Legendary"}
, 
[1500063] = {id = 1500063, ch = "重新生成<color=#82C65D>$parameter1$</color>个等级<color=#82C65D>C-A</color>的装备词缀。$B$<color=#FC3333>无法替换新解锁词缀</color>", en = "Regenerate <color=#82C65D>$parameter1$</color> <color=#82C65D>C-A</color> affix(es)."}
, 
[1500064] = {id = 1500064, ch = "重新生成<color=#82C65D>$parameter1$</color>个等级<color=#82C65D>B-S</color>的装备词缀。$B$<color=#FC3333>无法替换新解锁词缀</color>", en = "Regenerate <color=#82C65D>$parameter1$</color> <color=#82C65D>B-S</color> affix(es)."}
, 
[1500065] = {id = 1500065, ch = "重新生成<color=#82C65D>$parameter1$</color>个等级<color=#82C65D>S-SSS</color>的装备词缀。$B$附魔时有概率解锁新的词缀栏位。$B$<color=#FC3333>无法替换新解锁词缀</color>", en = "Regenerate <color=#82C65D>$parameter1$</color> <color=#82C65D>S-SSS</color> affix(es). $B$Has a chance to unlock new affix slot(s) when enchanted."}
, 
[1500066] = {id = 1500066, ch = "魔导师", en = ""}
, 
[1500067] = {id = 1500067, ch = "学士", en = ""}
, 
[1500068] = {id = 1500068, ch = "女神祝福", en = ""}
, 
[1500069] = {id = 1500069, ch = "套装", en = ""}
, 
[1500070] = {id = 1500070, ch = "非套装", en = ""}
, 
[1500071] = {id = 1500071, ch = "套装：", en = ""}
, 
[1500072] = {id = 1500072, ch = "噬魂荒骨", en = ""}
, 
[1500073] = {id = 1500073, ch = "远古之森", en = ""}
, 
[1500074] = {id = 1500074, ch = "不动如山", en = ""}
, 
[1500075] = {id = 1500075, ch = "明镜止水", en = ""}
, 
[1500076] = {id = 1500076, ch = "狂暴", en = ""}
, 
[1500077] = {id = 1500077, ch = "不屈意志", en = ""}
, 
[1500078] = {id = 1500078, ch = "生命传承", en = ""}
, 
[1500079] = {id = 1500079, ch = "井然有序", en = ""}
, 
[1500080] = {id = 1500080, ch = "错综复杂", en = ""}
, 
[1500081] = {id = 1500081, ch = "定时补给", en = ""}
, 
[1500082] = {id = 1500082, ch = "重新生成<color=#82C65D>$parameter1$</color>个等级<color=#82C65D>S-SSS</color>的装备词缀。", en = ""}
}
cword_equip.AllIds = {1500001, 1500002, 1500003, 1500004, 1500005, 1500006, 1500007, 1500008, 1500009, 1500010, 1500011, 1500012, 1500013, 1500014, 1500015, 1500016, 1500017, 1500018, 1500019, 1500020, 1500021, 1500022, 1500023, 1500024, 1500025, 1500026, 1500027, 1500028, 1500029, 1500030, 1500031, 1500032, 1500033, 1500034, 1500035, 1500036, 1500037, 1500038, 1500039, 1500040, 1500041, 1500042, 1500043, 1500044, 1500045, 1500046, 1500047, 1500048, 1500049, 1500050, 1500051, 1500052, 1500053, 1500054, 1500055, 1500056, 1500057, 1500058, 1500059, 1500060, 1500061, 1500062, 1500063, 1500064, 1500065, 1500066, 1500067, 1500068, 1500069, 1500070, 1500071, 1500072, 1500073, 1500074, 1500075, 1500076, 1500077, 1500078, 1500079, 1500080, 1500081, 1500082}
return cword_equip

