-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/word/cwordbuff_en.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cwordbuff_en = {}
cwordbuff_en.Data = {
[2100001] = {id = 2100001, text = "Immune to all damage"}
, 
[2100002] = {id = 2100002, text = "Unable to take action"}
, 
[2100003] = {id = 2100003, text = "Restores Health over time"}
, 
[2100004] = {id = 2100004, text = "Increases DEF"}
, 
[2100005] = {id = 2100005, text = "Immune to all damage"}
, 
[2100006] = {id = 2100006, text = "Increases ATK"}
, 
[2100007] = {id = 2100007, text = "Reduces Physical DEF"}
, 
[2100008] = {id = 2100008, text = "Reduces damage taken"}
, 
[2100009] = {id = 2100009, text = "Reduces enemy\'s attack speed"}
, 
[2100010] = {id = 2100010, text = "Increases attack speed"}
, 
[2100011] = {id = 2100011, text = "Blocks damage for a specific number of times"}
, 
[2100012] = {id = 2100012, text = "Crit DMG ignores the target\'s DEF"}
, 
[2100013] = {id = 2100013, text = "Increases Magic DMG taken"}
, 
[2100014] = {id = 2100014, text = "Deals extra DMG"}
, 
[2100015] = {id = 2100015, text = "Loses Health continuously"}
, 
[2100016] = {id = 2100016, text = "Weakened"}
, 
[2100017] = {id = 2100017, text = "Increases Magic DEF"}
, 
[2100018] = {id = 2100018, text = "Increases armor penetration"}
, 
[2100019] = {id = 2100019, text = "Increases Crit Chance when attacking the marked target"}
, 
[2100020] = {id = 2100020, text = "Increases all attributes"}
, 
[2100021] = {id = 2100021, text = "Increases own Physical ATK"}
, 
[2100022] = {id = 2100022, text = "Reduces ATK"}
, 
[2100023] = {id = 2100023, text = "Increases Order Energy generation"}
, 
[2100024] = {id = 2100024, text = "Gains Life Steal. Physical ATK deals extra damage."}
, 
[2100025] = {id = 2100025, text = "Immune to control effects"}
, 
[2100026] = {id = 2100026, text = "Deals persistent Magic DMG"}
, 
[2100027] = {id = 2100027, text = "Reduces DEF"}
, 
[2100028] = {id = 2100028, text = "Increases DEF"}
, 
[2100029] = {id = 2100029, text = "Deals persistent DMG"}
, 
[2100030] = {id = 2100030, text = "Shield"}
, 
[2100031] = {id = 2100031, text = "Increases Crit Chance"}
, 
[2100032] = {id = 2100032, text = "Reduces damage dealt"}
, 
[2100033] = {id = 2100033, text = "Increases damage dealt"}
, 
[2100034] = {id = 2100034, text = "Restores Health over time"}
, 
[2100035] = {id = 2100035, text = "Increases attack speed"}
, 
[2100036] = {id = 2100036, text = "Reduces Magic DEF"}
, 
[2100037] = {id = 2100037, text = "Reduces attack speed"}
, 
[2100038] = {id = 2100038, text = "Increases ATK and DEF"}
, 
[2100039] = {id = 2100039, text = "Increases ATK significantly"}
, 
[2100040] = {id = 2100040, text = "Channeling heal"}
, 
[2100041] = {id = 2100041, text = "Increases damage taken by marked targets"}
, 
[2100042] = {id = 2100042, text = "Barrier duration"}
, 
[2100043] = {id = 2100043, text = "Skills deal additional damage"}
, 
[2100044] = {id = 2100044, text = "Increases damage taken"}
, 
[2100045] = {id = 2100045, text = "Poison stacks"}
, 
[2100046] = {id = 2100046, text = "Increases Order Energy over time"}
, 
[2100047] = {id = 2100047, text = "Increases Chaos Energy over time"}
, 
[2100048] = {id = 2100048, text = "Attacks deal extra damage"}
, 
[2100049] = {id = 2100049, text = "Reduces healing taken"}
, 
[2100050] = {id = 2100050, text = "Immune to debuffs"}
, 
[2100051] = {id = 2100051, text = "Increases max Health"}
, 
[2100052] = {id = 2100052, text = "Increases next skill damage"}
, 
[2100053] = {id = 2100053, text = "Reduces Physical and Magic DEF"}
, 
[2100054] = {id = 2100054, text = "Slightly increases DMG dealt"}
, 
[2100055] = {id = 2100055, text = "Greatly increases DMG dealt"}
, 
[2100056] = {id = 2100056, text = "Slightly increases energy regeneration"}
, 
[2100057] = {id = 2100057, text = "Greatly increases energy regeneration"}
, 
[2100058] = {id = 2100058, text = "Stops the enemy from regenerating Order Energy"}
, 
[2100059] = {id = 2100059, text = "Reduces Magic DEF"}
, 
[2100060] = {id = 2100060, text = "Increases Physical DEF"}
, 
[2100061] = {id = 2100061, text = "Unable to take action and takes additional damage"}
, 
[2100062] = {id = 2100062, text = "Attacks deal additional Magic DMG"}
, 
[2100063] = {id = 2100063, text = "Channeling Dark Magic"}
, 
[2100064] = {id = 2100064, text = "Increases damage dealt and healing given"}
, 
[2100065] = {id = 2100065, text = "Combos"}
, 
[2100066] = {id = 2100066, text = "Reduces damage taken and increases damage dealt"}
, 
[2100067] = {id = 2100067, text = "Unable to take action and increases damage taken"}
, 
[2100068] = {id = 2100068, text = "Invincible while channeling"}
, 
[2100069] = {id = 2100069, text = "Loses Health over time and unable to be healed"}
, 
[2100070] = {id = 2100070, text = "Increases ATK frequency"}
, 
[2100071] = {id = 2100071, text = "Channeling Devour"}
, 
[2100072] = {id = 2100072, text = "Increases both damage dealt and taken"}
, 
[2100073] = {id = 2100073, text = "Increases damage taken by the target"}
, 
[2100074] = {id = 2100074, text = "Increases energy regeneration"}
, 
[2100075] = {id = 2100075, text = "Immune to DMG when channeling is interrupted"}
, 
[2100076] = {id = 2100076, text = "Increases Magic DMG dealt"}
, 
[2100077] = {id = 2100077, text = "Reduces Crit Resistance"}
, 
[2100078] = {id = 2100078, text = "Deals extra Magic DMG to the marked target"}
, 
[2100079] = {id = 2100079, text = "Crit Chance increases with buff stacks"}
, 
[2100080] = {id = 2100080, text = "Increases first skill damage"}
, 
[2100081] = {id = 2100081, text = "Takes damage for all allies"}
, 
[2100082] = {id = 2100082, text = "Increases damage dealt and ignores Physical DEF"}
, 
[2100083] = {id = 2100083, text = "Increases ATK, Physical DEF and Magic DEF"}
, 
[2100084] = {id = 2100084, text = "Reduces damage taken. Physical ATK deals extra damage."}
, 
[2100085] = {id = 2100085, text = "Increases ATK to deal more damage."}
, 
[2100086] = {id = 2100086, text = "Increases Crit Chance and Crit DMG."}
, 
[2100087] = {id = 2100087, text = "Enters Stunned status after being attacked 20 times."}
, 
[2100088] = {id = 2100088, text = ""}
, 
[2100089] = {id = 2100089, text = ""}
, 
[2100090] = {id = 2100090, text = ""}
, 
[2100091] = {id = 2100091, text = ""}
, 
[2100092] = {id = 2100092, text = ""}
, 
[2100093] = {id = 2100093, text = ""}
, 
[2100094] = {id = 2100094, text = ""}
, 
[2100095] = {id = 2100095, text = ""}
, 
[2100096] = {id = 2100096, text = ""}
, 
[2100097] = {id = 2100097, text = ""}
, 
[2100098] = {id = 2100098, text = ""}
, 
[2100099] = {id = 2100099, text = ""}
, 
[2100100] = {id = 2100100, text = ""}
}
cwordbuff_en.AllIds = {2100001, 2100002, 2100003, 2100004, 2100005, 2100006, 2100007, 2100008, 2100009, 2100010, 2100011, 2100012, 2100013, 2100014, 2100015, 2100016, 2100017, 2100018, 2100019, 2100020, 2100021, 2100022, 2100023, 2100024, 2100025, 2100026, 2100027, 2100028, 2100029, 2100030, 2100031, 2100032, 2100033, 2100034, 2100035, 2100036, 2100037, 2100038, 2100039, 2100040, 2100041, 2100042, 2100043, 2100044, 2100045, 2100046, 2100047, 2100048, 2100049, 2100050, 2100051, 2100052, 2100053, 2100054, 2100055, 2100056, 2100057, 2100058, 2100059, 2100060, 2100061, 2100062, 2100063, 2100064, 2100065, 2100066, 2100067, 2100068, 2100069, 2100070, 2100071, 2100072, 2100073, 2100074, 2100075, 2100076, 2100077, 2100078, 2100079, 2100080, 2100081, 2100082, 2100083, 2100084, 2100085, 2100086, 2100087, 2100088, 2100089, 2100090, 2100091, 2100092, 2100093, 2100094, 2100095, 2100096, 2100097, 2100098, 2100099, 2100100}
return cwordbuff_en

