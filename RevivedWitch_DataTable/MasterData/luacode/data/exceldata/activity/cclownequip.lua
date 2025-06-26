-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/activity/cclownequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cclownequip = {}
cclownequip.Data = {
[1] = {id = 1, equipid = 1, level = 1, equipimg = 10521, rank = 1, addHP = 15, addATK = 15, itemid = 35052, itemnum = 100}
, 
[2] = {id = 2, equipid = 1, level = 2, equipimg = 10521, rank = 1, addHP = 30, addATK = 30, itemid = 35052, itemnum = 100}
, 
[3] = {id = 3, equipid = 1, level = 3, equipimg = 10539, rank = 2, addHP = 45, addATK = 45, itemid = 35052, itemnum = 100}
, 
[4] = {id = 4, equipid = 1, level = 4, equipimg = 10539, rank = 2, addHP = 60, addATK = 60, itemid = 35052, itemnum = 100}
, 
[5] = {id = 5, equipid = 1, level = 5, equipimg = 10539, rank = 2, addHP = 75, addATK = 75, itemid = 35052, itemnum = 150}
, 
[6] = {id = 6, equipid = 1, level = 6, equipimg = 10672, rank = 3, addHP = 90, addATK = 90, itemid = 35052, itemnum = 150}
, 
[7] = {id = 7, equipid = 1, level = 7, equipimg = 10672, rank = 3, addHP = 105, addATK = 105, itemid = 35052, itemnum = 150}
, 
[8] = {id = 8, equipid = 1, level = 8, equipimg = 10672, rank = 3, addHP = 120, addATK = 120, itemid = 35052, itemnum = 250}
, 
[9] = {id = 9, equipid = 1, level = 9, equipimg = 11265, rank = 5, addHP = 135, addATK = 135, itemid = 35052, itemnum = 250}
, 
[10] = {id = 10, equipid = 1, level = 10, equipimg = 11265, rank = 5, addHP = 150, addATK = 150, itemid = 35052, itemnum = 0}
, 
[11] = {id = 11, equipid = 2, level = 1, equipimg = 10517, rank = 1, addHP = 20, addATK = 10, itemid = 35053, itemnum = 100}
, 
[12] = {id = 12, equipid = 2, level = 2, equipimg = 10517, rank = 1, addHP = 40, addATK = 20, itemid = 35053, itemnum = 100}
, 
[13] = {id = 13, equipid = 2, level = 3, equipimg = 10516, rank = 2, addHP = 60, addATK = 30, itemid = 35053, itemnum = 100}
, 
[14] = {id = 14, equipid = 2, level = 4, equipimg = 10516, rank = 2, addHP = 80, addATK = 40, itemid = 35053, itemnum = 100}
, 
[15] = {id = 15, equipid = 2, level = 5, equipimg = 10516, rank = 2, addHP = 100, addATK = 50, itemid = 35053, itemnum = 150}
, 
[16] = {id = 16, equipid = 2, level = 6, equipimg = 10668, rank = 3, addHP = 120, addATK = 60, itemid = 35053, itemnum = 150}
, 
[17] = {id = 17, equipid = 2, level = 7, equipimg = 10668, rank = 3, addHP = 140, addATK = 70, itemid = 35053, itemnum = 150}
, 
[18] = {id = 18, equipid = 2, level = 8, equipimg = 10668, rank = 3, addHP = 160, addATK = 80, itemid = 35053, itemnum = 250}
, 
[19] = {id = 19, equipid = 2, level = 9, equipimg = 11250, rank = 5, addHP = 180, addATK = 90, itemid = 35053, itemnum = 250}
, 
[20] = {id = 20, equipid = 2, level = 10, equipimg = 11250, rank = 5, addHP = 200, addATK = 100, itemid = 35053, itemnum = 0}
, 
[21] = {id = 21, equipid = 3, level = 1, equipimg = 10714, rank = 1, addHP = 10, addATK = 20, itemid = 35054, itemnum = 100}
, 
[22] = {id = 22, equipid = 3, level = 2, equipimg = 10714, rank = 1, addHP = 20, addATK = 40, itemid = 35054, itemnum = 100}
, 
[23] = {id = 23, equipid = 3, level = 3, equipimg = 10715, rank = 2, addHP = 30, addATK = 60, itemid = 35054, itemnum = 100}
, 
[24] = {id = 24, equipid = 3, level = 4, equipimg = 10715, rank = 2, addHP = 40, addATK = 80, itemid = 35054, itemnum = 100}
, 
[25] = {id = 25, equipid = 3, level = 5, equipimg = 10715, rank = 2, addHP = 50, addATK = 100, itemid = 35054, itemnum = 150}
, 
[26] = {id = 26, equipid = 3, level = 6, equipimg = 10728, rank = 3, addHP = 60, addATK = 120, itemid = 35054, itemnum = 150}
, 
[27] = {id = 27, equipid = 3, level = 7, equipimg = 10728, rank = 3, addHP = 70, addATK = 140, itemid = 35054, itemnum = 150}
, 
[28] = {id = 28, equipid = 3, level = 8, equipimg = 10728, rank = 3, addHP = 80, addATK = 160, itemid = 35054, itemnum = 250}
, 
[29] = {id = 29, equipid = 3, level = 9, equipimg = 11300, rank = 5, addHP = 90, addATK = 180, itemid = 35054, itemnum = 250}
, 
[30] = {id = 30, equipid = 3, level = 10, equipimg = 11300, rank = 5, addHP = 100, addATK = 200, itemid = 35054, itemnum = 0}
}
cclownequip.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}
return cclownequip

