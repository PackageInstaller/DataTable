-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cstairblessingdeploy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstairblessingdeploy = {}
cstairblessingdeploy.Data = {
[1] = {id = 1, Blessingname = 1900686, QualityTyp = 1, BlessingTyp = 1, Qualityintensity = 1, Buffid = 21157, Qualityname = 302936, Qualitytextid = 1900717, Iconpath = 12824, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 3}
, 
[2] = {id = 2, Blessingname = 1900687, QualityTyp = 1, BlessingTyp = 1, Qualityintensity = 2, Buffid = 21158, Qualityname = 302936, Qualitytextid = 1900718, Iconpath = 12824, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 2}
, 
[3] = {id = 3, Blessingname = 1900688, QualityTyp = 1, BlessingTyp = 1, Qualityintensity = 1, Buffid = 21159, Qualityname = 302936, Qualitytextid = 1900719, Iconpath = 12818, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 2}
, 
[4] = {id = 4, Blessingname = 1900689, QualityTyp = 1, BlessingTyp = 1, Qualityintensity = 2, Buffid = 21160, Qualityname = 302936, Qualitytextid = 1900720, Iconpath = 12818, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[5] = {id = 5, Blessingname = 1900690, QualityTyp = 1, BlessingTyp = 1, Qualityintensity = 2, Buffid = 21161, Qualityname = 302936, Qualitytextid = 1900721, Iconpath = 12821, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 2}
, 
[6] = {id = 6, Blessingname = 1900691, QualityTyp = 2, BlessingTyp = 1, Qualityintensity = 3, Buffid = 21162, Qualityname = 302937, Qualitytextid = 1900722, Iconpath = 12820, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 2}
, 
[7] = {id = 7, Blessingname = 1900692, QualityTyp = 2, BlessingTyp = 2, Qualityintensity = 3, Buffid = 21163, Qualityname = 302937, Qualitytextid = 1900723, Iconpath = 12833, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[8] = {id = 8, Blessingname = 1900693, QualityTyp = 2, BlessingTyp = 2, Qualityintensity = 3, Buffid = 21164, Qualityname = 302937, Qualitytextid = 1900724, Iconpath = 12952, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[9] = {id = 9, Blessingname = 1900694, QualityTyp = 1, BlessingTyp = 2, Qualityintensity = 3, Buffid = 21165, Qualityname = 302936, Qualitytextid = 1900725, Iconpath = 12829, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[10] = {id = 10, Blessingname = 1900695, QualityTyp = 2, BlessingTyp = 1, Qualityintensity = 3, Buffid = 21166, Qualityname = 302937, Qualitytextid = 1900727, Iconpath = 13082, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[11] = {id = 11, Blessingname = 1900696, QualityTyp = 2, BlessingTyp = 1, Qualityintensity = 3, Buffid = 21167, Qualityname = 302937, Qualitytextid = 1900726, Iconpath = 13080, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[12] = {id = 12, Blessingname = 1900697, QualityTyp = 2, BlessingTyp = 2, Qualityintensity = 4, Buffid = 21168, Qualityname = 302937, Qualitytextid = 1900728, Iconpath = 12830, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[13] = {id = 13, Blessingname = 1900698, QualityTyp = 2, BlessingTyp = 2, Qualityintensity = 4, Buffid = 21169, Qualityname = 302937, Qualitytextid = 1900729, Iconpath = 12832, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[14] = {id = 14, Blessingname = 1900699, QualityTyp = 1, BlessingTyp = 3, Qualityintensity = 1, Buffid = 21170, Qualityname = 302936, Qualitytextid = 1900730, Iconpath = 12835, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 3}
, 
[15] = {id = 15, Blessingname = 1900700, QualityTyp = 2, BlessingTyp = 3, Qualityintensity = 2, Buffid = 21171, Qualityname = 302937, Qualitytextid = 1900731, Iconpath = 12836, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 2}
, 
[16] = {id = 16, Blessingname = 1900701, QualityTyp = 1, BlessingTyp = 3, Qualityintensity = 1, Buffid = 21172, Qualityname = 302936, Qualitytextid = 1900732, Iconpath = 12898, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 2}
, 
[17] = {id = 17, Blessingname = 1900702, QualityTyp = 2, BlessingTyp = 3, Qualityintensity = 2, Buffid = 21173, Qualityname = 302937, Qualitytextid = 1900733, Iconpath = 12840, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[18] = {id = 18, Blessingname = 1900703, QualityTyp = 1, BlessingTyp = 3, Qualityintensity = 1, Buffid = 21174, Qualityname = 302936, Qualitytextid = 1900734, Iconpath = 12950, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[19] = {id = 19, Blessingname = 1900704, QualityTyp = 2, BlessingTyp = 3, Qualityintensity = 2, Buffid = 21175, Qualityname = 302937, Qualitytextid = 1900735, Iconpath = 12953, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[20] = {id = 20, Blessingname = 1900705, QualityTyp = 2, BlessingTyp = 3, Qualityintensity = 3, Buffid = 21176, Qualityname = 302937, Qualitytextid = 1900736, Iconpath = 12826, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[21] = {id = 21, Blessingname = 1900706, QualityTyp = 2, BlessingTyp = 3, Qualityintensity = 4, Buffid = 21177, Qualityname = 302937, Qualitytextid = 1900737, Iconpath = 13079, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[22] = {id = 22, Blessingname = 1900707, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 1, Buffid = 21178, Qualityname = 302936, Qualitytextid = 1900738, Iconpath = 12838, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 3}
, 
[23] = {id = 23, Blessingname = 1900708, QualityTyp = 2, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21179, Qualityname = 302937, Qualitytextid = 1900739, Iconpath = 12839, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 2}
, 
[24] = {id = 24, Blessingname = 1900709, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 1, Buffid = 21180, Qualityname = 302936, Qualitytextid = 1900740, Iconpath = 12827, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 3}
, 
[25] = {id = 25, Blessingname = 1900710, QualityTyp = 2, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21181, Qualityname = 302937, Qualitytextid = 1900741, Iconpath = 12828, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 2}
, 
[26] = {id = 26, Blessingname = 1900711, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21182, Qualityname = 302936, Qualitytextid = 1900742, Iconpath = 12822, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[27] = {id = 27, Blessingname = 1900712, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21183, Qualityname = 302936, Qualitytextid = 1900743, Iconpath = 12837, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[28] = {id = 28, Blessingname = 1900713, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21184, Qualityname = 302936, Qualitytextid = 1900744, Iconpath = 12951, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[29] = {id = 29, Blessingname = 1900714, QualityTyp = 1, BlessingTyp = 4, Qualityintensity = 2, Buffid = 21185, Qualityname = 302936, Qualitytextid = 1900745, Iconpath = 12948, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 1}
, 
[30] = {id = 30, Blessingname = 1900715, QualityTyp = 2, BlessingTyp = 1, Qualityintensity = 3, Buffid = 21186, Qualityname = 302937, Qualitytextid = 1900746, Iconpath = 12841, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[31] = {id = 31, Blessingname = 1900716, QualityTyp = 2, BlessingTyp = 4, Qualityintensity = 4, Buffid = 21187, Qualityname = 302937, Qualitytextid = 1900747, Iconpath = 13081, Basepath = "", BuffDescribe = "紫", MaxBuffCard = 1}
, 
[32] = {id = 32, Blessingname = 1900883, QualityTyp = 1, BlessingTyp = 2, Qualityintensity = 2, Buffid = 21193, Qualityname = 302936, Qualitytextid = 1900748, Iconpath = 12831, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 3}
, 
[33] = {id = 33, Blessingname = 1901005, QualityTyp = 1, BlessingTyp = 2, Qualityintensity = 2, Buffid = 21194, Qualityname = 302936, Qualitytextid = 1900749, Iconpath = 12831, Basepath = "", BuffDescribe = "蓝", MaxBuffCard = 2}
}
cstairblessingdeploy.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33}
return cstairblessingdeploy

