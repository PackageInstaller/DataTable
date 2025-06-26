-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/npc/cnpcshape.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cnpcshape = {}
cnpcshape.Data = {
[1] = {id = 1, type = 1, prefabName = "ActorBattle", prefabNameUI = "ActorBattleUI", mapPrefabName = "Actor", yardPrefabName = "ActorBattley", dormPrefabName = "ActorBattled", assetBundleName = "characters/char_player1.prefabs.assetbundle", lihuiID = 10017, headID = 10001, littleHeadID = 10001, DiamondHeadID = 10266, bustID = 10009, bigbustID = 10297, skillHeadID = 10351, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "role", live2DAssetBundleName = "live2d/player1.assetbundle", live2DScale = 3.4, photoScale = 3, 
photoLocation = {-15, -136}
, SteadyState = 1}
, 
[9] = {id = 9, type = 2, prefabName = "Char_Cat", prefabNameUI = "Char_CatUI", mapPrefabName = "0", yardPrefabName = "Char_Caty", dormPrefabName = "Char_Catd", assetBundleName = "characters/char_cat.prefabs.assetbundle", lihuiID = 10076, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char_cat", live2DAssetBundleName = "live2d/char_cat.assetbundle", live2DScale = 2, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10] = {id = 10, type = 1, prefabName = "char_001", prefabNameUI = "char_001UI", mapPrefabName = "0", yardPrefabName = "char_001y", dormPrefabName = "char_001d", assetBundleName = "characters/char_001.prefabs.assetbundle", lihuiID = 10018, headID = 12543, littleHeadID = 12543, DiamondHeadID = 0, bustID = 12544, bigbustID = 12545, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001", live2DAssetBundleName = "live2d/char001.assetbundle", live2DScale = 2.8, photoScale = 2.2, 
photoLocation = {0, -68}
, SteadyState = 1}
, 
[11] = {id = 11, type = 1, prefabName = "char_001", prefabNameUI = "char_001UI", mapPrefabName = "0", yardPrefabName = "char_001y", dormPrefabName = "char_001d", assetBundleName = "characters/char_001.prefabs.assetbundle", lihuiID = 10018, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "c002_touch", live2DAssetBundleName = "live2d/c002_touch.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1002] = {id = 1002, type = 1, prefabName = "char_001", prefabNameUI = "char_001UI", mapPrefabName = "0", yardPrefabName = "char_001y", dormPrefabName = "char_001d", assetBundleName = "characters/char_001.prefabs.assetbundle", lihuiID = 10018, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001", live2DAssetBundleName = "live2d/char001.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1003] = {id = 1003, type = 1, prefabName = "char_005", prefabNameUI = "char_005UI", mapPrefabName = "char_005m", yardPrefabName = "char_005y", dormPrefabName = "char_005d", assetBundleName = "characters/char_005.prefabs.assetbundle", lihuiID = 10020, headID = 10086, littleHeadID = 10086, DiamondHeadID = 12086, bustID = 12087, bigbustID = 12088, skillHeadID = 12085, drawShowID = 12483, battleEmotion = "1", live2DPrefabName = "char005", live2DAssetBundleName = "live2d/char005.assetbundle", live2DScale = 2.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1004] = {id = 1004, type = 1, prefabName = "char_004", prefabNameUI = "char_004UI", mapPrefabName = "char_004m", yardPrefabName = "char_004y", dormPrefabName = "char_004d", assetBundleName = "characters/char_004.prefabs.assetbundle", lihuiID = 10021, headID = 10003, littleHeadID = 10003, DiamondHeadID = 10268, bustID = 10011, bigbustID = 10290, skillHeadID = 10352, drawShowID = 12482, battleEmotion = "1", live2DPrefabName = "char004_hx", live2DAssetBundleName = "live2d/char004_hx.assetbundle", live2DScale = 3.1, photoScale = 3, 
photoLocation = {-78, -236}
, SteadyState = 1}
, 
[1005] = {id = 1005, type = 1, prefabName = "char_001", prefabNameUI = "char_001UI", mapPrefabName = "char_001m", yardPrefabName = "char_001y", dormPrefabName = "char_001d", assetBundleName = "characters/char_001.prefabs.assetbundle", lihuiID = 10018, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001", live2DAssetBundleName = "live2d/char001.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1006] = {id = 1006, type = 1, prefabName = "char_006", prefabNameUI = "char_006UI", mapPrefabName = "char_006m", yardPrefabName = "char_006y", dormPrefabName = "char_006d", assetBundleName = "characters/char_006.prefabs.assetbundle", lihuiID = 10023, headID = 10004, littleHeadID = 10004, DiamondHeadID = 10271, bustID = 10012, bigbustID = 10291, skillHeadID = 10591, drawShowID = 12484, battleEmotion = "1", live2DPrefabName = "char006_hx", live2DAssetBundleName = "live2d/char006_hx.assetbundle", live2DScale = 3, photoScale = 2.6, 
photoLocation = {0, -110}
, SteadyState = 1}
, 
[1007] = {id = 1007, type = 1, prefabName = "char_007", prefabNameUI = "char_007UI", mapPrefabName = "char_007m", yardPrefabName = "char_007y", dormPrefabName = "char_007d", assetBundleName = "characters/char_007.prefabs.assetbundle", lihuiID = 10114, headID = 10083, littleHeadID = 10083, DiamondHeadID = 10612, bustID = 10127, bigbustID = 10399, skillHeadID = 10603, drawShowID = 12535, battleEmotion = "1", live2DPrefabName = "n001", live2DAssetBundleName = "live2d/n001.assetbundle", live2DScale = 3, photoScale = 2.8, 
photoLocation = {0, -205}
, SteadyState = 1}
, 
[1008] = {id = 1008, type = 1, prefabName = "char_003_v1", prefabNameUI = "char_003_v1UI", mapPrefabName = "char_003_v1m", yardPrefabName = "char_003_v1y", dormPrefabName = "char_003_v1d", assetBundleName = "characters/char_003_v1.prefabs.assetbundle", lihuiID = 12083, headID = 10002, littleHeadID = 10002, DiamondHeadID = 10267, bustID = 10010, bigbustID = 10289, skillHeadID = 10590, drawShowID = 12481, battleEmotion = "1", live2DPrefabName = "char003", live2DAssetBundleName = "live2d/char003.assetbundle", live2DScale = 3.3, photoScale = 3, 
photoLocation = {-16, -33}
, SteadyState = 1}
, 
[1009] = {id = 1009, type = 1, prefabName = "char_009", prefabNameUI = "char_009UI", mapPrefabName = "char_009m", yardPrefabName = "char_009y", dormPrefabName = "char_009d", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 10103, headID = 10007, littleHeadID = 10007, DiamondHeadID = 10269, bustID = 10015, bigbustID = 10294, skillHeadID = 10594, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1010] = {id = 1010, type = 1, prefabName = "char_010", prefabNameUI = "char_010UI", mapPrefabName = "char_010m", yardPrefabName = "char_010y", dormPrefabName = "char_010d", assetBundleName = "characters/char_010.prefabs.assetbundle", lihuiID = 10104, headID = 12743, littleHeadID = 12743, DiamondHeadID = 12759, bustID = 12775, bigbustID = 12807, skillHeadID = 12791, drawShowID = 12808, battleEmotion = "1", live2DPrefabName = "char010", live2DAssetBundleName = "live2d/char010.assetbundle", live2DScale = 2.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1011] = {id = 1011, type = 1, prefabName = "char_011", prefabNameUI = "char_011UI", mapPrefabName = "char_011m", yardPrefabName = "char_011y", dormPrefabName = "char_011d", assetBundleName = "characters/char_011.prefabs.assetbundle", lihuiID = 14279, headID = 14239, littleHeadID = 14239, DiamondHeadID = 14238, bustID = 14240, bigbustID = 14242, skillHeadID = 14237, drawShowID = 14241, battleEmotion = "1", live2DPrefabName = "char011", live2DAssetBundleName = "live2d/char011.assetbundle", live2DScale = 2.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1012] = {id = 1012, type = 1, prefabName = "char_012", prefabNameUI = "char_012UI", mapPrefabName = "char_012m", yardPrefabName = "char_012y", dormPrefabName = "char_012d", assetBundleName = "characters/char_012.prefabs.assetbundle", lihuiID = 10106, headID = 10008, littleHeadID = 10008, DiamondHeadID = 10605, bustID = 10016, bigbustID = 10295, skillHeadID = 10596, drawShowID = 12485, battleEmotion = "1", live2DPrefabName = "char012", live2DAssetBundleName = "live2d/char012.assetbundle", live2DScale = 3.5, photoScale = 3.2, 
photoLocation = {-82, -161}
, SteadyState = 1}
, 
[1013] = {id = 1013, type = 1, prefabName = "char_013", prefabNameUI = "char_013UI", mapPrefabName = "char_013m", yardPrefabName = "char_013y", dormPrefabName = "char_013d", assetBundleName = "characters/char_013.prefabs.assetbundle", lihuiID = 10108, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char013", live2DAssetBundleName = "live2d/char013.assetbundle", live2DScale = 2.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1014] = {id = 1014, type = 1, prefabName = "char_014", prefabNameUI = "char_014UI", mapPrefabName = "char_014m", yardPrefabName = "char_014y", dormPrefabName = "char_014d", assetBundleName = "characters/char_014.prefabs.assetbundle", lihuiID = 10443, headID = 10440, littleHeadID = 10440, DiamondHeadID = 10606, bustID = 10441, bigbustID = 10442, skillHeadID = 10597, drawShowID = 12486, battleEmotion = "1", live2DPrefabName = "char014_hx", live2DAssetBundleName = "live2d/char014_hx.assetbundle", live2DScale = 2.9, photoScale = 2.8, 
photoLocation = {-27, -133}
, SteadyState = 1}
, 
[1015] = {id = 1015, type = 1, prefabName = "char_015", prefabNameUI = "char_015UI", mapPrefabName = "char_015m", yardPrefabName = "char_015y", dormPrefabName = "char_015d", assetBundleName = "characters/char_015.prefabs.assetbundle", lihuiID = 10109, headID = 10029, littleHeadID = 10029, DiamondHeadID = 10607, bustID = 10030, bigbustID = 10296, skillHeadID = 10598, drawShowID = 12487, battleEmotion = "1", live2DPrefabName = "char015_hx", live2DAssetBundleName = "live2d/char015_hx.assetbundle", live2DScale = 4.3, photoScale = 3.5, 
photoLocation = {88, -13}
, SteadyState = 1}
, 
[1016] = {id = 1016, type = 1, prefabName = "char_016", prefabNameUI = "char_016UI", mapPrefabName = "char_016m", yardPrefabName = "char_016y", dormPrefabName = "char_016d", assetBundleName = "characters/char_016.prefabs.assetbundle", lihuiID = 10110, headID = 10080, littleHeadID = 10080, DiamondHeadID = 10608, bustID = 10124, bigbustID = 10396, skillHeadID = 10599, drawShowID = 12488, battleEmotion = "1", live2DPrefabName = "char016_hx", live2DAssetBundleName = "live2d/char016_hx.assetbundle", live2DScale = 3.3, photoScale = 3.2, 
photoLocation = {-56, 37}
, SteadyState = 1}
, 
[1017] = {id = 1017, type = 1, prefabName = "char_017", prefabNameUI = "char_017UI", mapPrefabName = "char_017m", yardPrefabName = "char_017y", dormPrefabName = "char_017d", assetBundleName = "characters/char_017.prefabs.assetbundle", lihuiID = 10111, headID = 0, littleHeadID = 0, DiamondHeadID = 12346, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char017", live2DAssetBundleName = "live2d/char017.assetbundle", live2DScale = 2.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1018] = {id = 1018, type = 1, prefabName = "char_018", prefabNameUI = "char_018UI", mapPrefabName = "char_018m", yardPrefabName = "char_018y", dormPrefabName = "char_018d", assetBundleName = "characters/char_018.prefabs.assetbundle", lihuiID = 10112, headID = 10081, littleHeadID = 10081, DiamondHeadID = 10270, bustID = 10125, bigbustID = 10397, skillHeadID = 10600, drawShowID = 12489, battleEmotion = "1", live2DPrefabName = "char018_hx", live2DAssetBundleName = "live2d/char018_hx.assetbundle", live2DScale = 2.3, photoScale = 2, 
photoLocation = {-24, 18}
, SteadyState = 1}
, 
[1019] = {id = 1019, type = 1, prefabName = "char_020", prefabNameUI = "char_020UI", mapPrefabName = "char_020m", yardPrefabName = "char_020y", dormPrefabName = "char_020d", assetBundleName = "characters/char_020.prefabs.assetbundle", lihuiID = 10113, headID = 10082, littleHeadID = 10082, DiamondHeadID = 10610, bustID = 10126, bigbustID = 10398, skillHeadID = 10602, drawShowID = 12491, battleEmotion = "1", live2DPrefabName = "char020", live2DAssetBundleName = "live2d/char020.assetbundle", live2DScale = 3, photoScale = 2.6, 
photoLocation = {-21, -86}
, SteadyState = 1}
, 
[1020] = {id = 1020, type = 1, prefabName = "ActorBattle", prefabNameUI = "ActorBattleUI", mapPrefabName = "ActorBattlem", yardPrefabName = "ActorBattley", dormPrefabName = "ActorBattled", assetBundleName = "characters/char_player1.prefabs.assetbundle", lihuiID = 10114, headID = 10083, littleHeadID = 10083, DiamondHeadID = 12345, bustID = 10127, bigbustID = 10399, skillHeadID = 10603, drawShowID = 12535, battleEmotion = "1", live2DPrefabName = "n001", live2DAssetBundleName = "live2d/n001.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1021] = {id = 1021, type = 1, prefabName = "char_002", prefabNameUI = "char_002UI", mapPrefabName = "char_002m", yardPrefabName = "char_002y", dormPrefabName = "char_002d", assetBundleName = "characters/char_002.prefabs.assetbundle", lihuiID = 10690, headID = 10687, littleHeadID = 10687, DiamondHeadID = 10686, bustID = 10688, bigbustID = 10689, skillHeadID = 10589, drawShowID = 12480, battleEmotion = "1", live2DPrefabName = "char002", live2DAssetBundleName = "live2d/char002.assetbundle", live2DScale = 3.1, photoScale = 2.9, 
photoLocation = {-16, -163}
, SteadyState = 1}
, 
[1022] = {id = 1022, type = 1, prefabName = "char_019", prefabNameUI = "char_019UI", mapPrefabName = "char_019m", yardPrefabName = "char_019y", dormPrefabName = "char_019d", assetBundleName = "characters/char_019.prefabs.assetbundle", lihuiID = 10115, headID = 10084, littleHeadID = 10084, DiamondHeadID = 10609, bustID = 10128, bigbustID = 10487, skillHeadID = 10601, drawShowID = 12490, battleEmotion = "1", live2DPrefabName = "char019_hx", live2DAssetBundleName = "live2d/char019_hx.assetbundle", live2DScale = 3.4, photoScale = 3, 
photoLocation = {-102, -25}
, SteadyState = 1}
, 
[1023] = {id = 1023, type = 1, prefabName = "char_027", prefabNameUI = "char_027UI", mapPrefabName = "char_027m", yardPrefabName = "char_027y", dormPrefabName = "char_027d", assetBundleName = "characters/char_027.prefabs.assetbundle", lihuiID = 10739, headID = 10841, littleHeadID = 10841, DiamondHeadID = 10807, bustID = 10875, bigbustID = 10909, skillHeadID = 10773, drawShowID = 12498, battleEmotion = "1", live2DPrefabName = "char027", live2DAssetBundleName = "live2d/char027.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-56, -197}
, SteadyState = 1}
, 
[1024] = {id = 1024, type = 1, prefabName = "char_029", prefabNameUI = "char_029UI", mapPrefabName = "char_029m", yardPrefabName = "char_029y", dormPrefabName = "char_029d", assetBundleName = "characters/char_029.prefabs.assetbundle", lihuiID = 10740, headID = 10842, littleHeadID = 10842, DiamondHeadID = 10808, bustID = 10876, bigbustID = 10910, skillHeadID = 10774, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1025] = {id = 1025, type = 1, prefabName = "char_024", prefabNameUI = "char_024UI", mapPrefabName = "char_024m", yardPrefabName = "char_024y", dormPrefabName = "char_024d", assetBundleName = "characters/char_024.prefabs.assetbundle", lihuiID = 10741, headID = 10843, littleHeadID = 10843, DiamondHeadID = 10809, bustID = 10877, bigbustID = 10911, skillHeadID = 10775, drawShowID = 12495, battleEmotion = "1", live2DPrefabName = "char024", live2DAssetBundleName = "live2d/char024.assetbundle", live2DScale = 3.1, photoScale = 2.8, 
photoLocation = {-19, -167}
, SteadyState = 1}
, 
[1026] = {id = 1026, type = 1, prefabName = "char_025", prefabNameUI = "char_025UI", mapPrefabName = "char_025m", yardPrefabName = "char_025y", dormPrefabName = "char_025d", assetBundleName = "characters/char_025.prefabs.assetbundle", lihuiID = 10742, headID = 10844, littleHeadID = 10844, DiamondHeadID = 10810, bustID = 10878, bigbustID = 10912, skillHeadID = 10776, drawShowID = 12496, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1027] = {id = 1027, type = 1, prefabName = "char_028", prefabNameUI = "char_028UI", mapPrefabName = "char_028m", yardPrefabName = "char_028y", dormPrefabName = "char_028d", assetBundleName = "characters/char_028.prefabs.assetbundle", lihuiID = 10743, headID = 10845, littleHeadID = 10845, DiamondHeadID = 10811, bustID = 10879, bigbustID = 10913, skillHeadID = 10777, drawShowID = 12499, battleEmotion = "1", live2DPrefabName = "char028_hx", live2DAssetBundleName = "live2d/char028_hx.assetbundle", live2DScale = 2.9, photoScale = 3, 
photoLocation = {-32, 70}
, SteadyState = 1}
, 
[1028] = {id = 1028, type = 1, prefabName = "char_032", prefabNameUI = "char_032UI", mapPrefabName = "char_032m", yardPrefabName = "char_032y", dormPrefabName = "char_032d", assetBundleName = "characters/char_032.prefabs.assetbundle", lihuiID = 10744, headID = 10846, littleHeadID = 10846, DiamondHeadID = 10812, bustID = 10880, bigbustID = 10914, skillHeadID = 10778, drawShowID = 12502, battleEmotion = "1", live2DPrefabName = "char032_hx", live2DAssetBundleName = "live2d/char032_hx.assetbundle", live2DScale = 2.7, photoScale = 3.3, 
photoLocation = {-70, 60}
, SteadyState = 1}
, 
[1029] = {id = 1029, type = 1, prefabName = "char_022", prefabNameUI = "char_022UI", mapPrefabName = "char_022m", yardPrefabName = "char_022y", dormPrefabName = "char_022d", assetBundleName = "characters/char_022.prefabs.assetbundle", lihuiID = 10745, headID = 10847, littleHeadID = 10847, DiamondHeadID = 10813, bustID = 10881, bigbustID = 10915, skillHeadID = 10779, drawShowID = 12493, battleEmotion = "1", live2DPrefabName = "char022", live2DAssetBundleName = "live2d/char022.assetbundle", live2DScale = 3.3, photoScale = 3, 
photoLocation = {0, -156}
, SteadyState = 1}
, 
[1030] = {id = 1030, type = 1, prefabName = "char_023", prefabNameUI = "char_023UI", mapPrefabName = "char_023m", yardPrefabName = "char_023y", dormPrefabName = "char_023d", assetBundleName = "characters/char_023.prefabs.assetbundle", lihuiID = 10746, headID = 10848, littleHeadID = 10848, DiamondHeadID = 10814, bustID = 10882, bigbustID = 10916, skillHeadID = 10780, drawShowID = 12494, battleEmotion = "1", live2DPrefabName = "char023", live2DAssetBundleName = "live2d/char023.assetbundle", live2DScale = 3, photoScale = 2.9, 
photoLocation = {90, 0}
, SteadyState = 1}
, 
[1031] = {id = 1031, type = 1, prefabName = "char_026", prefabNameUI = "char_026UI", mapPrefabName = "char_026m", yardPrefabName = "char_026y", dormPrefabName = "char_026d", assetBundleName = "characters/char_026.prefabs.assetbundle", lihuiID = 10747, headID = 10849, littleHeadID = 10849, DiamondHeadID = 10815, bustID = 10883, bigbustID = 10917, skillHeadID = 10781, drawShowID = 12497, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1032] = {id = 1032, type = 1, prefabName = "char_030", prefabNameUI = "char_030UI", mapPrefabName = "char_030m", yardPrefabName = "char_030y", dormPrefabName = "char_030d", assetBundleName = "characters/char_030.prefabs.assetbundle", lihuiID = 10748, headID = 10850, littleHeadID = 10850, DiamondHeadID = 10816, bustID = 10884, bigbustID = 10918, skillHeadID = 10782, drawShowID = 12500, battleEmotion = "1", live2DPrefabName = "char030", live2DAssetBundleName = "live2d/char030.assetbundle", live2DScale = 4.2, photoScale = 3.8, 
photoLocation = {-166, 34}
, SteadyState = 1}
, 
[1033] = {id = 1033, type = 1, prefabName = "char_036", prefabNameUI = "char_036UI", mapPrefabName = "char_036m", yardPrefabName = "char_036y", dormPrefabName = "char_036d", assetBundleName = "characters/char_036.prefabs.assetbundle", lihuiID = 10749, headID = 10851, littleHeadID = 10851, DiamondHeadID = 10817, bustID = 10885, bigbustID = 10919, skillHeadID = 10783, drawShowID = 12506, battleEmotion = "1", live2DPrefabName = "char036", live2DAssetBundleName = "live2d/char036.assetbundle", live2DScale = 1.9, photoScale = 2.5, 
photoLocation = {0, -82}
, SteadyState = 1}
, 
[1034] = {id = 1034, type = 1, prefabName = "char_031", prefabNameUI = "char_031UI", mapPrefabName = "char_031m", yardPrefabName = "char_031y", dormPrefabName = "char_031d", assetBundleName = "characters/char_031.prefabs.assetbundle", lihuiID = 10750, headID = 10852, littleHeadID = 10852, DiamondHeadID = 10818, bustID = 10886, bigbustID = 10920, skillHeadID = 10784, drawShowID = 12501, battleEmotion = "1", live2DPrefabName = "char031", live2DAssetBundleName = "live2d/char031.assetbundle", live2DScale = 3.7, photoScale = 3.2, 
photoLocation = {0, 51}
, SteadyState = 1}
, 
[1035] = {id = 1035, type = 1, prefabName = "char_035", prefabNameUI = "char_035UI", mapPrefabName = "char_035m", yardPrefabName = "char_035y", dormPrefabName = "char_035d", assetBundleName = "characters/char_035.prefabs.assetbundle", lihuiID = 10751, headID = 10853, littleHeadID = 10853, DiamondHeadID = 10819, bustID = 10887, bigbustID = 10921, skillHeadID = 10785, drawShowID = 12505, battleEmotion = "1", live2DPrefabName = "char035", live2DAssetBundleName = "live2d/char035.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {0, -106}
, SteadyState = 1}
, 
[1036] = {id = 1036, type = 1, prefabName = "char_037", prefabNameUI = "char_037UI", mapPrefabName = "char_037m", yardPrefabName = "char_037y", dormPrefabName = "char_037d", assetBundleName = "characters/char_037.prefabs.assetbundle", lihuiID = 10752, headID = 10854, littleHeadID = 10854, DiamondHeadID = 10820, bustID = 10888, bigbustID = 10922, skillHeadID = 10786, drawShowID = 12507, battleEmotion = "1", live2DPrefabName = "char037_hx", live2DAssetBundleName = "live2d/char037_hx.assetbundle", live2DScale = 3.7, photoScale = 3.2, 
photoLocation = {-11, -130}
, SteadyState = 1}
, 
[1037] = {id = 1037, type = 1, prefabName = "char_067", prefabNameUI = "char_067UI", mapPrefabName = "char_067m", yardPrefabName = "char_067y", dormPrefabName = "char_067d", assetBundleName = "characters/char_067.prefabs.assetbundle", lihuiID = 14188, headID = 14191, littleHeadID = 14191, DiamondHeadID = 14190, bustID = 14192, bigbustID = 14194, skillHeadID = 14189, drawShowID = 14193, battleEmotion = "1", live2DPrefabName = "char067", live2DAssetBundleName = "live2d/char067.assetbundle", live2DScale = 2.3, photoScale = 2.5, 
photoLocation = {-31, -2}
, SteadyState = 1}
, 
[1038] = {id = 1038, type = 1, prefabName = "char_039", prefabNameUI = "char_039UI", mapPrefabName = "char_039m", yardPrefabName = "char_039y", dormPrefabName = "char_039d", assetBundleName = "characters/char_039.prefabs.assetbundle", lihuiID = 10754, headID = 10856, littleHeadID = 10856, DiamondHeadID = 10822, bustID = 10890, bigbustID = 10924, skillHeadID = 10788, drawShowID = 12508, battleEmotion = "1", live2DPrefabName = "char039_hx", live2DAssetBundleName = "live2d/char039_hx.assetbundle", live2DScale = 3.6, photoScale = 3, 
photoLocation = {0, -6}
, SteadyState = 1}
, 
[1039] = {id = 1039, type = 1, prefabName = "char_049", prefabNameUI = "char_049UI", mapPrefabName = "char_049m", yardPrefabName = "char_049y", dormPrefabName = "char_049d", assetBundleName = "characters/char_049.prefabs.assetbundle", lihuiID = 10755, headID = 10857, littleHeadID = 10857, DiamondHeadID = 10823, bustID = 10891, bigbustID = 10925, skillHeadID = 10789, drawShowID = 12515, battleEmotion = "1", live2DPrefabName = "char049", live2DAssetBundleName = "live2d/char049.assetbundle", live2DScale = 2.4, photoScale = 3.2, 
photoLocation = {-53, -38}
, SteadyState = 1}
, 
[1040] = {id = 1040, type = 1, prefabName = "char_050", prefabNameUI = "char_050UI", mapPrefabName = "char_050m", yardPrefabName = "char_050y", dormPrefabName = "char_050d", assetBundleName = "characters/char_050.prefabs.assetbundle", lihuiID = 10756, headID = 10858, littleHeadID = 10858, DiamondHeadID = 10824, bustID = 10892, bigbustID = 10926, skillHeadID = 10790, drawShowID = 12516, battleEmotion = "4", live2DPrefabName = "char050", live2DAssetBundleName = "live2d/char050.assetbundle", live2DScale = 3.1, photoScale = 2.8, 
photoLocation = {0, -135}
, SteadyState = 1}
, 
[1041] = {id = 1041, type = 1, prefabName = "char_040", prefabNameUI = "char_040UI", mapPrefabName = "char_040m", yardPrefabName = "char_040y", dormPrefabName = "char_040d", assetBundleName = "characters/char_040.prefabs.assetbundle", lihuiID = 10757, headID = 11651, littleHeadID = 11651, DiamondHeadID = 11642, bustID = 11660, bigbustID = 11669, skillHeadID = 11633, drawShowID = 12509, battleEmotion = "1", live2DPrefabName = "char040_hx", live2DAssetBundleName = "live2d/char040_hx.assetbundle", live2DScale = 4.2, photoScale = 2.8, 
photoLocation = {-43, -133}
, SteadyState = 1}
, 
[1042] = {id = 1042, type = 1, prefabName = "char_051", prefabNameUI = "char_051UI", mapPrefabName = "char_051m", yardPrefabName = "char_051y", dormPrefabName = "char_051d", assetBundleName = "characters/char_051.prefabs.assetbundle", lihuiID = 10758, headID = 10860, littleHeadID = 10860, DiamondHeadID = 10826, bustID = 10894, bigbustID = 10928, skillHeadID = 10792, drawShowID = 12517, battleEmotion = "1", live2DPrefabName = "char051", live2DAssetBundleName = "live2d/char051.assetbundle", live2DScale = 3.3, photoScale = 3, 
photoLocation = {-40, -70}
, SteadyState = 1}
, 
[1043] = {id = 1043, type = 1, prefabName = "char_046", prefabNameUI = "char_046UI", mapPrefabName = "char_046m", yardPrefabName = "char_046y", dormPrefabName = "char_046d", assetBundleName = "characters/char_046.prefabs.assetbundle", lihuiID = 10759, headID = 11652, littleHeadID = 11652, DiamondHeadID = 11643, bustID = 11661, bigbustID = 11670, skillHeadID = 11634, drawShowID = 12513, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1044] = {id = 1044, type = 1, prefabName = "char_048", prefabNameUI = "char_048UI", mapPrefabName = "char_048m", yardPrefabName = "char_048y", dormPrefabName = "char_048d", assetBundleName = "characters/char_048.prefabs.assetbundle", lihuiID = 10760, headID = 10862, littleHeadID = 10862, DiamondHeadID = 10828, bustID = 10896, bigbustID = 10930, skillHeadID = 10794, drawShowID = 12514, battleEmotion = "1", live2DPrefabName = "char048", live2DAssetBundleName = "live2d/char048.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1045] = {id = 1045, type = 1, prefabName = "char_046", prefabNameUI = "char_046UI", mapPrefabName = "char_046m", yardPrefabName = "char_046y", dormPrefabName = "char_046d", assetBundleName = "characters/char_046.prefabs.assetbundle", lihuiID = 14319, headID = 14322, littleHeadID = 14322, DiamondHeadID = 14321, bustID = 14323, bigbustID = 14325, skillHeadID = 14320, drawShowID = 14324, battleEmotion = "1", live2DPrefabName = "char047", live2DAssetBundleName = "live2d/char047.assetbundle", live2DScale = 2.1, photoScale = 2.6, 
photoLocation = {-9, -26}
, SteadyState = 1}
, 
[1046] = {id = 1046, type = 1, prefabName = "char_059", prefabNameUI = "char_059UI", mapPrefabName = "char_059m", yardPrefabName = "char_059y", dormPrefabName = "char_059d", assetBundleName = "characters/char_059.prefabs.assetbundle", lihuiID = 12727, headID = 12742, littleHeadID = 12742, DiamondHeadID = 12758, bustID = 12774, bigbustID = 12806, skillHeadID = 12790, drawShowID = 12810, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1047] = {id = 1047, type = 1, prefabName = "char_043", prefabNameUI = "char_043UI", mapPrefabName = "char_043m", yardPrefabName = "char_043y", dormPrefabName = "char_043d", assetBundleName = "characters/char_043.prefabs.assetbundle", lihuiID = 10763, headID = 10865, littleHeadID = 10865, DiamondHeadID = 10831, bustID = 10899, bigbustID = 10933, skillHeadID = 10797, drawShowID = 12511, battleEmotion = "1", live2DPrefabName = "char043", live2DAssetBundleName = "live2d/char043.assetbundle", live2DScale = 3.4, photoScale = 3, 
photoLocation = {30, -200}
, SteadyState = 1}
, 
[1048] = {id = 1048, type = 1, prefabName = "char_041", prefabNameUI = "char_041UI", mapPrefabName = "char_041m", yardPrefabName = "char_041y", dormPrefabName = "char_041d", assetBundleName = "characters/char_041.prefabs.assetbundle", lihuiID = 10764, headID = 10866, littleHeadID = 10866, DiamondHeadID = 10832, bustID = 10900, bigbustID = 10934, skillHeadID = 10798, drawShowID = 12510, battleEmotion = "1", live2DPrefabName = "char041_hx", live2DAssetBundleName = "live2d/char041_hx.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {28, 72}
, SteadyState = 1}
, 
[1049] = {id = 1049, type = 1, prefabName = "char_055", prefabNameUI = "char_055UI", mapPrefabName = "char_055m", yardPrefabName = "char_055y", dormPrefabName = "char_055d", assetBundleName = "characters/char_055.prefabs.assetbundle", lihuiID = 10765, headID = 11531, littleHeadID = 11531, DiamondHeadID = 11523, bustID = 11539, bigbustID = 11547, skillHeadID = 11515, drawShowID = 12521, battleEmotion = "1", live2DPrefabName = "char055", live2DAssetBundleName = "live2d/char055.assetbundle", live2DScale = 4.2, photoScale = 3, 
photoLocation = {9, -165}
, SteadyState = 1}
, 
[1050] = {id = 1050, type = 1, prefabName = "char_044", prefabNameUI = "char_044UI", mapPrefabName = "char_044m", yardPrefabName = "char_044y", dormPrefabName = "char_044d", assetBundleName = "characters/char_044.prefabs.assetbundle", lihuiID = 10766, headID = 10868, littleHeadID = 10868, DiamondHeadID = 10834, bustID = 10902, bigbustID = 10936, skillHeadID = 10800, drawShowID = 12512, battleEmotion = "1", live2DPrefabName = "char044", live2DAssetBundleName = "live2d/char044.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1051] = {id = 1051, type = 1, prefabName = "char_042", prefabNameUI = "char_042UI", mapPrefabName = "char_042m", yardPrefabName = "char_042y", dormPrefabName = "char_042d", assetBundleName = "characters/char_042.prefabs.assetbundle", lihuiID = 10767, headID = 10869, littleHeadID = 10869, DiamondHeadID = 10835, bustID = 10903, bigbustID = 10937, skillHeadID = 10801, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1052] = {id = 1052, type = 1, prefabName = "char_045", prefabNameUI = "char_045UI", mapPrefabName = "char_045m", yardPrefabName = "char_045y", dormPrefabName = "char_045d", assetBundleName = "characters/char_045.prefabs.assetbundle", lihuiID = 12716, headID = 12731, littleHeadID = 12731, DiamondHeadID = 12747, bustID = 12763, bigbustID = 12795, skillHeadID = 12779, drawShowID = 12809, battleEmotion = "1", live2DPrefabName = "char045", live2DAssetBundleName = "live2d/char045.assetbundle", live2DScale = 3, photoScale = 3.5, 
photoLocation = {-120, -60}
, SteadyState = 1}
, 
[1053] = {id = 1053, type = 1, prefabName = "char_021", prefabNameUI = "char_021UI", mapPrefabName = "char_021m", yardPrefabName = "char_021y", dormPrefabName = "char_021d", assetBundleName = "characters/char_021.prefabs.assetbundle", lihuiID = 10116, headID = 10871, littleHeadID = 10871, DiamondHeadID = 10837, bustID = 10905, bigbustID = 10939, skillHeadID = 10803, drawShowID = 12492, battleEmotion = "1", live2DPrefabName = "char021", live2DAssetBundleName = "live2d/char021.assetbundle", live2DScale = 3, photoScale = 2.5, 
photoLocation = {-64, -108}
, SteadyState = 1}
, 
[1054] = {id = 1054, type = 1, prefabName = "char_024_dragon", prefabNameUI = "char_024_dragon", mapPrefabName = "char_024_dragonm", yardPrefabName = "char_024y", dormPrefabName = "char_024d", assetBundleName = "characters/char_024_dragon.prefabs.assetbundle", lihuiID = 10770, headID = 10872, littleHeadID = 10872, DiamondHeadID = 10838, bustID = 10906, bigbustID = 10940, skillHeadID = 10804, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1055] = {id = 1055, type = 1, prefabName = "char_033", prefabNameUI = "char_033UI", mapPrefabName = "char_033m", yardPrefabName = "char_033y", dormPrefabName = "char_033d", assetBundleName = "characters/char_033.prefabs.assetbundle", lihuiID = 10771, headID = 10873, littleHeadID = 10873, DiamondHeadID = 10839, bustID = 10907, bigbustID = 10941, skillHeadID = 10805, drawShowID = 12503, battleEmotion = "1", live2DPrefabName = "char033", live2DAssetBundleName = "live2d/char033.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-27, -120}
, SteadyState = 1}
, 
[1056] = {id = 1056, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 12504, battleEmotion = "1", live2DPrefabName = "char034", live2DAssetBundleName = "live2d/char034.assetbundle", live2DScale = 3.2, photoScale = 3.5, 
photoLocation = {-13, 5}
, SteadyState = 1}
, 
[1057] = {id = 1057, type = 1, prefabName = "char_031Core", prefabNameUI = "char_034UI", mapPrefabName = "char_031Corem", yardPrefabName = "char_031y", dormPrefabName = "char_031d", assetBundleName = "characters/char_031.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 12501, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1058] = {id = 1058, type = 1, prefabName = "char_057", prefabNameUI = "char_057UI", mapPrefabName = "char_057m", yardPrefabName = "char_057y", dormPrefabName = "char_057d", assetBundleName = "characters/char_057.prefabs.assetbundle", lihuiID = 11976, headID = 12036, littleHeadID = 12036, DiamondHeadID = 12016, bustID = 12056, bigbustID = 12076, skillHeadID = 11996, drawShowID = 12523, battleEmotion = "1", live2DPrefabName = "char057", live2DAssetBundleName = "live2d/char057.assetbundle", live2DScale = 3.4, photoScale = 3.5, 
photoLocation = {-176, -87}
, SteadyState = 1}
, 
[1059] = {id = 1059, type = 1, prefabName = "char_052", prefabNameUI = "char_052UI", mapPrefabName = "char_052m", yardPrefabName = "char_052y", dormPrefabName = "char_052d", assetBundleName = "characters/char_052.prefabs.assetbundle", lihuiID = 11807, headID = 11528, littleHeadID = 11528, DiamondHeadID = 11520, bustID = 11536, bigbustID = 11544, skillHeadID = 11512, drawShowID = 12518, battleEmotion = "1", live2DPrefabName = "char052", live2DAssetBundleName = "live2d/char052.assetbundle", live2DScale = 3.7, photoScale = 3.2, 
photoLocation = {-59, -109}
, SteadyState = 1}
, 
[1060] = {id = 1060, type = 1, prefabName = "char_053", prefabNameUI = "char_053UI", mapPrefabName = "char_053m", yardPrefabName = "char_053y", dormPrefabName = "char_053d", assetBundleName = "characters/char_053.prefabs.assetbundle", lihuiID = 11806, headID = 11529, littleHeadID = 11529, DiamondHeadID = 11521, bustID = 11537, bigbustID = 11545, skillHeadID = 11513, drawShowID = 12519, battleEmotion = "1", live2DPrefabName = "char053", live2DAssetBundleName = "live2d/char053.assetbundle", live2DScale = 2.7, photoScale = 2.2, 
photoLocation = {-11, -22}
, SteadyState = 1}
, 
[1061] = {id = 1061, type = 1, prefabName = "char_054", prefabNameUI = "char_054UI", mapPrefabName = "char_054m", yardPrefabName = "char_054y", dormPrefabName = "char_054d", assetBundleName = "characters/char_054.prefabs.assetbundle", lihuiID = 12091, headID = 11530, littleHeadID = 11530, DiamondHeadID = 11522, bustID = 11538, bigbustID = 11546, skillHeadID = 11514, drawShowID = 12520, battleEmotion = "1", live2DPrefabName = "char054", live2DAssetBundleName = "live2d/char054.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-60, -140}
, SteadyState = 1}
, 
[1062] = {id = 1062, type = 1, prefabName = "char_056", prefabNameUI = "char_056UI", mapPrefabName = "char_056m", yardPrefabName = "char_056y", dormPrefabName = "char_056d", assetBundleName = "characters/char_056.prefabs.assetbundle", lihuiID = 12090, headID = 11532, littleHeadID = 11532, DiamondHeadID = 11524, bustID = 11540, bigbustID = 11548, skillHeadID = 11516, drawShowID = 12522, battleEmotion = "1", live2DPrefabName = "char056", live2DAssetBundleName = "live2d/char056.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1063] = {id = 1063, type = 1, prefabName = "char_065", prefabNameUI = "char_065UI", mapPrefabName = "char_065m", yardPrefabName = "char_065y", dormPrefabName = "char_065d", assetBundleName = "characters/char_065.prefabs.assetbundle", lihuiID = 12270, headID = 11656, littleHeadID = 11656, DiamondHeadID = 11647, bustID = 11665, bigbustID = 11674, skillHeadID = 11638, drawShowID = 12530, battleEmotion = "1", live2DPrefabName = "char065", live2DAssetBundleName = "live2d/char065.assetbundle", live2DScale = 2.9, photoScale = 2.5, 
photoLocation = {-55, -80}
, SteadyState = 1}
, 
[1064] = {id = 1064, type = 1, prefabName = "char_058", prefabNameUI = "char_058UI", mapPrefabName = "char_058m", yardPrefabName = "char_058y", dormPrefabName = "char_058d", assetBundleName = "characters/char_058.prefabs.assetbundle", lihuiID = 12089, headID = 11533, littleHeadID = 11533, DiamondHeadID = 11525, bustID = 11541, bigbustID = 11549, skillHeadID = 11517, drawShowID = 12524, battleEmotion = "1", live2DPrefabName = "char058", live2DAssetBundleName = "live2d/char058.assetbundle", live2DScale = 3.6, photoScale = 3, 
photoLocation = {29, -154}
, SteadyState = 1}
, 
[1065] = {id = 1065, type = 1, prefabName = "char_091", prefabNameUI = "char_091UI", mapPrefabName = "char_091m", yardPrefabName = "char_091y", dormPrefabName = "char_091d", assetBundleName = "characters/char_091.prefabs.assetbundle", lihuiID = 14486, headID = 14489, littleHeadID = 14489, DiamondHeadID = 14488, bustID = 14490, bigbustID = 14492, skillHeadID = 14487, drawShowID = 14491, battleEmotion = "1", live2DPrefabName = "char091", live2DAssetBundleName = "live2d/char091.assetbundle", live2DScale = 2.55, photoScale = 3.3, 
photoLocation = {-44, -169}
, SteadyState = 1}
, 
[1066] = {id = 1066, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1067] = {id = 1067, type = 1, prefabName = "char_060", prefabNameUI = "char_060UI", mapPrefabName = "char_060m", yardPrefabName = "char_060y", dormPrefabName = "char_060d", assetBundleName = "characters/char_060.prefabs.assetbundle", lihuiID = 11808, headID = 11653, littleHeadID = 11653, DiamondHeadID = 11644, bustID = 11662, bigbustID = 11671, skillHeadID = 11635, drawShowID = 12525, battleEmotion = "1", live2DPrefabName = "char060_hx", live2DAssetBundleName = "live2d/char060_hx.assetbundle", live2DScale = 3.8, photoScale = 3.2, 
photoLocation = {0, -74}
, SteadyState = 1}
, 
[1068] = {id = 1068, type = 1, prefabName = "char_081", prefabNameUI = "char_081UI", mapPrefabName = "char_081m", yardPrefabName = "char_081y", dormPrefabName = "char_081d", assetBundleName = "characters/char_081.prefabs.assetbundle", lihuiID = 13484, headID = 13487, littleHeadID = 13487, DiamondHeadID = 13486, bustID = 13488, bigbustID = 13490, skillHeadID = 13485, drawShowID = 13489, battleEmotion = "1", live2DPrefabName = "char081", live2DAssetBundleName = "live2d/char081.assetbundle", live2DScale = 3.3, photoScale = 3.3, 
photoLocation = {0, 46}
, SteadyState = 1}
, 
[1069] = {id = 1069, type = 1, prefabName = "char_061", prefabNameUI = "char_061UI", mapPrefabName = "char_061m", yardPrefabName = "char_061y", dormPrefabName = "char_061d", assetBundleName = "characters/char_061.prefabs.assetbundle", lihuiID = 12084, headID = 11654, littleHeadID = 11654, DiamondHeadID = 11645, bustID = 11663, bigbustID = 11672, skillHeadID = 11636, drawShowID = 12526, battleEmotion = "1", live2DPrefabName = "char061", live2DAssetBundleName = "live2d/char061.assetbundle", live2DScale = 2.9, photoScale = 3.2, 
photoLocation = {76, -17}
, SteadyState = 1}
, 
[1070] = {id = 1070, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1071] = {id = 1071, type = 1, prefabName = "char_063", prefabNameUI = "char_063UI", mapPrefabName = "char_063m", yardPrefabName = "char_063y", dormPrefabName = "char_063d", assetBundleName = "characters/char_063.prefabs.assetbundle", lihuiID = 12092, headID = 11535, littleHeadID = 11535, DiamondHeadID = 11527, bustID = 11543, bigbustID = 11551, skillHeadID = 11519, drawShowID = 12528, battleEmotion = "1", live2DPrefabName = "char063", live2DAssetBundleName = "live2d/char063.assetbundle", live2DScale = 2.8, photoScale = 3.2, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1072] = {id = 1072, type = 1, prefabName = "char_064", prefabNameUI = "char_064UI", mapPrefabName = "char_064m", yardPrefabName = "char_064y", dormPrefabName = "char_064d", assetBundleName = "characters/char_064.prefabs.assetbundle", lihuiID = 14312, headID = 14315, littleHeadID = 14315, DiamondHeadID = 14314, bustID = 14316, bigbustID = 14318, skillHeadID = 14313, drawShowID = 14317, battleEmotion = "1", live2DPrefabName = "char064", live2DAssetBundleName = "live2d/char064.assetbundle", live2DScale = 2.5, photoScale = 2.4, 
photoLocation = {7, -9}
, SteadyState = 1}
, 
[1073] = {id = 1073, type = 1, prefabName = "char_062", prefabNameUI = "char_062UI", mapPrefabName = "char_062m", yardPrefabName = "char_062y", dormPrefabName = "char_062d", assetBundleName = "characters/char_062.prefabs.assetbundle", lihuiID = 12093, headID = 11655, littleHeadID = 11655, DiamondHeadID = 11646, bustID = 11664, bigbustID = 11673, skillHeadID = 11637, drawShowID = 12527, battleEmotion = "1", live2DPrefabName = "char062", live2DAssetBundleName = "live2d/char062.assetbundle", live2DScale = 2.5, photoScale = 2.8, 
photoLocation = {-13, -117}
, SteadyState = 1}
, 
[1074] = {id = 1074, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1075] = {id = 1075, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1076] = {id = 1076, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1077] = {id = 1077, type = 1, prefabName = "char_069", prefabNameUI = "char_069UI", mapPrefabName = "char_069m", yardPrefabName = "char_069y", dormPrefabName = "char_069d", assetBundleName = "characters/char_069.prefabs.assetbundle", lihuiID = 12094, headID = 11657, littleHeadID = 11657, DiamondHeadID = 11648, bustID = 11666, bigbustID = 11675, skillHeadID = 11639, drawShowID = 12531, battleEmotion = "1", live2DPrefabName = "char069_hx", live2DAssetBundleName = "live2d/char069_hx.assetbundle", live2DScale = 3, photoScale = 2.6, 
photoLocation = {-24, -63}
, SteadyState = 1}
, 
[1078] = {id = 1078, type = 1, prefabName = "char_070", prefabNameUI = "char_070UI", mapPrefabName = "char_070m", yardPrefabName = "char_070y", dormPrefabName = "char_070d", assetBundleName = "characters/char_070.prefabs.assetbundle", lihuiID = 12199, headID = 11658, littleHeadID = 11658, DiamondHeadID = 11649, bustID = 11667, bigbustID = 11676, skillHeadID = 11640, drawShowID = 12532, battleEmotion = "1", live2DPrefabName = "char070", live2DAssetBundleName = "live2d/char070.assetbundle", live2DScale = 3.7, photoScale = 3.2, 
photoLocation = {0, -235}
, SteadyState = 1}
, 
[1079] = {id = 1079, type = 1, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 10772, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1080] = {id = 1080, type = 1, prefabName = "char_072", prefabNameUI = "char_072UI", mapPrefabName = "char_072m", yardPrefabName = "char_072y", dormPrefabName = "char_072d", assetBundleName = "characters/char_072.prefabs.assetbundle", lihuiID = 12723, headID = 12738, littleHeadID = 12738, DiamondHeadID = 12754, bustID = 12770, bigbustID = 12802, skillHeadID = 12786, drawShowID = 12814, battleEmotion = "1", live2DPrefabName = "char072", live2DAssetBundleName = "live2d/char072.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {30, -100}
, SteadyState = 1}
, 
[1081] = {id = 1081, type = 1, prefabName = "char_057_summon", prefabNameUI = "char_057_summonUI", mapPrefabName = "char_057_summonm", yardPrefabName = "char_057_summony", dormPrefabName = "char_057_summond", assetBundleName = "characters/char_057_summon.prefabs.assetbundle", lihuiID = 12095, headID = 10874, littleHeadID = 10874, DiamondHeadID = 10840, bustID = 10908, bigbustID = 10942, skillHeadID = 10806, drawShowID = 12523, battleEmotion = "1", live2DPrefabName = "char057", live2DAssetBundleName = "live2d/char057.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1082] = {id = 1082, type = 1, prefabName = "char_061_summon", prefabNameUI = "char_061_summonUI", mapPrefabName = "char_061_summonm", yardPrefabName = "char_061_summony", dormPrefabName = "char_061_summond", assetBundleName = "characters/char_061_summon.prefabs.assetbundle", lihuiID = 10772, headID = 11654, littleHeadID = 11654, DiamondHeadID = 11645, bustID = 11663, bigbustID = 11672, skillHeadID = 11636, drawShowID = 12526, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1083] = {id = 1083, type = 1, prefabName = "char_073", prefabNameUI = "char_073UI", mapPrefabName = "char_073m", yardPrefabName = "char_073y", dormPrefabName = "char_073d", assetBundleName = "characters/char_073.prefabs.assetbundle", lihuiID = 12725, headID = 12740, littleHeadID = 12740, DiamondHeadID = 12756, bustID = 12772, bigbustID = 12804, skillHeadID = 12788, drawShowID = 12815, battleEmotion = "1", live2DPrefabName = "char073_hx", live2DAssetBundleName = "live2d/char073_hx.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-46, -57}
, SteadyState = 1}
, 
[1084] = {id = 1084, type = 1, prefabName = "char_074", prefabNameUI = "char_074UI", mapPrefabName = "char_074m", yardPrefabName = "char_074y", dormPrefabName = "char_074d", assetBundleName = "characters/char_074.prefabs.assetbundle", lihuiID = 12726, headID = 12741, littleHeadID = 12741, DiamondHeadID = 12757, bustID = 12773, bigbustID = 12805, skillHeadID = 12789, drawShowID = 12816, battleEmotion = "1", live2DPrefabName = "char074", live2DAssetBundleName = "live2d/char074.assetbundle", live2DScale = 4.2, photoScale = 2.8, 
photoLocation = {-11, -154}
, SteadyState = 1}
, 
[1085] = {id = 1085, type = 1, prefabName = "char_075", prefabNameUI = "char_075UI", mapPrefabName = "char_075m", yardPrefabName = "char_075y", dormPrefabName = "char_075d", assetBundleName = "characters/char_075.prefabs.assetbundle", lihuiID = 11977, headID = 12037, littleHeadID = 12037, DiamondHeadID = 12017, bustID = 12057, bigbustID = 12077, skillHeadID = 11997, drawShowID = 12533, battleEmotion = "1", live2DPrefabName = "char075", live2DAssetBundleName = "live2d/char075.assetbundle", live2DScale = 2.9, photoScale = 2.7, 
photoLocation = {-19, -160}
, SteadyState = 1}
, 
[1086] = {id = 1086, type = 1, prefabName = "char_076", prefabNameUI = "char_076UI", mapPrefabName = "char_076m", yardPrefabName = "char_076y", dormPrefabName = "char_076d", assetBundleName = "characters/char_076.prefabs.assetbundle", lihuiID = 11978, headID = 12038, littleHeadID = 12038, DiamondHeadID = 12018, bustID = 12058, bigbustID = 12078, skillHeadID = 11998, drawShowID = 12534, battleEmotion = "1", live2DPrefabName = "char076", live2DAssetBundleName = "live2d/char076.assetbundle", live2DScale = 3.6, photoScale = 2.5, 
photoLocation = {-31, -124}
, SteadyState = 1}
, 
[1087] = {id = 1087, type = 1, prefabName = "char_071", prefabNameUI = "char_071UI", mapPrefabName = "char_071m", yardPrefabName = "char_071y", dormPrefabName = "char_071d", assetBundleName = "characters/char_071.prefabs.assetbundle", lihuiID = 12721, headID = 12736, littleHeadID = 12736, DiamondHeadID = 12752, bustID = 12768, bigbustID = 12800, skillHeadID = 12784, drawShowID = 12813, battleEmotion = "1", live2DPrefabName = "char071", live2DAssetBundleName = "live2d/char071.assetbundle", live2DScale = 2.7, photoScale = 2.4, 
photoLocation = {0, -50}
, SteadyState = 1}
, 
[1088] = {id = 1088, type = 1, prefabName = "char_003_v1_summon", prefabNameUI = "char_003_v1_summonUI", mapPrefabName = "char_003_v1_summonm", yardPrefabName = "char_003_v1_summony", dormPrefabName = "char_003_v1_summond", assetBundleName = "characters/char_003_v1_summon.prefabs.assetbundle", lihuiID = 10772, headID = 11654, littleHeadID = 11654, DiamondHeadID = 11645, bustID = 11663, bigbustID = 11672, skillHeadID = 11636, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1089] = {id = 1089, type = 1, prefabName = "char_075_fumo", prefabNameUI = "char_075_fumoUI", mapPrefabName = "char_075_fumom", yardPrefabName = "char_075_fumoy", dormPrefabName = "char_075_fumod", assetBundleName = "characters/char_075_fumo.prefabs.assetbundle", lihuiID = 10772, headID = 11534, littleHeadID = 11534, DiamondHeadID = 11526, bustID = 11542, bigbustID = 11550, skillHeadID = 11518, drawShowID = 12533, battleEmotion = "1", live2DPrefabName = "char075", live2DAssetBundleName = "live2d/char075.assetbundle", live2DScale = 2.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1090] = {id = 1090, type = 1, prefabName = "char_066", prefabNameUI = "char_066UI", mapPrefabName = "char_066m", yardPrefabName = "char_066y", dormPrefabName = "char_066d", assetBundleName = "characters/char_066.prefabs.assetbundle", lihuiID = 12719, headID = 12734, littleHeadID = 12734, DiamondHeadID = 12750, bustID = 12766, bigbustID = 12798, skillHeadID = 12782, drawShowID = 12811, battleEmotion = "1", live2DPrefabName = "char066", live2DAssetBundleName = "live2d/char066.assetbundle", live2DScale = 2.2, photoScale = 2.8, 
photoLocation = {-36, 19}
, SteadyState = 1}
, 
[1091] = {id = 1091, type = 1, prefabName = "char_067_1", prefabNameUI = "char_067_1UI", mapPrefabName = "char_067_1m", yardPrefabName = "char_067_1y", dormPrefabName = "char_067_1d", assetBundleName = "characters/char_067_1.prefabs.assetbundle", lihuiID = 10753, headID = 10855, littleHeadID = 10855, DiamondHeadID = 10821, bustID = 10889, bigbustID = 10923, skillHeadID = 10787, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 2.3, photoScale = 2.5, 
photoLocation = {-31, -2}
, SteadyState = 1}
, 
[1092] = {id = 1092, type = 1, prefabName = "char_068", prefabNameUI = "char_068UI", mapPrefabName = "char_068m", yardPrefabName = "char_068y", dormPrefabName = "char_068d", assetBundleName = "characters/char_068.prefabs.assetbundle", lihuiID = 12720, headID = 12735, littleHeadID = 12735, DiamondHeadID = 12751, bustID = 12767, bigbustID = 12799, skillHeadID = 12783, drawShowID = 12812, battleEmotion = "1", live2DPrefabName = "char068", live2DAssetBundleName = "live2d/char068.assetbundle", live2DScale = 2.6, photoScale = 2.9, 
photoLocation = {0, -55}
, SteadyState = 1}
, 
[1093] = {id = 1093, type = 1, prefabName = "char_048_Ai", prefabNameUI = "char_048UI", mapPrefabName = "char_048m", yardPrefabName = "char_048y", dormPrefabName = "char_048d", assetBundleName = "characters/char_048_ai.prefabs.assetbundle", lihuiID = 10760, headID = 10862, littleHeadID = 10862, DiamondHeadID = 10828, bustID = 10896, bigbustID = 10930, skillHeadID = 10794, drawShowID = 12514, battleEmotion = "1", live2DPrefabName = "char048", live2DAssetBundleName = "live2d/char048.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1094] = {id = 1094, type = 1, prefabName = "char_048_Nu", prefabNameUI = "char_048UI", mapPrefabName = "char_048m", yardPrefabName = "char_048y", dormPrefabName = "char_048d", assetBundleName = "characters/char_048_nu.prefabs.assetbundle", lihuiID = 10760, headID = 10862, littleHeadID = 10862, DiamondHeadID = 10828, bustID = 10896, bigbustID = 10930, skillHeadID = 10794, drawShowID = 12514, battleEmotion = "1", live2DPrefabName = "char048", live2DAssetBundleName = "live2d/char048.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1095] = {id = 1095, type = 1, prefabName = "char_048_Xi", prefabNameUI = "char_048UI", mapPrefabName = "char_048m", yardPrefabName = "char_048y", dormPrefabName = "char_048d", assetBundleName = "characters/char_048_xi.prefabs.assetbundle", lihuiID = 10760, headID = 10862, littleHeadID = 10862, DiamondHeadID = 10828, bustID = 10896, bigbustID = 10930, skillHeadID = 10794, drawShowID = 12514, battleEmotion = "1", live2DPrefabName = "char048", live2DAssetBundleName = "live2d/char048.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1096] = {id = 1096, type = 1, prefabName = "char_017_v1", prefabNameUI = "char_017_v1UI", mapPrefabName = "char_017_v1m", yardPrefabName = "char_017_v1y", dormPrefabName = "char_017_v1d", assetBundleName = "characters/char_017_v1.prefabs.assetbundle", lihuiID = 10111, headID = 0, littleHeadID = 0, DiamondHeadID = 12346, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char_017_v1", live2DAssetBundleName = "live2d/char_017_v1.assetbundle", live2DScale = 2.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1097] = {id = 1097, type = 1, prefabName = "char_078", prefabNameUI = "char_078UI", mapPrefabName = "char_078m", yardPrefabName = "char_078y", dormPrefabName = "char_078d", assetBundleName = "characters/char_078.prefabs.assetbundle", lihuiID = 13288, headID = 13291, littleHeadID = 13291, DiamondHeadID = 13290, bustID = 13292, bigbustID = 13293, skillHeadID = 13289, drawShowID = 13300, battleEmotion = "1", live2DPrefabName = "char078", live2DAssetBundleName = "live2d/char078.assetbundle", live2DScale = 2.3, photoScale = 2.7, 
photoLocation = {-50, -120}
, SteadyState = 1}
, 
[1098] = {id = 1098, type = 1, prefabName = "char_079", prefabNameUI = "char_079UI", mapPrefabName = "char_079m", yardPrefabName = "char_079y", dormPrefabName = "char_079d", assetBundleName = "characters/char_079.prefabs.assetbundle", lihuiID = 13294, headID = 13297, littleHeadID = 13297, DiamondHeadID = 13296, bustID = 13298, bigbustID = 13299, skillHeadID = 13295, drawShowID = 13301, battleEmotion = "1", live2DPrefabName = "char079", live2DAssetBundleName = "live2d/char079.assetbundle", live2DScale = 2.7, photoScale = 3.1, 
photoLocation = {45, -115}
, SteadyState = 1}
, 
[1099] = {id = 1099, type = 1, prefabName = "char_089", prefabNameUI = "char_089UI", mapPrefabName = "char_089m", yardPrefabName = "char_089y", dormPrefabName = "char_089d", assetBundleName = "characters/char_089.prefabs.assetbundle", lihuiID = 13460, headID = 13457, littleHeadID = 13457, DiamondHeadID = 13462, bustID = 13458, bigbustID = 13459, skillHeadID = 13461, drawShowID = 13463, battleEmotion = "1", live2DPrefabName = "char089", live2DAssetBundleName = "live2d/char089.assetbundle", live2DScale = 3.6, photoScale = 2.8, 
photoLocation = {-14, -182}
, SteadyState = 1}
, 
[1100] = {id = 1100, type = 1, prefabName = "char_090", prefabNameUI = "char_090UI", mapPrefabName = "char_090m", yardPrefabName = "char_090y", dormPrefabName = "char_090d", assetBundleName = "characters/char_090.prefabs.assetbundle", lihuiID = 13467, headID = 13464, littleHeadID = 13464, DiamondHeadID = 13469, bustID = 13465, bigbustID = 13466, skillHeadID = 13468, drawShowID = 13470, battleEmotion = "1", live2DPrefabName = "char090", live2DAssetBundleName = "live2d/char090.assetbundle", live2DScale = 3.2, photoScale = 2.5, 
photoLocation = {0, -71}
, SteadyState = 1}
, 
[1101] = {id = 1101, type = 1, prefabName = "char_083", prefabNameUI = "char_083UI", mapPrefabName = "char_083m", yardPrefabName = "char_083y", dormPrefabName = "char_083d", assetBundleName = "characters/char_083.prefabs.assetbundle", lihuiID = 13770, headID = 13773, littleHeadID = 13773, DiamondHeadID = 13772, bustID = 13774, bigbustID = 13775, skillHeadID = 13771, drawShowID = 13776, battleEmotion = "1", live2DPrefabName = "char083", live2DAssetBundleName = "live2d/char083.assetbundle", live2DScale = 3.25, photoScale = 3, 
photoLocation = {-25, -223}
, SteadyState = 1}
, 
[1102] = {id = 1102, type = 1, prefabName = "char_095", prefabNameUI = "char_095UI", mapPrefabName = "char_095m", yardPrefabName = "char_095y", dormPrefabName = "char_095d", assetBundleName = "characters/char_095.prefabs.assetbundle", lihuiID = 12264, headID = 12267, littleHeadID = 12267, DiamondHeadID = 12266, bustID = 12268, bigbustID = 12269, skillHeadID = 12265, drawShowID = 13824, battleEmotion = "1", live2DPrefabName = "char095", live2DAssetBundleName = "live2d/char095.assetbundle", live2DScale = 2.7, photoScale = 2.5, 
photoLocation = {0, -15}
, SteadyState = 1}
, 
[1103] = {id = 1103, type = 1, prefabName = "char_100", prefabNameUI = "char_100UI", mapPrefabName = "char_100m", yardPrefabName = "char_100y", dormPrefabName = "char_100d", assetBundleName = "characters/char_100.prefabs.assetbundle", lihuiID = 14122, headID = 14125, littleHeadID = 14125, DiamondHeadID = 14124, bustID = 14126, bigbustID = 14128, skillHeadID = 14123, drawShowID = 14127, battleEmotion = "1", live2DPrefabName = "char100", live2DAssetBundleName = "live2d/char100.assetbundle", live2DScale = 3.6, photoScale = 3.5, 
photoLocation = {95, -312}
, SteadyState = 1}
, 
[1104] = {id = 1104, type = 1, prefabName = "char_106", prefabNameUI = "char_106UI", mapPrefabName = "char_106m", yardPrefabName = "char_106y", dormPrefabName = "char_106d", assetBundleName = "characters/char_106.prefabs.assetbundle", lihuiID = 14129, headID = 14132, littleHeadID = 14132, DiamondHeadID = 14131, bustID = 14133, bigbustID = 14135, skillHeadID = 14130, drawShowID = 14134, battleEmotion = "1", live2DPrefabName = "char106", live2DAssetBundleName = "live2d/char106.assetbundle", live2DScale = 3.8, photoScale = 3.2, 
photoLocation = {-3, -246}
, SteadyState = 1}
, 
[1105] = {id = 1105, type = 1, prefabName = "char_080", prefabNameUI = "char_080UI", mapPrefabName = "char_080m", yardPrefabName = "char_080y", dormPrefabName = "char_080d", assetBundleName = "characters/char_080.prefabs.assetbundle", lihuiID = 13763, headID = 13766, littleHeadID = 13766, DiamondHeadID = 13765, bustID = 13767, bigbustID = 13768, skillHeadID = 13764, drawShowID = 13769, battleEmotion = "1", live2DPrefabName = "char080", live2DAssetBundleName = "live2d/char080.assetbundle", live2DScale = 2.6, photoScale = 3, 
photoLocation = {5, -162}
, SteadyState = 1}
, 
[1106] = {id = 1106, type = 1, prefabName = "char_108", prefabNameUI = "char_108UI", mapPrefabName = "char_108m", yardPrefabName = "char_108y", dormPrefabName = "char_108d", assetBundleName = "characters/char_108.prefabs.assetbundle", lihuiID = 13964, headID = 13967, littleHeadID = 13967, DiamondHeadID = 13966, bustID = 13968, bigbustID = 13970, skillHeadID = 13965, drawShowID = 13969, battleEmotion = "1", live2DPrefabName = "char108", live2DAssetBundleName = "live2d/char108.assetbundle", live2DScale = 3.5, photoScale = 3.4, 
photoLocation = {-57, -16}
, SteadyState = 1}
, 
[1107] = {id = 1107, type = 1, prefabName = "char_110", prefabNameUI = "char_110UI", mapPrefabName = "char_110m", yardPrefabName = "char_110y", dormPrefabName = "char_110d", assetBundleName = "characters/char_110.prefabs.assetbundle", lihuiID = 13971, headID = 13974, littleHeadID = 13974, DiamondHeadID = 13973, bustID = 13975, bigbustID = 13977, skillHeadID = 13972, drawShowID = 13976, battleEmotion = "1", live2DPrefabName = "char110", live2DAssetBundleName = "live2d/char110.assetbundle", live2DScale = 3.3, photoScale = 2.5, 
photoLocation = {48, -114}
, SteadyState = 1}
, 
[1108] = {id = 1108, type = 1, prefabName = "char_099", prefabNameUI = "char_099UI", mapPrefabName = "char_099m", yardPrefabName = "char_099y", dormPrefabName = "char_099d", assetBundleName = "characters/char_099.prefabs.assetbundle", lihuiID = 14230, headID = 14233, littleHeadID = 14233, DiamondHeadID = 14232, bustID = 14234, bigbustID = 14236, skillHeadID = 14231, drawShowID = 14235, battleEmotion = "1", live2DPrefabName = "char099", live2DAssetBundleName = "live2d/char099.assetbundle", live2DScale = 3.2, photoScale = 2.8, 
photoLocation = {-6, -11}
, SteadyState = 1}
, 
[1109] = {id = 1109, type = 1, prefabName = "char_086", prefabNameUI = "char_086UI", mapPrefabName = "char_086m", yardPrefabName = "char_086y", dormPrefabName = "char_086d", assetBundleName = "characters/char_086.prefabs.assetbundle", lihuiID = 14279, headID = 14239, littleHeadID = 14239, DiamondHeadID = 14238, bustID = 14240, bigbustID = 14242, skillHeadID = 14237, drawShowID = 14241, battleEmotion = "1", live2DPrefabName = "char086", live2DAssetBundleName = "live2d/char086.assetbundle", live2DScale = 2.7, photoScale = 2.5, 
photoLocation = {2, 71}
, SteadyState = 1}
, 
[1110] = {id = 1110, type = 1, prefabName = "char_092", prefabNameUI = "char_092UI", mapPrefabName = "char_092m", yardPrefabName = "char_092y", dormPrefabName = "char_092d", assetBundleName = "characters/char_092.prefabs.assetbundle", lihuiID = 14550, headID = 14553, littleHeadID = 14553, DiamondHeadID = 14552, bustID = 14554, bigbustID = 14556, skillHeadID = 14551, drawShowID = 14555, battleEmotion = "1", live2DPrefabName = "char092", live2DAssetBundleName = "live2d/char092.assetbundle", live2DScale = 2, photoScale = 2.6, 
photoLocation = {-67, -5}
, SteadyState = 1}
, 
[1111] = {id = 1111, type = 1, prefabName = "char_103", prefabNameUI = "char_103UI", mapPrefabName = "char_103m", yardPrefabName = "char_103y", dormPrefabName = "char_103d", assetBundleName = "characters/char_103.prefabs.assetbundle", lihuiID = 14570, headID = 14573, littleHeadID = 14573, DiamondHeadID = 14572, bustID = 14574, bigbustID = 14576, skillHeadID = 14571, drawShowID = 14575, battleEmotion = "1", live2DPrefabName = "char103", live2DAssetBundleName = "live2d/char103.assetbundle", live2DScale = 2.2, photoScale = 3.1, 
photoLocation = {7, -165}
, SteadyState = 1}
, 
[1112] = {id = 1112, type = 1, prefabName = "char_102", prefabNameUI = "char_102UI", mapPrefabName = "char_102m", yardPrefabName = "char_102y", dormPrefabName = "char_102d", assetBundleName = "characters/char_102.prefabs.assetbundle", lihuiID = 14578, headID = 14581, littleHeadID = 14581, DiamondHeadID = 14580, bustID = 14582, bigbustID = 14584, skillHeadID = 14579, drawShowID = 14583, battleEmotion = "1", live2DPrefabName = "char102", live2DAssetBundleName = "live2d/char102.assetbundle", live2DScale = 2.3, photoScale = 3, 
photoLocation = {12, -45}
, SteadyState = 1}
, 
[1113] = {id = 1113, type = 1, prefabName = "char_084", prefabNameUI = "char_084UI", mapPrefabName = "char_084m", yardPrefabName = "char_084y", dormPrefabName = "char_084d", assetBundleName = "characters/char_084.prefabs.assetbundle", lihuiID = 14599, headID = 14602, littleHeadID = 14602, DiamondHeadID = 14601, bustID = 14603, bigbustID = 14605, skillHeadID = 14600, drawShowID = 14604, battleEmotion = "1", live2DPrefabName = "char084", live2DAssetBundleName = "live2d/char084.assetbundle", live2DScale = 3.8, photoScale = 3.5, 
photoLocation = {83, -184}
, SteadyState = 1}
, 
[1114] = {id = 1114, type = 1, prefabName = "char_085", prefabNameUI = "char_085UI", mapPrefabName = "char_085m", yardPrefabName = "char_085y", dormPrefabName = "char_085d", assetBundleName = "characters/char_085.prefabs.assetbundle", lihuiID = 14607, headID = 14610, littleHeadID = 14610, DiamondHeadID = 14609, bustID = 14611, bigbustID = 14613, skillHeadID = 14608, drawShowID = 14612, battleEmotion = "1", live2DPrefabName = "char085", live2DAssetBundleName = "live2d/char085.assetbundle", live2DScale = 3.3, photoScale = 3.3, 
photoLocation = {-4, -200}
, SteadyState = 1}
, 
[1115] = {id = 1115, type = 1, prefabName = "char_085_1", prefabNameUI = "char_085_1UI", mapPrefabName = "char_085m", yardPrefabName = "char_085y", dormPrefabName = "char_085d", assetBundleName = "characters/char_085_1.prefabs.assetbundle", lihuiID = 14607, headID = 14610, littleHeadID = 14610, DiamondHeadID = 14609, bustID = 14611, bigbustID = 14613, skillHeadID = 14608, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1116] = {id = 1116, type = 1, prefabName = "char_094", prefabNameUI = "char_094UI", mapPrefabName = "char_094m", yardPrefabName = "char_094y", dormPrefabName = "char_094d", assetBundleName = "characters/char_094.prefabs.assetbundle", lihuiID = 14788, headID = 14791, littleHeadID = 14791, DiamondHeadID = 14790, bustID = 14792, bigbustID = 14794, skillHeadID = 14789, drawShowID = 14793, battleEmotion = "1", live2DPrefabName = "char094", live2DAssetBundleName = "live2d/char094.assetbundle", live2DScale = 2.3, photoScale = 2.7, 
photoLocation = {62, 0}
, SteadyState = 1}
, 
[1117] = {id = 1117, type = 1, prefabName = "char_101", prefabNameUI = "char_101UI", mapPrefabName = "char_101m", yardPrefabName = "char_101y", dormPrefabName = "char_101d", assetBundleName = "characters/char_101.prefabs.assetbundle", lihuiID = 14882, headID = 14885, littleHeadID = 14885, DiamondHeadID = 14884, bustID = 14886, bigbustID = 14888, skillHeadID = 14883, drawShowID = 14887, battleEmotion = "1", live2DPrefabName = "char101", live2DAssetBundleName = "live2d/char101.assetbundle", live2DScale = 2.1, photoScale = 2.5, 
photoLocation = {-1, 0}
, SteadyState = 1}
, 
[1118] = {id = 1118, type = 1, prefabName = "char_097", prefabNameUI = "char_097UI", mapPrefabName = "char_097m", yardPrefabName = "char_097y", dormPrefabName = "char_097d", assetBundleName = "characters/char_097.prefabs.assetbundle", lihuiID = 14944, headID = 14947, littleHeadID = 14947, DiamondHeadID = 14946, bustID = 14948, bigbustID = 14950, skillHeadID = 14945, drawShowID = 14949, battleEmotion = "1", live2DPrefabName = "char097", live2DAssetBundleName = "live2d/char097.assetbundle", live2DScale = 2.6, photoScale = 2.8, 
photoLocation = {-16, 0}
, SteadyState = 1}
, 
[1119] = {id = 1119, type = 1, prefabName = "char_088", prefabNameUI = "char_088UI", mapPrefabName = "char_088m", yardPrefabName = "char_088y", dormPrefabName = "char_088d", assetBundleName = "characters/char_088.prefabs.assetbundle", lihuiID = 14992, headID = 14995, littleHeadID = 14995, DiamondHeadID = 14994, bustID = 14996, bigbustID = 14998, skillHeadID = 14993, drawShowID = 14997, battleEmotion = "1", live2DPrefabName = "char088", live2DAssetBundleName = "live2d/char088.assetbundle", live2DScale = 3, photoScale = 3.6, 
photoLocation = {-33, -135}
, SteadyState = 1}
, 
[1120] = {id = 1120, type = 1, prefabName = "char_112", prefabNameUI = "char_112UI", mapPrefabName = "char_112m", yardPrefabName = "char_112y", dormPrefabName = "char_112d", assetBundleName = "characters/char_112.prefabs.assetbundle", lihuiID = 15070, headID = 15073, littleHeadID = 15073, DiamondHeadID = 15072, bustID = 15074, bigbustID = 15076, skillHeadID = 15071, drawShowID = 15075, battleEmotion = "1", live2DPrefabName = "char112", live2DAssetBundleName = "live2d/char112.assetbundle", live2DScale = 3.3, photoScale = 3.5, 
photoLocation = {-34, -198}
, SteadyState = 1}
, 
[1121] = {id = 1121, type = 1, prefabName = "char_104", prefabNameUI = "char_104UI", mapPrefabName = "char_104m", yardPrefabName = "char_104y", dormPrefabName = "char_104d", assetBundleName = "characters/char_104.prefabs.assetbundle", lihuiID = 14265, headID = 14268, littleHeadID = 14268, DiamondHeadID = 14267, bustID = 14269, bigbustID = 14271, skillHeadID = 14266, drawShowID = 14270, battleEmotion = "1", live2DPrefabName = "char104", live2DAssetBundleName = "live2d/char104.assetbundle", live2DScale = 3, photoScale = 2.9, 
photoLocation = {10, -179}
, SteadyState = 1}
, 
[1122] = {id = 1122, type = 1, prefabName = "char_120", prefabNameUI = "char_120UI", mapPrefabName = "char_120m", yardPrefabName = "char_120y", dormPrefabName = "char_120d", assetBundleName = "characters/char_120.prefabs.assetbundle", lihuiID = 15174, headID = 15177, littleHeadID = 15177, DiamondHeadID = 15176, bustID = 15178, bigbustID = 15180, skillHeadID = 15175, drawShowID = 15179, battleEmotion = "1", live2DPrefabName = "char120", live2DAssetBundleName = "live2d/char120.assetbundle", live2DScale = 3, photoScale = 3.2, 
photoLocation = {-16, 1}
, SteadyState = 1}
, 
[1123] = {id = 1123, type = 1, prefabName = "char_111_v1", prefabNameUI = "char_111_v1UI", mapPrefabName = "char_111_v1m", yardPrefabName = "char_111_v1y", dormPrefabName = "char_111_v1d", assetBundleName = "characters/char_111_v1.prefabs.assetbundle", lihuiID = 15198, headID = 15201, littleHeadID = 15201, DiamondHeadID = 15200, bustID = 15202, bigbustID = 15204, skillHeadID = 15199, drawShowID = 15203, battleEmotion = "1", live2DPrefabName = "char111", live2DAssetBundleName = "live2d/char111.assetbundle", live2DScale = 2.6, photoScale = 3.3, 
photoLocation = {-16, -109}
, SteadyState = 1}
, 
[1124] = {id = 1124, type = 1, prefabName = "char_113", prefabNameUI = "char_113UI", mapPrefabName = "char_113m", yardPrefabName = "char_113y", dormPrefabName = "char_113d", assetBundleName = "characters/char_113.prefabs.assetbundle", lihuiID = 15339, headID = 15342, littleHeadID = 15342, DiamondHeadID = 15341, bustID = 15343, bigbustID = 15345, skillHeadID = 15340, drawShowID = 15344, battleEmotion = "1", live2DPrefabName = "char113", live2DAssetBundleName = "live2d/char113.assetbundle", live2DScale = 2.38, photoScale = 3, 
photoLocation = {-30, -100}
, SteadyState = 1}
, 
[1125] = {id = 1125, type = 1, prefabName = "char_109", prefabNameUI = "char_109UI", mapPrefabName = "char_109m", yardPrefabName = "char_109y", dormPrefabName = "char_109d", assetBundleName = "characters/char_109.prefabs.assetbundle", lihuiID = 15353, headID = 15356, littleHeadID = 15356, DiamondHeadID = 15355, bustID = 15357, bigbustID = 15359, skillHeadID = 15354, drawShowID = 15358, battleEmotion = "1", live2DPrefabName = "char109", live2DAssetBundleName = "live2d/char109.assetbundle", live2DScale = 2, photoScale = 3, 
photoLocation = {-16, -90}
, SteadyState = 1}
, 
[1126] = {id = 1126, type = 1, prefabName = "char_115", prefabNameUI = "char_115UI", mapPrefabName = "char_115m", yardPrefabName = "char_115y", dormPrefabName = "char_115d", assetBundleName = "characters/char_115.prefabs.assetbundle", lihuiID = 15367, headID = 15370, littleHeadID = 15370, DiamondHeadID = 15369, bustID = 15371, bigbustID = 15373, skillHeadID = 15368, drawShowID = 15372, battleEmotion = "1", live2DPrefabName = "char115", live2DAssetBundleName = "live2d/char115.assetbundle", live2DScale = 3, photoScale = 3.3, 
photoLocation = {-16, -115}
, SteadyState = 1}
, 
[1127] = {id = 1127, type = 1, prefabName = "char_098", prefabNameUI = "char_098UI", mapPrefabName = "char_098m", yardPrefabName = "char_098y", dormPrefabName = "char_098d", assetBundleName = "characters/char_098.prefabs.assetbundle", lihuiID = 15381, headID = 15384, littleHeadID = 15384, DiamondHeadID = 15383, bustID = 15385, bigbustID = 15387, skillHeadID = 15382, drawShowID = 15386, battleEmotion = "1", live2DPrefabName = "char098", live2DAssetBundleName = "live2d/char098.assetbundle", live2DScale = 2.3, photoScale = 2.6, 
photoLocation = {-50, 0}
, SteadyState = 1}
, 
[1128] = {id = 1128, type = 1, prefabName = "char_107", prefabNameUI = "char_107UI", mapPrefabName = "char_107m", yardPrefabName = "char_107y", dormPrefabName = "char_107d", assetBundleName = "characters/char_107.prefabs.assetbundle", lihuiID = 15409, headID = 15412, littleHeadID = 15412, DiamondHeadID = 15411, bustID = 15413, bigbustID = 15415, skillHeadID = 15410, drawShowID = 15414, battleEmotion = "1", live2DPrefabName = "char107", live2DAssetBundleName = "live2d/char107.assetbundle", live2DScale = 3, photoScale = 2.6, 
photoLocation = {-17, 20}
, SteadyState = 1}
, 
[1129] = {id = 1129, type = 1, prefabName = "char_119", prefabNameUI = "char_119UI", mapPrefabName = "char_119m", yardPrefabName = "char_119y", dormPrefabName = "char_119d", assetBundleName = "characters/char_119.prefabs.assetbundle", lihuiID = 15395, headID = 15398, littleHeadID = 15398, DiamondHeadID = 15397, bustID = 15399, bigbustID = 15401, skillHeadID = 15396, drawShowID = 15400, battleEmotion = "1", live2DPrefabName = "char119", live2DAssetBundleName = "live2d/char119.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[1130] = {id = 1130, type = 1, prefabName = "char_105", prefabNameUI = "char_105UI", mapPrefabName = "char_105m", yardPrefabName = "char_105y", dormPrefabName = "char_105d", assetBundleName = "characters/char_105.prefabs.assetbundle", lihuiID = 15423, headID = 15426, littleHeadID = 15426, DiamondHeadID = 15425, bustID = 15427, bigbustID = 15429, skillHeadID = 15424, drawShowID = 15428, battleEmotion = "1", live2DPrefabName = "char105", live2DAssetBundleName = "live2d/char105.assetbundle", live2DScale = 2.4, photoScale = 2.6, 
photoLocation = {0, -50}
, SteadyState = 1}
, 
[1131] = {id = 1131, type = 1, prefabName = "char_117", prefabNameUI = "char_117UI", mapPrefabName = "char_117m", yardPrefabName = "char_117y", dormPrefabName = "char_117d", assetBundleName = "characters/char_117.prefabs.assetbundle", lihuiID = 15777, headID = 15780, littleHeadID = 15780, DiamondHeadID = 15779, bustID = 15781, bigbustID = 15783, skillHeadID = 15778, drawShowID = 15782, battleEmotion = "1", live2DPrefabName = "char117", live2DAssetBundleName = "live2d/char117.assetbundle", live2DScale = 2.4, photoScale = 2.6, 
photoLocation = {0, -50}
, SteadyState = 1}
, 
[1132] = {id = 1132, type = 1, prefabName = "char_122", prefabNameUI = "char_122UI", mapPrefabName = "char_122m", yardPrefabName = "char_122y", dormPrefabName = "char_122d", assetBundleName = "characters/char_122.prefabs.assetbundle", lihuiID = 15800, headID = 15803, littleHeadID = 15803, DiamondHeadID = 15802, bustID = 15804, bigbustID = 15806, skillHeadID = 15801, drawShowID = 15805, battleEmotion = "1", live2DPrefabName = "char122", live2DAssetBundleName = "live2d/char122.assetbundle", live2DScale = 2.4, photoScale = 2.3, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1133] = {id = 1133, type = 1, prefabName = "char_121", prefabNameUI = "char_121UI", mapPrefabName = "char_121m", yardPrefabName = "char_121y", dormPrefabName = "char_121d", assetBundleName = "characters/char_121.prefabs.assetbundle", lihuiID = 15817, headID = 15820, littleHeadID = 15820, DiamondHeadID = 15819, bustID = 15821, bigbustID = 15823, skillHeadID = 15818, drawShowID = 15822, battleEmotion = "1", live2DPrefabName = "char121", live2DAssetBundleName = "live2d/char121.assetbundle", live2DScale = 2.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1134] = {id = 1134, type = 1, prefabName = "char_123", prefabNameUI = "char_123UI", mapPrefabName = "char_123m", yardPrefabName = "char_123y", dormPrefabName = "char_123d", assetBundleName = "characters/char_123.prefabs.assetbundle", lihuiID = 15883, headID = 15886, littleHeadID = 15886, DiamondHeadID = 15885, bustID = 15887, bigbustID = 15889, skillHeadID = 15884, drawShowID = 15888, battleEmotion = "1", live2DPrefabName = "char123", live2DAssetBundleName = "live2d/char123.assetbundle", live2DScale = 2, photoScale = 2.5, 
photoLocation = {0, 20}
, SteadyState = 1}
, 
[1135] = {id = 1135, type = 1, prefabName = "char_082", prefabNameUI = "char_082UI", mapPrefabName = "char_082m", yardPrefabName = "char_082y", dormPrefabName = "char_082d", assetBundleName = "characters/char_082.prefabs.assetbundle", lihuiID = 15912, headID = 15915, littleHeadID = 15915, DiamondHeadID = 15914, bustID = 15916, bigbustID = 15918, skillHeadID = 15913, drawShowID = 15917, battleEmotion = "1", live2DPrefabName = "char082", live2DAssetBundleName = "live2d/char082.assetbundle", live2DScale = 2.5, photoScale = 3, 
photoLocation = {0, -50}
, SteadyState = 1}
, 
[1136] = {id = 1136, type = 1, prefabName = "char_124", prefabNameUI = "char_124UI", mapPrefabName = "char_124m", yardPrefabName = "char_124y", dormPrefabName = "char_124d", assetBundleName = "characters/char_124.prefabs.assetbundle", lihuiID = 15936, headID = 15939, littleHeadID = 15939, DiamondHeadID = 15938, bustID = 15940, bigbustID = 15942, skillHeadID = 15937, drawShowID = 15941, battleEmotion = "1", live2DPrefabName = "char124", live2DAssetBundleName = "live2d/char124.assetbundle", live2DScale = 1.9, photoScale = 2.3, 
photoLocation = {0, -20}
, SteadyState = 1}
, 
[1137] = {id = 1137, type = 1, prefabName = "char_116", prefabNameUI = "char_116UI", mapPrefabName = "char_116m", yardPrefabName = "char_116y", dormPrefabName = "char_116d", assetBundleName = "characters/char_116.prefabs.assetbundle", lihuiID = 15960, headID = 15963, littleHeadID = 15963, DiamondHeadID = 15962, bustID = 15964, bigbustID = 15966, skillHeadID = 15961, drawShowID = 15965, battleEmotion = "1", live2DPrefabName = "char116", live2DAssetBundleName = "live2d/char116.assetbundle", live2DScale = 2, photoScale = 2.5, 
photoLocation = {0, -20}
, SteadyState = 1}
, 
[1138] = {id = 1138, type = 1, prefabName = "char_093", prefabNameUI = "char_093UI", mapPrefabName = "char_093m", yardPrefabName = "char_093y", dormPrefabName = "char_093d", assetBundleName = "characters/char_093.prefabs.assetbundle", lihuiID = 15984, headID = 15987, littleHeadID = 15987, DiamondHeadID = 15986, bustID = 15988, bigbustID = 15990, skillHeadID = 15985, drawShowID = 15989, battleEmotion = "1", live2DPrefabName = "char093", live2DAssetBundleName = "live2d/char093.assetbundle", live2DScale = 1.6, photoScale = 2.5, 
photoLocation = {0, -20}
, SteadyState = 1}
, 
[1139] = {id = 1139, type = 1, prefabName = "char_118", prefabNameUI = "char_118UI", mapPrefabName = "char_118m", yardPrefabName = "char_118y", dormPrefabName = "char_118d", assetBundleName = "characters/char_118.prefabs.assetbundle", lihuiID = 16016, headID = 16019, littleHeadID = 16019, DiamondHeadID = 16018, bustID = 16020, bigbustID = 16022, skillHeadID = 16017, drawShowID = 16021, battleEmotion = "1", live2DPrefabName = "char118", live2DAssetBundleName = "live2d/char118.assetbundle", live2DScale = 2.6, photoScale = 2.8, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1140] = {id = 1140, type = 1, prefabName = "char_126", prefabNameUI = "char_126UI", mapPrefabName = "char_126m", yardPrefabName = "char_126y", dormPrefabName = "char_126d", assetBundleName = "characters/char_126.prefabs.assetbundle", lihuiID = 16036, headID = 16039, littleHeadID = 16039, DiamondHeadID = 16038, bustID = 16040, bigbustID = 16042, skillHeadID = 16037, drawShowID = 16041, battleEmotion = "1", live2DPrefabName = "char126", live2DAssetBundleName = "live2d/char126.assetbundle", live2DScale = 2.3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[1142] = {id = 1142, type = 1, prefabName = "char_130", prefabNameUI = "char_130UI", mapPrefabName = "char_130m", yardPrefabName = "char_130y", dormPrefabName = "char_130d", assetBundleName = "characters/char_130.prefabs.assetbundle", lihuiID = 16084, headID = 16087, littleHeadID = 16087, DiamondHeadID = 16086, bustID = 16088, bigbustID = 16090, skillHeadID = 16085, drawShowID = 16089, battleEmotion = "1", live2DPrefabName = "char130", live2DAssetBundleName = "live2d/char130.assetbundle", live2DScale = 2.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[5001] = {id = 5001, type = 4, prefabName = "n_w2_01", prefabNameUI = "n_w2_01", mapPrefabName = "n_w2_01", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5002] = {id = 5002, type = 4, prefabName = "n_w2_02", prefabNameUI = "n_w2_02", mapPrefabName = "n_w2_02", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5003] = {id = 5003, type = 4, prefabName = "n_w2_03", prefabNameUI = "n_w2_03", mapPrefabName = "n_w2_03", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5004] = {id = 5004, type = 4, prefabName = "n_w2_04", prefabNameUI = "n_w2_04", mapPrefabName = "n_w2_04", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5005] = {id = 5005, type = 4, prefabName = "n_w2_05", prefabNameUI = "n_w2_05", mapPrefabName = "n_w2_05", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5006] = {id = 5006, type = 4, prefabName = "n_w2_06", prefabNameUI = "n_w2_06", mapPrefabName = "n_w2_06", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5007] = {id = 5007, type = 4, prefabName = "n_w2_07", prefabNameUI = "n_w2_07", mapPrefabName = "n_w2_07", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5008] = {id = 5008, type = 4, prefabName = "n_w2_08", prefabNameUI = "n_w2_08", mapPrefabName = "n_w2_08", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5009] = {id = 5009, type = 4, prefabName = "n_w2_09", prefabNameUI = "n_w2_09", mapPrefabName = "n_w2_09", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5010] = {id = 5010, type = 4, prefabName = "n_w2_10", prefabNameUI = "n_w2_10", mapPrefabName = "n_w2_10", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_10.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5011] = {id = 5011, type = 4, prefabName = "n_w2_11", prefabNameUI = "n_w2_11", mapPrefabName = "n_w2_11", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_11.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5012] = {id = 5012, type = 4, prefabName = "n_w2_12", prefabNameUI = "n_w2_12", mapPrefabName = "n_w2_12", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_12.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5013] = {id = 5013, type = 4, prefabName = "boss_w2_04", prefabNameUI = "boss_w2_04UI", mapPrefabName = "boss_w2_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5014] = {id = 5014, type = 4, prefabName = "n001", prefabNameUI = "n001UI", mapPrefabName = "n001m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n001.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5015] = {id = 5015, type = 4, prefabName = "n006", prefabNameUI = "n006UI", mapPrefabName = "n006m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n006.prefabs.assetbundle", lihuiID = 11699, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "n006", live2DAssetBundleName = "live2d/n006.assetbundle", live2DScale = 2.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5016] = {id = 5016, type = 4, prefabName = "n005", prefabNameUI = "n005UI", mapPrefabName = "n005", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n005.prefabs.assetbundle", lihuiID = 11700, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "n007", live2DAssetBundleName = "live2d/n007.assetbundle", live2DScale = 2.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5017] = {id = 5017, type = 4, prefabName = "n_w2_08sit", prefabNameUI = "n_w2_08", mapPrefabName = "n_w2_08sit", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_w2_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5018] = {id = 5018, type = 4, prefabName = "n_fs_01", prefabNameUI = "n_fs_01", mapPrefabName = "n_fs_01", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_fs_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5019] = {id = 5019, type = 4, prefabName = "n_fs_02", prefabNameUI = "n_fs_02", mapPrefabName = "n_fs_02", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_fs_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5020] = {id = 5020, type = 4, prefabName = "n_fs_03", prefabNameUI = "n_fs_03", mapPrefabName = "n_fs_03", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n_fs_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5021] = {id = 5021, type = 4, prefabName = "char_010", prefabNameUI = "char_010UI", mapPrefabName = "char_010m2", yardPrefabName = "char_010y", dormPrefabName = "char_010d", assetBundleName = "characters/char_010.prefabs.assetbundle", lihuiID = 10104, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char010", live2DAssetBundleName = "live2d/char010.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[5022] = {id = 5022, type = 1, prefabName = "char_013", prefabNameUI = "char_013UI", mapPrefabName = "char_013m", yardPrefabName = "char_013y", dormPrefabName = "char_013d", assetBundleName = "characters/char_013.prefabs.assetbundle", lihuiID = 10108, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char013", live2DAssetBundleName = "live2d/char013.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[5023] = {id = 5023, type = 4, prefabName = "char_001", prefabNameUI = "char_001UI", mapPrefabName = "char_001m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_001.prefabs.assetbundle", lihuiID = 10018, headID = 10080, littleHeadID = 10080, DiamondHeadID = 0, bustID = 10124, bigbustID = 10295, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001", live2DAssetBundleName = "live2d/char001.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5024] = {id = 5024, type = 4, prefabName = "char_011", prefabNameUI = "char_011UI", mapPrefabName = "char_011m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_011.prefabs.assetbundle", lihuiID = 10118, headID = 10080, littleHeadID = 10080, DiamondHeadID = 0, bustID = 10124, bigbustID = 10295, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char011", live2DAssetBundleName = "live2d/char011.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[5025] = {id = 5025, type = 4, prefabName = "n009", prefabNameUI = "n009UI", mapPrefabName = "n009m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n009m.prefabs.assetbundle", lihuiID = 12230, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w3_1", live2DAssetBundleName = "live2d/boss_w3_1.assetbundle", live2DScale = 2, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5026] = {id = 5026, type = 4, prefabName = "n014", prefabNameUI = "n014", mapPrefabName = "n014", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n014.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5027] = {id = 5027, type = 4, prefabName = "n015", prefabNameUI = "n015", mapPrefabName = "n015", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n015.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5028] = {id = 5028, type = 4, prefabName = "n016", prefabNameUI = "n016", mapPrefabName = "n016", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n016.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5029] = {id = 5029, type = 4, prefabName = "n013", prefabNameUI = "n013", mapPrefabName = "n013", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n013.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5030] = {id = 5030, type = 4, prefabName = "n014", prefabNameUI = "n014", mapPrefabName = "n014", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n014.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5031] = {id = 5031, type = 4, prefabName = "n015", prefabNameUI = "n015", mapPrefabName = "n015", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n015.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[5032] = {id = 5032, type = 4, prefabName = "n016", prefabNameUI = "n016", mapPrefabName = "n016", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n016.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10001] = {id = 10001, type = 2, prefabName = "mon_w1_38", prefabNameUI = "mon_w1_38UI", mapPrefabName = "mon_w1_38m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_38.prefabs.assetbundle", lihuiID = 0, headID = 10029, littleHeadID = 10029, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10002] = {id = 10002, type = 2, prefabName = "mon_w1_42", prefabNameUI = "mon_w1_42UI", mapPrefabName = "mon_w1_42m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_42.prefabs.assetbundle", lihuiID = 0, headID = 10030, littleHeadID = 10030, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10003] = {id = 10003, type = 2, prefabName = "mon_w1_32", prefabNameUI = "mon_w1_32UI", mapPrefabName = "mon_w1_32m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_32.prefabs.assetbundle", lihuiID = 0, headID = 10031, littleHeadID = 10031, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10004] = {id = 10004, type = 2, prefabName = "mon_w1_41", prefabNameUI = "mon_w1_41UI", mapPrefabName = "0", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_41.prefabs.assetbundle", lihuiID = 0, headID = 10032, littleHeadID = 10032, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10005] = {id = 10005, type = 2, prefabName = "mon_w1_39", prefabNameUI = "mon_w1_39UI", mapPrefabName = "mon_w1_39m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_39.prefabs.assetbundle", lihuiID = 0, headID = 10033, littleHeadID = 10033, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10006] = {id = 10006, type = 2, prefabName = "mon_w1_24", prefabNameUI = "mon_w1_24UI", mapPrefabName = "mon_w1_24m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_24.prefabs.assetbundle", lihuiID = 0, headID = 10187, littleHeadID = 10187, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10007] = {id = 10007, type = 2, prefabName = "mon_w1_23", prefabNameUI = "mon_w1_23UI", mapPrefabName = "mon_w1_23m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_23.prefabs.assetbundle", lihuiID = 0, headID = 10186, littleHeadID = 10186, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10008] = {id = 10008, type = 2, prefabName = "mon_w1_22", prefabNameUI = "mon_w1_22UI", mapPrefabName = "mon_w1_22m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_22.prefabs.assetbundle", lihuiID = 0, headID = 10185, littleHeadID = 10185, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10009] = {id = 10009, type = 2, prefabName = "mon_w1_21", prefabNameUI = "mon_w1_21UI", mapPrefabName = "mon_w1_21m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_21.prefabs.assetbundle", lihuiID = 0, headID = 10184, littleHeadID = 10184, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10010] = {id = 10010, type = 2, prefabName = "mon_w1_20", prefabNameUI = "mon_w1_20UI", mapPrefabName = "mon_w1_20m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_20.prefabs.assetbundle", lihuiID = 0, headID = 10183, littleHeadID = 10183, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10011] = {id = 10011, type = 2, prefabName = "mon_w1_37", prefabNameUI = "mon_w1_37UI", mapPrefabName = "mon_w1_37m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_37.prefabs.assetbundle", lihuiID = 0, headID = 10034, littleHeadID = 10034, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10012] = {id = 10012, type = 2, prefabName = "mon_w1_19", prefabNameUI = "mon_w1_19UI", mapPrefabName = "mon_w1_19m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_19.prefabs.assetbundle", lihuiID = 0, headID = 10182, littleHeadID = 10182, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10013] = {id = 10013, type = 2, prefabName = "mon_w1_18", prefabNameUI = "mon_w1_18UI", mapPrefabName = "mon_w1_18m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_18.prefabs.assetbundle", lihuiID = 0, headID = 10181, littleHeadID = 10181, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10014] = {id = 10014, type = 2, prefabName = "mon_w1_17", prefabNameUI = "mon_w1_17UI", mapPrefabName = "mon_w1_17m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_17.prefabs.assetbundle", lihuiID = 0, headID = 10180, littleHeadID = 10180, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10015] = {id = 10015, type = 2, prefabName = "mon_w1_16", prefabNameUI = "mon_w1_16UI", mapPrefabName = "mon_w1_16m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_16.prefabs.assetbundle", lihuiID = 0, headID = 10179, littleHeadID = 10179, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10016] = {id = 10016, type = 2, prefabName = "mon_w1_15", prefabNameUI = "mon_w1_15UI", mapPrefabName = "mon_w1_15m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_15.prefabs.assetbundle", lihuiID = 0, headID = 10178, littleHeadID = 10178, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10017] = {id = 10017, type = 2, prefabName = "mon_w1_14", prefabNameUI = "mon_w1_14UI", mapPrefabName = "mon_w1_14m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_14.prefabs.assetbundle", lihuiID = 0, headID = 10177, littleHeadID = 10177, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10018] = {id = 10018, type = 2, prefabName = "mon_w1_13", prefabNameUI = "mon_w1_13UI", mapPrefabName = "mon_w1_13m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_13.prefabs.assetbundle", lihuiID = 0, headID = 10176, littleHeadID = 10176, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10019] = {id = 10019, type = 2, prefabName = "mon_w1_12", prefabNameUI = "mon_w1_12UI", mapPrefabName = "mon_w1_12m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_12.prefabs.assetbundle", lihuiID = 0, headID = 10175, littleHeadID = 10175, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10020] = {id = 10020, type = 2, prefabName = "mon_w1_11", prefabNameUI = "mon_w1_11UI", mapPrefabName = "mon_w1_11m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_11.prefabs.assetbundle", lihuiID = 0, headID = 10174, littleHeadID = 10174, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10021] = {id = 10021, type = 2, prefabName = "mon_w1_10", prefabNameUI = "mon_w1_10UI", mapPrefabName = "mon_w1_10m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_10.prefabs.assetbundle", lihuiID = 11846, headID = 10173, littleHeadID = 10173, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10022] = {id = 10022, type = 2, prefabName = "mon_w1_09", prefabNameUI = "mon_w1_09UI", mapPrefabName = "mon_w1_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_09.prefabs.assetbundle", lihuiID = 10614, headID = 10172, littleHeadID = 10172, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10023] = {id = 10023, type = 2, prefabName = "mon_w1_08", prefabNameUI = "mon_w1_08UI", mapPrefabName = "mon_w1_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_08.prefabs.assetbundle", lihuiID = 11846, headID = 10171, littleHeadID = 10171, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10024] = {id = 10024, type = 2, prefabName = "mon_w1_07", prefabNameUI = "mon_w1_07UI", mapPrefabName = "mon_w1_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_07.prefabs.assetbundle", lihuiID = 0, headID = 10170, littleHeadID = 10170, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10025] = {id = 10025, type = 2, prefabName = "mon_w1_06", prefabNameUI = "mon_w1_06UI", mapPrefabName = "mon_w1_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_06.prefabs.assetbundle", lihuiID = 0, headID = 10169, littleHeadID = 10169, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10026] = {id = 10026, type = 2, prefabName = "mon_w1_05", prefabNameUI = "mon_w1_05UI", mapPrefabName = "mon_w1_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_05.prefabs.assetbundle", lihuiID = 0, headID = 10168, littleHeadID = 10168, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10027] = {id = 10027, type = 2, prefabName = "mon_w1_04", prefabNameUI = "mon_w1_04UI", mapPrefabName = "mon_w1_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_04.prefabs.assetbundle", lihuiID = 0, headID = 10167, littleHeadID = 10167, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10028] = {id = 10028, type = 2, prefabName = "mon_w1_03", prefabNameUI = "mon_w1_03UI", mapPrefabName = "mon_w1_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_03.prefabs.assetbundle", lihuiID = 0, headID = 10166, littleHeadID = 10166, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10029] = {id = 10029, type = 2, prefabName = "mon_w1_02", prefabNameUI = "mon_w1_02UI", mapPrefabName = "mon_w1_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_02.prefabs.assetbundle", lihuiID = 0, headID = 10165, littleHeadID = 10165, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10030] = {id = 10030, type = 2, prefabName = "mon_w1_01", prefabNameUI = "mon_w1_01UI", mapPrefabName = "mon_w1_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_01.prefabs.assetbundle", lihuiID = 0, headID = 10164, littleHeadID = 10164, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10031] = {id = 10031, type = 2, prefabName = "mon_w1_25", prefabNameUI = "mon_w1_25UI", mapPrefabName = "mon_w1_25m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_25.prefabs.assetbundle", lihuiID = 0, headID = 10188, littleHeadID = 10188, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10032] = {id = 10032, type = 2, prefabName = "mon_w1_26", prefabNameUI = "mon_w1_26UI", mapPrefabName = "mon_w1_26m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_26.prefabs.assetbundle", lihuiID = 0, headID = 10189, littleHeadID = 10189, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10033] = {id = 10033, type = 2, prefabName = "mon_w1_27", prefabNameUI = "mon_w1_27UI", mapPrefabName = "mon_w1_27m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_27.prefabs.assetbundle", lihuiID = 0, headID = 10190, littleHeadID = 10190, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10034] = {id = 10034, type = 2, prefabName = "mon_w1_28", prefabNameUI = "mon_w1_28UI", mapPrefabName = "mon_w1_28m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_28.prefabs.assetbundle", lihuiID = 0, headID = 10191, littleHeadID = 10191, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10035] = {id = 10035, type = 2, prefabName = "mon_w1_29", prefabNameUI = "mon_w1_29UI", mapPrefabName = "mon_w1_29m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_29.prefabs.assetbundle", lihuiID = 0, headID = 10192, littleHeadID = 10192, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10036] = {id = 10036, type = 2, prefabName = "mon_w1_30", prefabNameUI = "mon_w1_30UI", mapPrefabName = "mon_w1_30m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_30.prefabs.assetbundle", lihuiID = 0, headID = 10193, littleHeadID = 10193, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10037] = {id = 10037, type = 2, prefabName = "mon_w1_31", prefabNameUI = "mon_w1_31UI", mapPrefabName = "mon_w1_31m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_31.prefabs.assetbundle", lihuiID = 0, headID = 10194, littleHeadID = 10194, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10038] = {id = 10038, type = 2, prefabName = "mon_w1_33", prefabNameUI = "mon_w1_33UI", mapPrefabName = "mon_w1_33m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_33.prefabs.assetbundle", lihuiID = 0, headID = 10196, littleHeadID = 10196, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10039] = {id = 10039, type = 2, prefabName = "mon_w1_34", prefabNameUI = "mon_w1_34UI", mapPrefabName = "mon_w1_34m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_34.prefabs.assetbundle", lihuiID = 0, headID = 10197, littleHeadID = 10197, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10040] = {id = 10040, type = 2, prefabName = "mon_w1_35", prefabNameUI = "mon_w1_35UI", mapPrefabName = "mon_w1_35m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_35.prefabs.assetbundle", lihuiID = 0, headID = 10198, littleHeadID = 10198, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10041] = {id = 10041, type = 2, prefabName = "mon_w1_36", prefabNameUI = "mon_w1_36UI", mapPrefabName = "mon_w1_36m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_36.prefabs.assetbundle", lihuiID = 10657, headID = 10199, littleHeadID = 10199, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, -87}
, SteadyState = 1}
, 
[10042] = {id = 10042, type = 2, prefabName = "mon_w1_37", prefabNameUI = "mon_w1_37UI", mapPrefabName = "mon_w1_37m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_37.prefabs.assetbundle", lihuiID = 0, headID = 10034, littleHeadID = 10034, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10043] = {id = 10043, type = 3, prefabName = "mon_w1_38", prefabNameUI = "mon_w1_38UI", mapPrefabName = "mon_w1_38m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_38.prefabs.assetbundle", lihuiID = 10202, headID = 10029, littleHeadID = 10029, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10044] = {id = 10044, type = 2, prefabName = "mon_w1_40", prefabNameUI = "mon_w1_40UI", mapPrefabName = "mon_w1_40m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_40.prefabs.assetbundle", lihuiID = 0, headID = 10200, littleHeadID = 10200, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10045] = {id = 10045, type = 2, prefabName = "mon_t1_05", prefabNameUI = "mon_t1_05UI", mapPrefabName = "mon_t1_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_05.prefabs.assetbundle", lihuiID = 0, headID = 10196, littleHeadID = 10196, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[10046] = {id = 10046, type = 2, prefabName = "mon_w1_36", prefabNameUI = "mon_w1_36UI", mapPrefabName = "mon_w1_36m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_36.prefabs.assetbundle", lihuiID = 10658, headID = 10199, littleHeadID = 10199, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, -87}
, SteadyState = 1}
, 
[10047] = {id = 10047, type = 2, prefabName = "boss_w4_01", prefabNameUI = "boss_w4_01UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w4_01.prefabs.assetbundle", lihuiID = 11701, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w4", live2DAssetBundleName = "live2d/boss_w4.assetbundle", live2DScale = 2.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10048] = {id = 10048, type = 2, prefabName = "boss_w4_02", prefabNameUI = "boss_w4_02UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w4_02.prefabs.assetbundle", lihuiID = 11701, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10049] = {id = 10049, type = 2, prefabName = "char_028_doom", prefabNameUI = "char_028_doomUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_028_doom.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10050] = {id = 10050, type = 2, prefabName = "boss_w4_01II", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w4_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10051] = {id = 10051, type = 2, prefabName = "mon_w4_03II", prefabNameUI = "mon_w4_03UI", mapPrefabName = "mon_w4_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10052] = {id = 10052, type = 2, prefabName = "mon_chrs01", prefabNameUI = "mon_chrs01UI", mapPrefabName = "mon_chrs01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10053] = {id = 10053, type = 2, prefabName = "mon_chrs01", prefabNameUI = "mon_chrs01UI", mapPrefabName = "mon_chrs01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10054] = {id = 10054, type = 2, prefabName = "mon_chrs01", prefabNameUI = "mon_chrs01UI", mapPrefabName = "mon_chrs01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[10055] = {id = 10055, type = 2, prefabName = "mon_chrs07", prefabNameUI = "mon_chrs07UI", mapPrefabName = "mon_chrs07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20001] = {id = 20001, type = 3, prefabName = "boss_w1_02", prefabNameUI = "boss_w1_02UI", mapPrefabName = "boss_w1_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w1_01.prefabs.assetbundle", lihuiID = 0, headID = 10079, littleHeadID = 10079, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w1", live2DAssetBundleName = "live2d/boss_w1.assetbundle", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20002] = {id = 20002, type = 3, prefabName = "boss_w1_01", prefabNameUI = "boss_w1_01UI", mapPrefabName = "boss_w1_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w1_01.prefabs.assetbundle", lihuiID = 11331, headID = 10079, littleHeadID = 10079, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w1", live2DAssetBundleName = "live2d/boss_w1.assetbundle", live2DScale = 2.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20003] = {id = 20003, type = 3, prefabName = "mon_t1_01", prefabNameUI = "mon_t1_01UI", mapPrefabName = "mon_t1_01", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_01.prefabs.assetbundle", lihuiID = 0, headID = 10201, littleHeadID = 10201, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20004] = {id = 20004, type = 3, prefabName = "mon_t1_03", prefabNameUI = "mon_t1_03UI", mapPrefabName = "mon_t1_03", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20005] = {id = 20005, type = 2, prefabName = "mon_t1_06", prefabNameUI = "mon_t1_06UI", mapPrefabName = "mon_t1_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20006] = {id = 20006, type = 3, prefabName = "boss_t1_02", prefabNameUI = "boss_t1_02UI", mapPrefabName = "boss_t1_02", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_t1_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20007] = {id = 20007, type = 2, prefabName = "mon_t1_04", prefabNameUI = "mon_t1_04UI", mapPrefabName = "mon_t1_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20008] = {id = 20008, type = 2, prefabName = "mon_t1_07", prefabNameUI = "mon_t1_07UI", mapPrefabName = "mon_t1_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20009] = {id = 20009, type = 2, prefabName = "mon_w1_16", prefabNameUI = "mon_w1_16UI", mapPrefabName = "mon_w1_16m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_16.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20010] = {id = 20010, type = 2, prefabName = "mon_w1_17", prefabNameUI = "mon_w1_17UI", mapPrefabName = "mon_w1_17m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_17.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20011] = {id = 20011, type = 2, prefabName = "mon_w1_43", prefabNameUI = "mon_w1_43UI", mapPrefabName = "mon_w1_43m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_43.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20012] = {id = 20012, type = 2, prefabName = "mon_w1_39", prefabNameUI = "mon_w1_39UI", mapPrefabName = "mon_w1_39m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_39.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20013] = {id = 20013, type = 2, prefabName = "mon_w1_44", prefabNameUI = "mon_w1_44UI", mapPrefabName = "mon_w1_44m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_44.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20014] = {id = 20014, type = 2, prefabName = "mon_w1_45", prefabNameUI = "mon_w1_45UI", mapPrefabName = "mon_w1_45m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_45.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20015] = {id = 20015, type = 2, prefabName = "mon_w1_46", prefabNameUI = "mon_w1_46UI", mapPrefabName = "mon_w1_46m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_46.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20016] = {id = 20016, type = 2, prefabName = "mon_w1_47", prefabNameUI = "mon_w1_47UI", mapPrefabName = "mon_w1_47m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_47.prefabs.assetbundle", lihuiID = 10615, headID = 10209, littleHeadID = 10209, DiamondHeadID = 13078, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "w1_47", live2DAssetBundleName = "live2d/w1_47.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20017] = {id = 20017, type = 2, prefabName = "EzhiQi1", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20018] = {id = 20018, type = 2, prefabName = "EzhiQi2", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20019] = {id = 20019, type = 2, prefabName = "EzhiQi3", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20020] = {id = 20020, type = 2, prefabName = "EzhiQi4", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20021] = {id = 20021, type = 2, prefabName = "EzhiQi5", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20022] = {id = 20022, type = 2, prefabName = "EzhiQi6", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_009.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20023] = {id = 20023, type = 2, prefabName = "mon_t1_09", prefabNameUI = "mon_t1_09UI", mapPrefabName = "mon_t1_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20024] = {id = 20024, type = 2, prefabName = "mon_t1_20", prefabNameUI = "mon_t1_20UI", mapPrefabName = "mon_t1_20m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_20.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20025] = {id = 20025, type = 2, prefabName = "mon_t1_21", prefabNameUI = "mon_t1_21UI", mapPrefabName = "mon_t1_21m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_21.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20026] = {id = 20026, type = 2, prefabName = "mon_t1_22", prefabNameUI = "mon_t1_22UI", mapPrefabName = "mon_t1_22m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_22.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20027] = {id = 20027, type = 2, prefabName = "mon_w1_25", prefabNameUI = "mon_w1_25UI", mapPrefabName = "mon_w1_25m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_25.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20028] = {id = 20028, type = 2, prefabName = "mon_w1_27", prefabNameUI = "mon_w1_27UI", mapPrefabName = "mon_w1_27m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_27.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20029] = {id = 20029, type = 2, prefabName = "mon_w1_28", prefabNameUI = "mon_w1_28UI", mapPrefabName = "mon_w1_28m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_28.prefabs.assetbundle", lihuiID = 10685, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 200}
, SteadyState = 0}
, 
[20030] = {id = 20030, type = 3, prefabName = "mon_t1_27", prefabNameUI = "mon_t1_27UI", mapPrefabName = "mon_t1_27m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_27.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 2}
, 
[20031] = {id = 20031, type = 2, prefabName = "mon_w1_48", prefabNameUI = "mon_w1_48UI", mapPrefabName = "mon_w1_48m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_48.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20032] = {id = 20032, type = 2, prefabName = "mon_w1_49", prefabNameUI = "mon_w1_49UI", mapPrefabName = "mon_w1_49m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_49.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20033] = {id = 20033, type = 2, prefabName = "boss_w1_01obj", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w1_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20034] = {id = 20034, type = 2, prefabName = "mon_w2_01", prefabNameUI = "mon_w2_01UI", mapPrefabName = "mon_w2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20035] = {id = 20035, type = 2, prefabName = "mon_w2_02", prefabNameUI = "mon_w2_02UI", mapPrefabName = "mon_w2_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20036] = {id = 20036, type = 2, prefabName = "mon_w2_03", prefabNameUI = "mon_w2_03UI", mapPrefabName = "mon_w2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20037] = {id = 20037, type = 2, prefabName = "mon_w2_06", prefabNameUI = "mon_w2_06UI", mapPrefabName = "mon_w2_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20038] = {id = 20038, type = 2, prefabName = "mon_w2_08", prefabNameUI = "mon_w2_08UI", mapPrefabName = "mon_w2_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20039] = {id = 20039, type = 2, prefabName = "mon_w2_10", prefabNameUI = "mon_w2_10UI", mapPrefabName = "mon_w2_10m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_10.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20040] = {id = 20040, type = 2, prefabName = "mon_t2_03", prefabNameUI = "mon_t2_03UI", mapPrefabName = "mon_t2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1.2, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20041] = {id = 20041, type = 2, prefabName = "mon_w2_04", prefabNameUI = "mon_w2_04UI", mapPrefabName = "mon_w2_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20042] = {id = 20042, type = 2, prefabName = "mon_w2_05", prefabNameUI = "mon_w2_05UI", mapPrefabName = "mon_w2_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.9, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20043] = {id = 20043, type = 2, prefabName = "mon_w2_07", prefabNameUI = "mon_w2_07UI", mapPrefabName = "mon_w2_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20044] = {id = 20044, type = 2, prefabName = "mon_w2_09", prefabNameUI = "mon_w2_09UI", mapPrefabName = "mon_w2_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20045] = {id = 20045, type = 2, prefabName = "mon_w2_12", prefabNameUI = "mon_w2_12UI", mapPrefabName = "mon_w2_12m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_12.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20046] = {id = 20046, type = 2, prefabName = "mon_w2_13", prefabNameUI = "mon_w2_13UI", mapPrefabName = "mon_w2_13m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_13.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20047] = {id = 20047, type = 2, prefabName = "mon_w2_14", prefabNameUI = "mon_w2_14UI", mapPrefabName = "mon_w2_14m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_14.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20048] = {id = 20048, type = 2, prefabName = "mon_w2_15", prefabNameUI = "mon_w2_15UI", mapPrefabName = "mon_w2_15m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_15.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20049] = {id = 20049, type = 2, prefabName = "mon_t1_08", prefabNameUI = "mon_t1_08UI", mapPrefabName = "mon_t1_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20050] = {id = 20050, type = 2, prefabName = "mon_t1_28", prefabNameUI = "mon_t1_28UI", mapPrefabName = "mon_t1_28m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_28.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20051] = {id = 20051, type = 2, prefabName = "mon_t2_01", prefabNameUI = "mon_t2_01UI", mapPrefabName = "mon_t2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20052] = {id = 20052, type = 2, prefabName = "mon_t2_02", prefabNameUI = "mon_t2_02UI", mapPrefabName = "mon_t2_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20053] = {id = 20053, type = 2, prefabName = "mon_w1_52", prefabNameUI = "mon_w1_52UI", mapPrefabName = "mon_w1_52m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_52.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20054] = {id = 20054, type = 2, prefabName = "mon_w1_50", prefabNameUI = "mon_w1_50UI", mapPrefabName = "mon_w1_50m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_50.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20055] = {id = 20055, type = 2, prefabName = "mon_w1_51", prefabNameUI = "mon_w1_51UI", mapPrefabName = "mon_w1_51m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_51.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20056] = {id = 20056, type = 2, prefabName = "mon_t2_07", prefabNameUI = "mon_t2_07UI", mapPrefabName = "mon_t2_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20057] = {id = 20057, type = 2, prefabName = "mon_t2_08", prefabNameUI = "mon_t2_08UI", mapPrefabName = "mon_t2_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20058] = {id = 20058, type = 2, prefabName = "mon_t2_09", prefabNameUI = "mon_t2_09UI", mapPrefabName = "mon_t2_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20059] = {id = 20059, type = 3, prefabName = "boss_w2_05", prefabNameUI = "boss_w2_05UI", mapPrefabName = "boss_w2_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20060] = {id = 20060, type = 2, prefabName = "mon_w2_11", prefabNameUI = "mon_w2_11UI", mapPrefabName = "mon_w2_11m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_11.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20061] = {id = 20061, type = 2, prefabName = "boss_w2_02", prefabNameUI = "boss_w2_02UI", mapPrefabName = "boss_w2_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_02.prefabs.assetbundle", lihuiID = 10961, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w2_2", live2DAssetBundleName = "live2d/boss_w2_2.assetbundle", live2DScale = 2.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20062] = {id = 20062, type = 2, prefabName = "boss_w2_02Wall", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_02wall.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20063] = {id = 20063, type = 2, prefabName = "mon_w1_53", prefabNameUI = "mon_w1_53UI", mapPrefabName = "mon_w1_53m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_53.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20064] = {id = 20064, type = 2, prefabName = "mon_w1_54", prefabNameUI = "mon_w1_54UI", mapPrefabName = "mon_w1_54m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_54.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20065] = {id = 20065, type = 2, prefabName = "mon_w1_55", prefabNameUI = "mon_w1_55UI", mapPrefabName = "mon_w1_55m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_55.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20066] = {id = 20066, type = 2, prefabName = "mon_w1_56", prefabNameUI = "mon_w1_56UI", mapPrefabName = "mon_w1_56m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_56.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20067] = {id = 20067, type = 2, prefabName = "mon_w1_57", prefabNameUI = "mon_w1_57UI", mapPrefabName = "mon_w1_57m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_57.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20068] = {id = 20068, type = 2, prefabName = "mon_t1_29", prefabNameUI = "mon_t1_29UI", mapPrefabName = "mon_t1_29m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_29.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20069] = {id = 20069, type = 2, prefabName = "mon_t1_30", prefabNameUI = "mon_t1_30UI", mapPrefabName = "mon_t1_30m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_30.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20070] = {id = 20070, type = 2, prefabName = "mon_t1_31", prefabNameUI = "mon_t1_31UI", mapPrefabName = "mon_t1_31m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_31.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20071] = {id = 20071, type = 2, prefabName = "mon_t2_06", prefabNameUI = "mon_t2_06UI", mapPrefabName = "mon_t2_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_06.prefabs.assetbundle", lihuiID = 11844, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "n003_hx", live2DAssetBundleName = "live2d/n003_hx.assetbundle", live2DScale = 2.3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20072] = {id = 20072, type = 2, prefabName = "boss_w2_01", prefabNameUI = "boss_w2_01UI", mapPrefabName = "boss_w2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20073] = {id = 20073, type = 2, prefabName = "mon_t2_03_low", prefabNameUI = "mon_t2_03UI", mapPrefabName = "mon_t2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20074] = {id = 20074, type = 2, prefabName = "mon_t2_03_high", prefabNameUI = "mon_t2_03UI", mapPrefabName = "mon_t2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20075] = {id = 20075, type = 2, prefabName = "boss_w2_03", prefabNameUI = "boss_w2_03UI", mapPrefabName = "boss_w2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_03.prefabs.assetbundle", lihuiID = 10961, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w2_2", live2DAssetBundleName = "live2d/boss_w2_2.assetbundle", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20076] = {id = 20076, type = 2, prefabName = "boss_w2_03Wall", prefabNameUI = "", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_02wall.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20077] = {id = 20077, type = 2, prefabName = "mon_t2_11", prefabNameUI = "mon_t2_11UI", mapPrefabName = "mon_t2_11m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_11.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20078] = {id = 20078, type = 2, prefabName = "mon_t2_12", prefabNameUI = "mon_t2_12UI", mapPrefabName = "mon_t2_12m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_12.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20079] = {id = 20079, type = 2, prefabName = "mon_t2_10", prefabNameUI = "mon_t2_10UI", mapPrefabName = "mon_t2_10m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_10.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20080] = {id = 20080, type = 2, prefabName = "mon_t2_13", prefabNameUI = "mon_t2_13UI", mapPrefabName = "mon_t2_13m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_13.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20081] = {id = 20081, type = 2, prefabName = "mon_w4_01", prefabNameUI = "mon_w4_01UI", mapPrefabName = "mon_w4_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20082] = {id = 20082, type = 2, prefabName = "mon_w4_02", prefabNameUI = "mon_w4_02UI", mapPrefabName = "mon_w4_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20083] = {id = 20083, type = 2, prefabName = "mon_w4_03", prefabNameUI = "mon_w4_03UI", mapPrefabName = "mon_w4_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20084] = {id = 20084, type = 2, prefabName = "mon_w4_04", prefabNameUI = "mon_w4_04UI", mapPrefabName = "mon_w4_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20085] = {id = 20085, type = 2, prefabName = "mon_w2_16", prefabNameUI = "mon_w2_16UI", mapPrefabName = "mon_w2_16m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_16.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20086] = {id = 20086, type = 2, prefabName = "mon_w1_29", prefabNameUI = "mon_w1_29UI", mapPrefabName = "mon_w1_29m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_29.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20087] = {id = 20087, type = 2, prefabName = "mon_w2_18", prefabNameUI = "mon_w2_18UI", mapPrefabName = "mon_w2_18m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_18.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20088] = {id = 20088, type = 2, prefabName = "mon_w2_17", prefabNameUI = "mon_w2_17UI", mapPrefabName = "mon_w2_17m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_17.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20089] = {id = 20089, type = 2, prefabName = "mon_w1_47", prefabNameUI = "mon_w1_47UI", mapPrefabName = "mon_w1_47m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_47.prefabs.assetbundle", lihuiID = 10615, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "w1_47", live2DAssetBundleName = "live2d/w1_47.assetbundle", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20090] = {id = 20090, type = 2, prefabName = "boss_w2_02", prefabNameUI = "boss_w2_02UI", mapPrefabName = "boss_w2_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_02.prefabs.assetbundle", lihuiID = 10961, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w2_2", live2DAssetBundleName = "live2d/boss_w2_2.assetbundle", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20091] = {id = 20091, type = 2, prefabName = "mon_t2_06", prefabNameUI = "mon_t2_06UI", mapPrefabName = "mon_t2_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_06.prefabs.assetbundle", lihuiID = 11844, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20092] = {id = 20092, type = 2, prefabName = "mon_w3_26", prefabNameUI = "mon_w3_26UI", mapPrefabName = "mon_w3_26m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_26.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20093] = {id = 20093, type = 3, prefabName = "mon_base_boss05mana", prefabNameUI = "mon_base_boss05manaUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss05mana.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20094] = {id = 20094, type = 3, prefabName = "mon_base_boss03warrior", prefabNameUI = "mon_base_boss03warriorUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss03warrior.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20095] = {id = 20095, type = 3, prefabName = "mon_base_boss02", prefabNameUI = "mon_base_boss02UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss02knight.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20096] = {id = 20096, type = 3, prefabName = "mon_base_boss04mage", prefabNameUI = "mon_base_boss04mageUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss04mage.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20097] = {id = 20097, type = 2, prefabName = "mon_w4_01_high", prefabNameUI = "mon_w4_01UI", mapPrefabName = "mon_w4_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20098] = {id = 20098, type = 2, prefabName = "mon_t1_11", prefabNameUI = "mon_t1_11UI", mapPrefabName = "mon_t1_11m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_11.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20099] = {id = 20099, type = 2, prefabName = "mon_w3_29", prefabNameUI = "mon_w3_29UI", mapPrefabName = "mon_w3_29m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_29.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20100] = {id = 20100, type = 2, prefabName = "mon_w3_28", prefabNameUI = "mon_w3_28UI", mapPrefabName = "mon_w3_28m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_28.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20101] = {id = 20101, type = 2, prefabName = "mon_w3_30", prefabNameUI = "mon_w3_30UI", mapPrefabName = "mon_w3_30m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_30.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20102] = {id = 20102, type = 2, prefabName = "mon_base_boss06shdow", prefabNameUI = "mon_base_boss06shdowUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss06shdow.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20103] = {id = 20103, type = 2, prefabName = "mon_base_boss07shdow02", prefabNameUI = "mon_base_boss07shdow02UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss07shdow02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20104] = {id = 20104, type = 2, prefabName = "mon_base_boss08shdow03", prefabNameUI = "mon_base_boss08shdow03UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss08shdow03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20105] = {id = 20105, type = 2, prefabName = "mon_base_boss09shdow04", prefabNameUI = "mon_base_boss09shdow04UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss09shdow04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20106] = {id = 20106, type = 2, prefabName = "mon_base_boss01", prefabNameUI = "mon_base_boss01UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20107] = {id = 20107, type = 2, prefabName = "mon_w3_27", prefabNameUI = "mon_w3_27UI", mapPrefabName = "mon_w3_27m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_27.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20108] = {id = 20108, type = 3, prefabName = "mon_base_boss05manaFenshen", prefabNameUI = "mon_base_boss05manaUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss05mana.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20109] = {id = 20109, type = 2, prefabName = "mon_w3_31", prefabNameUI = "mon_w3_31UI", mapPrefabName = "mon_w3_31m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_31.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20110] = {id = 20110, type = 2, prefabName = "mon_w3_09", prefabNameUI = "mon_w3_09UI", mapPrefabName = "mon_w3_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20111] = {id = 20111, type = 2, prefabName = "mon_w3_10", prefabNameUI = "mon_w3_10UI", mapPrefabName = "mon_w3_10m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_10.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.65, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20112] = {id = 20112, type = 2, prefabName = "mon_w3_01", prefabNameUI = "mon_w3_01UI", mapPrefabName = "mon_w3_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20113] = {id = 20113, type = 2, prefabName = "mon_w3_02", prefabNameUI = "mon_w3_02UI", mapPrefabName = "mon_w3_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20114] = {id = 20114, type = 2, prefabName = "mon_w3_03", prefabNameUI = "mon_w3_03UI", mapPrefabName = "mon_w3_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20115] = {id = 20115, type = 2, prefabName = "mon_w3_04", prefabNameUI = "mon_w3_04UI", mapPrefabName = "mon_w3_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20116] = {id = 20116, type = 2, prefabName = "mon_w3_34", prefabNameUI = "mon_w3_34UI", mapPrefabName = "mon_w3_34m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_34.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20117] = {id = 20117, type = 3, prefabName = "mon_w3_25", prefabNameUI = "mon_w3_25UI", mapPrefabName = "mon_w3_25m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_25.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20118] = {id = 20118, type = 2, prefabName = "mon_w3_07", prefabNameUI = "mon_w3_07UI", mapPrefabName = "mon_w3_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20119] = {id = 20119, type = 2, prefabName = "mon_w3_35", prefabNameUI = "mon_w3_35UI", mapPrefabName = "mon_w3_35m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_35.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20120] = {id = 20120, type = 2, prefabName = "mon_w3_36", prefabNameUI = "mon_w3_36UI", mapPrefabName = "mon_w3_36m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_36.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20121] = {id = 20121, type = 3, prefabName = "mon_w3_38", prefabNameUI = "mon_w3_38UI", mapPrefabName = "mon_w3_38m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20122] = {id = 20122, type = 3, prefabName = "mon_w3_37", prefabNameUI = "mon_w3_37UI", mapPrefabName = "mon_w3_37m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_37.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20123] = {id = 20123, type = 3, prefabName = "mon_w3_32", prefabNameUI = "mon_w3_32UI", mapPrefabName = "mon_w3_32m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_32.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20124] = {id = 20124, type = 3, prefabName = "n007", prefabNameUI = "n007UI", mapPrefabName = "n007", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n007.prefabs.assetbundle", lihuiID = 11700, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "n007", live2DAssetBundleName = "live2d/n007.assetbundle", live2DScale = 2.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20125] = {id = 20125, type = 2, prefabName = "mon_w3_05", prefabNameUI = "mon_w3_05UI", mapPrefabName = "mon_w3_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20126] = {id = 20126, type = 2, prefabName = "mon_w3_06", prefabNameUI = "mon_w3_06UI", mapPrefabName = "mon_w3_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20127] = {id = 20127, type = 3, prefabName = "mon_w3_33", prefabNameUI = "mon_w3_33UI", mapPrefabName = "mon_w3_33m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_33.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20128] = {id = 20128, type = 2, prefabName = "mon_base_boss01_baozhu", prefabNameUI = "mon_base_boss01_baozhuUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss01_baozhu.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20129] = {id = 20129, type = 2, prefabName = "boss_w3_01", prefabNameUI = "boss_w3_01UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w3_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20130] = {id = 20130, type = 2, prefabName = "boss_w3_02", prefabNameUI = "boss_w3_02UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w3_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20131] = {id = 20131, type = 2, prefabName = "boss_w3_03", prefabNameUI = "boss_w3_03UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w3_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.15, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20132] = {id = 20132, type = 2, prefabName = "mon_w3_39", prefabNameUI = "mon_w3_39UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_39.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20133] = {id = 20133, type = 2, prefabName = "mon_w3_39high", prefabNameUI = "mon_w3_39UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_39.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20134] = {id = 20134, type = 2, prefabName = "mon_w3_39low", prefabNameUI = "mon_w3_39UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_39.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20135] = {id = 20135, type = 3, prefabName = "mon_w3_38_01", prefabNameUI = "mon_w3_38_01UI", mapPrefabName = "mon_w3_38_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20136] = {id = 20136, type = 3, prefabName = "char_017_v1", prefabNameUI = "char_017_v1UI", mapPrefabName = "char_017_v1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_017_v1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20137] = {id = 20137, type = 3, prefabName = "mon_w3_38_2", prefabNameUI = "mon_w3_38_2UI", mapPrefabName = "mon_w3_38_2m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38_2.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20138] = {id = 20138, type = 3, prefabName = "mon_w3_38_2_01", prefabNameUI = "mon_w3_38_2_01UI", mapPrefabName = "mon_w3_38_2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38_2_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20139] = {id = 20139, type = 2, prefabName = "mon_base_boss01_baozhu_high", prefabNameUI = "mon_base_boss01_baozhu_highUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_boss01_baozhu.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20140] = {id = 20140, type = 3, prefabName = "char_001_v1", prefabNameUI = "char_001_v1UI", mapPrefabName = "char_001_v1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_001_v1.prefabs.assetbundle", lihuiID = 12353, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001_v1", live2DAssetBundleName = "live2d/char001_v1.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20141] = {id = 20141, type = 1, prefabName = "char_065Boss", prefabNameUI = "char_065UI", mapPrefabName = "char_065m", yardPrefabName = "char_065y", dormPrefabName = "char_065d", assetBundleName = "characters/char_065.prefabs.assetbundle", lihuiID = 10772, headID = 11656, littleHeadID = 11656, DiamondHeadID = 11647, bustID = 11665, bigbustID = 11674, skillHeadID = 11638, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[20142] = {id = 20142, type = 3, prefabName = "n007", prefabNameUI = "n007UI", mapPrefabName = "n007", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n007.prefabs.assetbundle", lihuiID = 11700, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "n007", live2DAssetBundleName = "live2d/n007.assetbundle", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20143] = {id = 20143, type = 2, prefabName = "boss_w3_03", prefabNameUI = "boss_w3_03mUI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w3_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.15, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20144] = {id = 20144, type = 1, prefabName = "char_030", prefabNameUI = "char_030UI", mapPrefabName = "char_030m", yardPrefabName = "char_030y", dormPrefabName = "char_030d", assetBundleName = "characters/char_030.prefabs.assetbundle", lihuiID = 10748, headID = 10850, littleHeadID = 10850, DiamondHeadID = 10816, bustID = 10884, bigbustID = 10918, skillHeadID = 10782, drawShowID = 12500, battleEmotion = "1", live2DPrefabName = "char030", live2DAssetBundleName = "live2d/char030.assetbundle", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[20145] = {id = 20145, type = 2, prefabName = "mon_base_05", prefabNameUI = "mon_base_05UI", mapPrefabName = "mon_base_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20146] = {id = 20146, type = 2, prefabName = "mon_base_06", prefabNameUI = "mon_base_06UI", mapPrefabName = "mon_base_06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20147] = {id = 20147, type = 2, prefabName = "mon_base_07", prefabNameUI = "mon_base_07UI", mapPrefabName = "mon_base_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20148] = {id = 20148, type = 2, prefabName = "mon_base_08", prefabNameUI = "mon_base_08UI", mapPrefabName = "mon_base_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20149] = {id = 20149, type = 2, prefabName = "mon_base_01", prefabNameUI = "mon_base_01UI", mapPrefabName = "mon_base_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20150] = {id = 20150, type = 2, prefabName = "mon_base_02", prefabNameUI = "mon_base_02UI", mapPrefabName = "mon_base_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20151] = {id = 20151, type = 2, prefabName = "mon_base_03", prefabNameUI = "mon_base_03UI", mapPrefabName = "mon_base_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20152] = {id = 20152, type = 2, prefabName = "mon_base_04", prefabNameUI = "mon_base_04UI", mapPrefabName = "mon_base_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20153] = {id = 20153, type = 2, prefabName = "mon_base_09", prefabNameUI = "mon_base_09UI", mapPrefabName = "mon_base_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20154] = {id = 20154, type = 2, prefabName = "mon_fs_01", prefabNameUI = "mon_fs_01UI", mapPrefabName = "mon_fs_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_fs_01.prefabs.assetbundle", lihuiID = 0, headID = 10196, littleHeadID = 10196, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[20155] = {id = 20155, type = 2, prefabName = "boss_w4_01", prefabNameUI = "boss_w4_01UI", mapPrefabName = "", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w4_01.prefabs.assetbundle", lihuiID = 11701, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w4", live2DAssetBundleName = "live2d/boss_w4.assetbundle", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20156] = {id = 20156, type = 3, prefabName = "char_001_v1", prefabNameUI = "char_001_v1UI", mapPrefabName = "char_001_v1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_001_v1.prefabs.assetbundle", lihuiID = 12353, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char001_v1", live2DAssetBundleName = "live2d/char001_v1.assetbundle", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20157] = {id = 20157, type = 2, prefabName = "mon_base_010", prefabNameUI = "mon_base_010UI", mapPrefabName = "mon_base_010m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_010.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20158] = {id = 20158, type = 2, prefabName = "mon_base_011", prefabNameUI = "mon_base_011UI", mapPrefabName = "mon_base_011m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_011.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20159] = {id = 20159, type = 2, prefabName = "mon_base_012", prefabNameUI = "mon_base_012UI", mapPrefabName = "mon_base_012m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_012.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20160] = {id = 20160, type = 2, prefabName = "mon_base_013", prefabNameUI = "mon_base_013UI", mapPrefabName = "mon_base_013m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_013.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20161] = {id = 20161, type = 2, prefabName = "mon_base_014", prefabNameUI = "mon_base_014UI", mapPrefabName = "mon_base_014m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_014.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20162] = {id = 20162, type = 2, prefabName = "mon_base_015", prefabNameUI = "mon_base_015UI", mapPrefabName = "mon_base_015m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_015.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20163] = {id = 20163, type = 2, prefabName = "mon_base_016", prefabNameUI = "mon_base_016UI", mapPrefabName = "mon_base_016m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_016.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20164] = {id = 20164, type = 2, prefabName = "mon_base_017", prefabNameUI = "mon_base_017UI", mapPrefabName = "mon_base_017m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_base_017.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20165] = {id = 20165, type = 1, prefabName = "char_017", prefabNameUI = "char_017UI", mapPrefabName = "char_017m", yardPrefabName = "char_017y", dormPrefabName = "char_017d", assetBundleName = "characters/char_017.prefabs.assetbundle", lihuiID = 10111, headID = 0, littleHeadID = 0, DiamondHeadID = 12346, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char017", live2DAssetBundleName = "live2d/char017.assetbundle", live2DScale = 1, photoScale = 1, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[20166] = {id = 20166, type = 2, prefabName = "mon_sum01", prefabNameUI = "mon_sum01UI", mapPrefabName = "mon_sum01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20167] = {id = 20167, type = 2, prefabName = "mon_sum02", prefabNameUI = "mon_sum02UI", mapPrefabName = "mon_sum02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20168] = {id = 20168, type = 2, prefabName = "mon_sum03", prefabNameUI = "mon_sum03UI", mapPrefabName = "mon_sum03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20169] = {id = 20169, type = 2, prefabName = "mon_sum04", prefabNameUI = "mon_sum04UI", mapPrefabName = "mon_sum04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20170] = {id = 20170, type = 2, prefabName = "mon_sum05", prefabNameUI = "mon_sum05UI", mapPrefabName = "mon_sum05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20171] = {id = 20171, type = 2, prefabName = "mon_sum06", prefabNameUI = "mon_sum06UI", mapPrefabName = "mon_sum06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20172] = {id = 20172, type = 2, prefabName = "mon_sum07", prefabNameUI = "mon_sum07UI", mapPrefabName = "mon_sum07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20173] = {id = 20173, type = 2, prefabName = "mon_sum08", prefabNameUI = "mon_sum08UI", mapPrefabName = "mon_sum08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum08.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20174] = {id = 20174, type = 2, prefabName = "mon_sum09", prefabNameUI = "mon_sum09UI", mapPrefabName = "mon_sum09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_sum09.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20175] = {id = 20175, type = 2, prefabName = "mon_hal01", prefabNameUI = "mon_hal01UI", mapPrefabName = "mon_hal01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_hal01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20176] = {id = 20176, type = 2, prefabName = "mon_hal02", prefabNameUI = "mon_hal02UI", mapPrefabName = "mon_hal02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_hal02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 2}
, 
[20177] = {id = 20177, type = 2, prefabName = "mon_hal03", prefabNameUI = "mon_hal03UI", mapPrefabName = "mon_hal03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_hal03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20178] = {id = 20178, type = 2, prefabName = "mon_hal04", prefabNameUI = "mon_hal04UI", mapPrefabName = "mon_hal04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_hal04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20179] = {id = 20179, type = 2, prefabName = "mon_chrs01", prefabNameUI = "mon_chrs01UI", mapPrefabName = "mon_chrs01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20180] = {id = 20180, type = 2, prefabName = "mon_chrs02", prefabNameUI = "mon_chrs02UI", mapPrefabName = "mon_chrs02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20181] = {id = 20181, type = 2, prefabName = "mon_chrs03", prefabNameUI = "mon_chrs03UI", mapPrefabName = "mon_chrs03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20182] = {id = 20182, type = 2, prefabName = "mon_chrs04", prefabNameUI = "mon_chrs04UI", mapPrefabName = "mon_chrs04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20183] = {id = 20183, type = 2, prefabName = "mon_chrs05", prefabNameUI = "mon_chrs05UI", mapPrefabName = "mon_chrs05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs05.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20184] = {id = 20184, type = 2, prefabName = "mon_chrs06", prefabNameUI = "mon_chrs06UI", mapPrefabName = "mon_chrs06m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs06.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20185] = {id = 20185, type = 2, prefabName = "mon_chrs07", prefabNameUI = "mon_chrs07UI", mapPrefabName = "mon_chrs07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chrs07.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20186] = {id = 20186, type = 2, prefabName = "mon_chun01", prefabNameUI = "mon_chun01UI", mapPrefabName = "mon_chun01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chun01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20187] = {id = 20187, type = 2, prefabName = "mon_chun03", prefabNameUI = "mon_chun03UI", mapPrefabName = "mon_chun03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chun03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20188] = {id = 20188, type = 2, prefabName = "mon_chun02", prefabNameUI = "mon_chun02UI", mapPrefabName = "mon_chun02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_chun02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20189] = {id = 20189, type = 2, prefabName = "boss_chun01", prefabNameUI = "boss_chun01UI", mapPrefabName = "boss_chun01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_chun01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20190] = {id = 20190, type = 2, prefabName = "boss_chun02", prefabNameUI = "boss_chun02UI", mapPrefabName = "boss_chun02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_chun02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20191] = {id = 20191, type = 2, prefabName = "boss_chun03", prefabNameUI = "boss_chun03UI", mapPrefabName = "boss_chun03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_chun03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20192] = {id = 20192, type = 2, prefabName = "mon_vlt01", prefabNameUI = "mon_vlt01UI", mapPrefabName = "mon_vlt01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_vlt01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20193] = {id = 20193, type = 2, prefabName = "mon_vlt02", prefabNameUI = "mon_vlt02UI", mapPrefabName = "mon_vlt02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_vlt02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20194] = {id = 20194, type = 2, prefabName = "mon_vlt03", prefabNameUI = "mon_vlt03UI", mapPrefabName = "mon_vlt03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_vlt03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20195] = {id = 20195, type = 2, prefabName = "mon_vlt04", prefabNameUI = "mon_vlt04UI", mapPrefabName = "mon_vlt04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_vlt04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20196] = {id = 20196, type = 2, prefabName = "boss_w6_4", prefabNameUI = "boss_w6_4UI", mapPrefabName = "boss_w6_4m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w6_4.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20197] = {id = 20197, type = 2, prefabName = "mon_w3_15", prefabNameUI = "mon_w3_15UI", mapPrefabName = "mon_w3_15m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_15.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20198] = {id = 20198, type = 2, prefabName = "mon_w3_16", prefabNameUI = "mon_w3_16UI", mapPrefabName = "mon_w3_16m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_16.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20199] = {id = 20199, type = 2, prefabName = "mon_af01", prefabNameUI = "mon_af01UI", mapPrefabName = "mon_af01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_af01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20200] = {id = 20200, type = 2, prefabName = "mon_w3_14", prefabNameUI = "mon_w3_14UI", mapPrefabName = "mon_w3_14m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_14.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20201] = {id = 20201, type = 2, prefabName = "mon_w3_52", prefabNameUI = "mon_w3_52UI", mapPrefabName = "mon_w3_52m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_52.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20202] = {id = 20202, type = 2, prefabName = "mon_w3_53", prefabNameUI = "mon_w3_53UI", mapPrefabName = "mon_w3_53m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_53.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20203] = {id = 20203, type = 2, prefabName = "mon_w3_54", prefabNameUI = "mon_w3_54UI", mapPrefabName = "mon_w3_54m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_54.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20204] = {id = 20204, type = 2, prefabName = "mon_w6_02", prefabNameUI = "mon_w6_02UI", mapPrefabName = "mon_w6_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w6_02.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20205] = {id = 20205, type = 2, prefabName = "mon_w6_03", prefabNameUI = "mon_w6_03UI", mapPrefabName = "mon_w6_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w6_03.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20206] = {id = 20206, type = 2, prefabName = "mon_w3_12", prefabNameUI = "mon_w3_12UI", mapPrefabName = "mon_w3_12m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_12.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20207] = {id = 20207, type = 2, prefabName = "mon_w3_13", prefabNameUI = "mon_w3_13UI", mapPrefabName = "mon_w3_13m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_13.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20208] = {id = 20208, type = 2, prefabName = "boss_w6_4", prefabNameUI = "boss_w6_4UI", mapPrefabName = "boss_w6_4m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w6_4.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20209] = {id = 20209, type = 2, prefabName = "mon_w3_40", prefabNameUI = "mon_w3_40UI", mapPrefabName = "mon_w3_40m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_40.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20210] = {id = 20210, type = 3, prefabName = "mon_w3_m01", prefabNameUI = "mon_w3_m01UI", mapPrefabName = "mon_w3_m01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_m01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.6, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20211] = {id = 20211, type = 3, prefabName = "boss_w6_1", prefabNameUI = "boss_w6_1UI", mapPrefabName = "boss_w6_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w6_1.prefabs.assetbundle", lihuiID = 12230, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "boss_w3_1", live2DAssetBundleName = "live2d/boss_w3_1.assetbundle", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20212] = {id = 20212, type = 3, prefabName = "boss_w6_2", prefabNameUI = "boss_w6_2UI", mapPrefabName = "boss_w6_2m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w6_2.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20213] = {id = 20213, type = 3, prefabName = "mon_w6_04", prefabNameUI = "mon_w6_04UI", mapPrefabName = "mon_w6_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w6_04.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20214] = {id = 20214, type = 3, prefabName = "boss_w6_3", prefabNameUI = "boss_w6_3UI", mapPrefabName = "boss_w6_3m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w6_3.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20215] = {id = 20215, type = 2, prefabName = "char_023", prefabNameUI = "char_023UI", mapPrefabName = "char_023m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/char_023.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[20216] = {id = 20216, type = 2, prefabName = "mon_w3_40_p2", prefabNameUI = "mon_w3_40_p2UI", mapPrefabName = "mon_w3_40_p2m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_40_p2.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50001] = {id = 50001, type = 2, prefabName = "mon_t1_04s", prefabNameUI = "mon_t1_04UI", mapPrefabName = "mon_t1_04m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_04s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50002] = {id = 50002, type = 2, prefabName = "mon_t1_08s", prefabNameUI = "mon_t1_08UI", mapPrefabName = "mon_t1_08m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_08s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50003] = {id = 50003, type = 2, prefabName = "mon_t2_01s", prefabNameUI = "mon_t2_01UI", mapPrefabName = "mon_t2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t2_01s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50004] = {id = 50004, type = 2, prefabName = "mon_t1_28s", prefabNameUI = "mon_t1_28UI", mapPrefabName = "mon_t1_28m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_28s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50005] = {id = 50005, type = 2, prefabName = "mon_t1_07s", prefabNameUI = "mon_t1_07UI", mapPrefabName = "mon_t1_07m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_07s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50006] = {id = 50006, type = 3, prefabName = "mon_t1_27s", prefabNameUI = "mon_t1_27UI", mapPrefabName = "mon_t1_27m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_27s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 2}
, 
[50007] = {id = 50007, type = 2, prefabName = "mon_t1_09s", prefabNameUI = "mon_t1_09UI", mapPrefabName = "mon_t1_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_t1_09s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50008] = {id = 50008, type = 2, prefabName = "mon_w1_39s", prefabNameUI = "mon_w1_39UI", mapPrefabName = "mon_w1_39m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_39s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50009] = {id = 50009, type = 2, prefabName = "mon_w1_17s", prefabNameUI = "mon_w1_17UI", mapPrefabName = "mon_w1_17m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_17s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50010] = {id = 50010, type = 2, prefabName = "mon_w1_25s", prefabNameUI = "mon_w1_25UI", mapPrefabName = "mon_w1_25m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_25s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50011] = {id = 50011, type = 3, prefabName = "mon_w1_38s", prefabNameUI = "mon_w1_38UI", mapPrefabName = "mon_w1_38m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_38s.prefabs.assetbundle", lihuiID = 10202, headID = 10029, littleHeadID = 10029, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50012] = {id = 50012, type = 2, prefabName = "mon_w1_49s", prefabNameUI = "mon_w1_49UI", mapPrefabName = "mon_w1_49m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_49s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50013] = {id = 50013, type = 2, prefabName = "mon_w1_47s", prefabNameUI = "mon_w1_47UI", mapPrefabName = "mon_w1_47m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w1_47s.prefabs.assetbundle", lihuiID = 10615, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50014] = {id = 50014, type = 2, prefabName = "mon_w2_02s", prefabNameUI = "mon_w2_02UI", mapPrefabName = "mon_w2_02m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_02s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50015] = {id = 50015, type = 2, prefabName = "mon_w2_03s", prefabNameUI = "mon_w2_03UI", mapPrefabName = "mon_w2_03m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_03s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50016] = {id = 50016, type = 2, prefabName = "mon_w2_09s", prefabNameUI = "mon_w2_09UI", mapPrefabName = "mon_w2_09m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_09s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50017] = {id = 50017, type = 2, prefabName = "mon_w2_05s", prefabNameUI = "mon_w2_05UI", mapPrefabName = "mon_w2_05m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_05s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50018] = {id = 50018, type = 2, prefabName = "mon_w2_11s", prefabNameUI = "mon_w2_11UI", mapPrefabName = "mon_w2_11m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_11s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50019] = {id = 50019, type = 2, prefabName = "mon_w2_15s", prefabNameUI = "mon_w2_15UI", mapPrefabName = "mon_w2_15m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_15s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50020] = {id = 50020, type = 2, prefabName = "boss_w2_01s", prefabNameUI = "boss_w2_01UI", mapPrefabName = "boss_w2_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/boss_w2_01s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50021] = {id = 50021, type = 2, prefabName = "mon_w2_10s", prefabNameUI = "mon_w2_10UI", mapPrefabName = "mon_w2_10m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w2_10s.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50022] = {id = 50022, type = 2, prefabName = "mon_w3_36_1", prefabNameUI = "mon_w3_36_1UI", mapPrefabName = "mon_w3_36_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_36_1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50023] = {id = 50023, type = 2, prefabName = "mon_w3_36_2", prefabNameUI = "mon_w3_36_2UI", mapPrefabName = "mon_w3_36_2m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_36_2.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50024] = {id = 50024, type = 3, prefabName = "mon_w3_37_1", prefabNameUI = "mon_w3_37_1UI", mapPrefabName = "mon_w3_37_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_37_1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50025] = {id = 50025, type = 3, prefabName = "mon_w3_38_1", prefabNameUI = "mon_w3_38_1UI", mapPrefabName = "mon_w3_38_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38_1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50026] = {id = 50026, type = 3, prefabName = "mon_w3_38_1_01", prefabNameUI = "mon_w3_38_1_01UI", mapPrefabName = "mon_w3_38_1_01m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w3_38_1_01.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 1, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50027] = {id = 50027, type = 2, prefabName = "mon_w4_03_1", prefabNameUI = "mon_w4_03_1UI", mapPrefabName = "mon_w4_03_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_03_1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.7, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[50028] = {id = 50028, type = 2, prefabName = "mon_w4_04_1", prefabNameUI = "mon_w4_04_1UI", mapPrefabName = "mon_w4_04_1m", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/mon_w4_04_1.prefabs.assetbundle", lihuiID = 0, headID = 10209, littleHeadID = 10209, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 0.5, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 0}
, 
[60001] = {id = 60001, type = 5, prefabName = "char_003", prefabNameUI = "char_003UI", mapPrefabName = "char_003m", yardPrefabName = "char_003y", dormPrefabName = "char_003d", assetBundleName = "characters/char_003.prefabs.assetbundle", lihuiID = 11968, headID = 12028, littleHeadID = 12028, DiamondHeadID = 12008, bustID = 12048, bigbustID = 12068, skillHeadID = 11988, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char003_v1", live2DAssetBundleName = "live2d/char003_v1.assetbundle", live2DScale = 2.6, photoScale = 2.8, 
photoLocation = {-78, -87}
, SteadyState = 1}
, 
[60002] = {id = 60002, type = 5, prefabName = "char_037_v1", prefabNameUI = "char_037_v1UI", mapPrefabName = "char_037_v1m", yardPrefabName = "char_037_v1y", dormPrefabName = "char_037_v1d", assetBundleName = "characters/char_037_v1.prefabs.assetbundle", lihuiID = 11973, headID = 12033, littleHeadID = 12033, DiamondHeadID = 12013, bustID = 12053, bigbustID = 12073, skillHeadID = 11993, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char037_v1_hx", live2DAssetBundleName = "live2d/char037_v1_hx.assetbundle", live2DScale = 2.4, photoScale = 2.8, 
photoLocation = {14, -197}
, SteadyState = 1}
, 
[60003] = {id = 60003, type = 5, prefabName = "char_050_v1", prefabNameUI = "char_050_v1UI", mapPrefabName = "char_050_v1m", yardPrefabName = "char_050_v1y", dormPrefabName = "char_050_v1d", assetBundleName = "characters/char_050_v1.prefabs.assetbundle", lihuiID = 11974, headID = 12034, littleHeadID = 12034, DiamondHeadID = 12014, bustID = 12054, bigbustID = 12074, skillHeadID = 11994, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char050_v1", live2DAssetBundleName = "live2d/char050_v1.assetbundle", live2DScale = 2.8, photoScale = 2.8, 
photoLocation = {0, -130}
, SteadyState = 1}
, 
[60004] = {id = 60004, type = 5, prefabName = "char_053_v1", prefabNameUI = "char_053_v1UI", mapPrefabName = "char_053_v1m", yardPrefabName = "char_053_v1y", dormPrefabName = "char_053_v1d", assetBundleName = "characters/char_053_v1.prefabs.assetbundle", lihuiID = 11975, headID = 12035, littleHeadID = 12035, DiamondHeadID = 12015, bustID = 12055, bigbustID = 12075, skillHeadID = 11995, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char053_v1", live2DAssetBundleName = "live2d/char053_v1.assetbundle", live2DScale = 2.2, photoScale = 2.6, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60005] = {id = 60005, type = 5, prefabName = "char_003_summon", prefabNameUI = "char_003_summonUI", mapPrefabName = "char_003_summonm", yardPrefabName = "char_003_summony", dormPrefabName = "char_003_summond", assetBundleName = "characters/char_003_summon.prefabs.assetbundle", lihuiID = 10772, headID = 11654, littleHeadID = 11654, DiamondHeadID = 11645, bustID = 11663, bigbustID = 11672, skillHeadID = 11636, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60006] = {id = 60006, type = 5, prefabName = "char_012", prefabNameUI = "char_012UI", mapPrefabName = "char_012m", yardPrefabName = "char_012y", dormPrefabName = "char_012d", assetBundleName = "characters/char_012.prefabs.assetbundle", lihuiID = 11960, headID = 12020, littleHeadID = 12020, DiamondHeadID = 12000, bustID = 12040, bigbustID = 12060, skillHeadID = 11980, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char012_break", live2DAssetBundleName = "live2d/char012_break.assetbundle", live2DScale = 3.8, photoScale = 3.8, 
photoLocation = {137, -70}
, SteadyState = 1}
, 
[60007] = {id = 60007, type = 5, prefabName = "char_015", prefabNameUI = "char_015UI", mapPrefabName = "char_015m", yardPrefabName = "char_015y", dormPrefabName = "char_015d", assetBundleName = "characters/char_015.prefabs.assetbundle", lihuiID = 11961, headID = 12021, littleHeadID = 12021, DiamondHeadID = 12001, bustID = 12041, bigbustID = 12061, skillHeadID = 11981, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 3.2, 
photoLocation = {103, -82}
, SteadyState = 1}
, 
[60008] = {id = 60008, type = 5, prefabName = "char_002", prefabNameUI = "char_002UI", mapPrefabName = "char_002m", yardPrefabName = "char_002y", dormPrefabName = "char_002d", assetBundleName = "characters/char_002.prefabs.assetbundle", lihuiID = 11959, headID = 12019, littleHeadID = 12019, DiamondHeadID = 11999, bustID = 12039, bigbustID = 12059, skillHeadID = 11979, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char002_break", live2DAssetBundleName = "live2d/char002_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-25, -11}
, SteadyState = 1}
, 
[60009] = {id = 60009, type = 5, prefabName = "char_027", prefabNameUI = "char_027UI", mapPrefabName = "char_027m", yardPrefabName = "char_027y", dormPrefabName = "char_027d", assetBundleName = "characters/char_027.prefabs.assetbundle", lihuiID = 11964, headID = 12024, littleHeadID = 12024, DiamondHeadID = 12004, bustID = 12044, bigbustID = 12064, skillHeadID = 11984, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char027_break", live2DAssetBundleName = "live2d/char027_break.assetbundle", live2DScale = 3, photoScale = 2.8, 
photoLocation = {-87, -6}
, SteadyState = 1}
, 
[60010] = {id = 60010, type = 5, prefabName = "char_024", prefabNameUI = "char_024UI", mapPrefabName = "char_024m", yardPrefabName = "char_024y", dormPrefabName = "char_024d", assetBundleName = "characters/char_024.prefabs.assetbundle", lihuiID = 11963, headID = 12023, littleHeadID = 12023, DiamondHeadID = 12003, bustID = 12043, bigbustID = 12063, skillHeadID = 11983, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char024_break", live2DAssetBundleName = "live2d/char024_break.assetbundle", live2DScale = 3.3, photoScale = 3, 
photoLocation = {-103, -83}
, SteadyState = 1}
, 
[60011] = {id = 60011, type = 5, prefabName = "char_022", prefabNameUI = "char_022UI", mapPrefabName = "char_022m", yardPrefabName = "char_022y", dormPrefabName = "char_022d", assetBundleName = "characters/char_022.prefabs.assetbundle", lihuiID = 11962, headID = 12022, littleHeadID = 12022, DiamondHeadID = 12002, bustID = 12042, bigbustID = 12062, skillHeadID = 11982, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char022_break", live2DAssetBundleName = "live2d/char022_break.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-31, -120}
, SteadyState = 1}
, 
[60012] = {id = 60012, type = 5, prefabName = "char_037", prefabNameUI = "char_037UI", mapPrefabName = "char_037m", yardPrefabName = "char_037y", dormPrefabName = "char_037d", assetBundleName = "characters/char_037.prefabs.assetbundle", lihuiID = 11965, headID = 12025, littleHeadID = 12025, DiamondHeadID = 12005, bustID = 12045, bigbustID = 12065, skillHeadID = 11985, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char037_Break_hx", live2DAssetBundleName = "live2d/char037_break_hx.assetbundle", live2DScale = 2.9, photoScale = 3, 
photoLocation = {-2, -78}
, SteadyState = 1}
, 
[60013] = {id = 60013, type = 5, prefabName = "char_043", prefabNameUI = "char_043UI", mapPrefabName = "char_043m", yardPrefabName = "char_043y", dormPrefabName = "char_043d", assetBundleName = "characters/char_043.prefabs.assetbundle", lihuiID = 11966, headID = 12026, littleHeadID = 12026, DiamondHeadID = 12006, bustID = 12046, bigbustID = 12066, skillHeadID = 11986, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char043_break_hx", live2DAssetBundleName = "live2d/char043_break_hx.assetbundle", live2DScale = 3.8, photoScale = 3.2, 
photoLocation = {-132, -202}
, SteadyState = 1}
, 
[60014] = {id = 60014, type = 5, prefabName = "char_056", prefabNameUI = "char_056UI", mapPrefabName = "char_056m", yardPrefabName = "char_056y", dormPrefabName = "char_056d", assetBundleName = "characters/char_056.prefabs.assetbundle", lihuiID = 11967, headID = 12027, littleHeadID = 12027, DiamondHeadID = 12007, bustID = 12047, bigbustID = 12067, skillHeadID = 11987, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60015] = {id = 60015, type = 5, prefabName = "ActorBattle2", prefabNameUI = "ActorBattleUI2", mapPrefabName = "Actor", yardPrefabName = "ActorBattley", dormPrefabName = "ActorBattled", assetBundleName = "characters/char_player1.prefabs.assetbundle", lihuiID = 10017, headID = 10001, littleHeadID = 10001, DiamondHeadID = 10266, bustID = 10009, bigbustID = 10297, skillHeadID = 10351, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "role", live2DAssetBundleName = "live2d/player1.assetbundle", live2DScale = 3.4, photoScale = 3, 
photoLocation = {-15, -136}
, SteadyState = 1}
, 
[60016] = {id = 60016, type = 5, prefabName = "char_054_v1", prefabNameUI = "char_054_v1UI", mapPrefabName = "char_054_v1m", yardPrefabName = "char_054_v1y", dormPrefabName = "char_054_v1d", assetBundleName = "characters/char_054_v1.prefabs.assetbundle", lihuiID = 12248, headID = 12257, littleHeadID = 12257, DiamondHeadID = 12254, bustID = 12260, bigbustID = 12263, skillHeadID = 12251, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char054_v1", live2DAssetBundleName = "live2d/char054_v1.assetbundle", live2DScale = 2.2, photoScale = 2.8, 
photoLocation = {-16, -115}
, SteadyState = 1}
, 
[60017] = {id = 60017, type = 5, prefabName = "char_035_v1", prefabNameUI = "char_035_v1UI", mapPrefabName = "char_035_v1m", yardPrefabName = "char_035_v1y", dormPrefabName = "char_035_v1d", assetBundleName = "characters/char_035_v1.prefabs.assetbundle", lihuiID = 11971, headID = 12031, littleHeadID = 12031, DiamondHeadID = 12011, bustID = 12051, bigbustID = 12071, skillHeadID = 11991, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char035_v1", live2DAssetBundleName = "live2d/char035_v1.assetbundle", live2DScale = 3.7, photoScale = 3.2, 
photoLocation = {-119, 48}
, SteadyState = 1}
, 
[60018] = {id = 60018, type = 5, prefabName = "char_024_v1", prefabNameUI = "char_024_v1UI", mapPrefabName = "char_024_v1m", yardPrefabName = "char_024_v1y", dormPrefabName = "char_024_v1d", assetBundleName = "characters/char_024_v1.prefabs.assetbundle", lihuiID = 12247, headID = 12256, littleHeadID = 12256, DiamondHeadID = 12253, bustID = 12259, bigbustID = 12262, skillHeadID = 12250, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char024_v1", live2DAssetBundleName = "live2d/char024_v1.assetbundle", live2DScale = 3.5, photoScale = 3.5, 
photoLocation = {-35, 14}
, SteadyState = 1}
, 
[60019] = {id = 60019, type = 5, prefabName = "char_015_v1", prefabNameUI = "char_015_v1UI", mapPrefabName = "char_015_v1m", yardPrefabName = "char_015_v1y", dormPrefabName = "char_015_v1d", assetBundleName = "characters/char_015_v1.prefabs.assetbundle", lihuiID = 12246, headID = 12255, littleHeadID = 12255, DiamondHeadID = 12252, bustID = 12258, bigbustID = 12261, skillHeadID = 12249, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char015_v1", live2DAssetBundleName = "live2d/char015_v1.assetbundle", live2DScale = 4, photoScale = 3.5, 
photoLocation = {-13, -32}
, SteadyState = 1}
, 
[60020] = {id = 60020, type = 5, prefabName = "char_024_v1_dragon", prefabNameUI = "char_024_v1UI_dragon", mapPrefabName = "char_024_v1m_dragon", yardPrefabName = "char_024_v1y_dragon", dormPrefabName = "char_024_v1d_dragon", assetBundleName = "characters/char_024_v1_dragon.prefabs.assetbundle", lihuiID = 12247, headID = 12256, littleHeadID = 12256, DiamondHeadID = 12253, bustID = 12259, bigbustID = 12262, skillHeadID = 12250, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60021] = {id = 60021, type = 5, prefabName = "char_014_v1", prefabNameUI = "char_014_v1UI", mapPrefabName = "char_014_v1m", yardPrefabName = "char_014_v1y", dormPrefabName = "char_014_v1d", assetBundleName = "characters/char_014_v1.prefabs.assetbundle", lihuiID = 12713, headID = 12728, littleHeadID = 12728, DiamondHeadID = 12744, bustID = 12760, bigbustID = 12792, skillHeadID = 12776, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char014_v1", live2DAssetBundleName = "live2d/char014_v1.assetbundle", live2DScale = 2.5, photoScale = 3, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60022] = {id = 60022, type = 5, prefabName = "char_023", prefabNameUI = "char_023UI", mapPrefabName = "char_023m", yardPrefabName = "char_023y", dormPrefabName = "char_023d", assetBundleName = "characters/char_023.prefabs.assetbundle", lihuiID = 12714, headID = 12729, littleHeadID = 12729, DiamondHeadID = 12745, bustID = 12761, bigbustID = 12793, skillHeadID = 12777, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.7, 
photoLocation = {40, 0}
, SteadyState = 1}
, 
[60023] = {id = 60023, type = 5, prefabName = "char_034", prefabNameUI = "char_034UI", mapPrefabName = "char_034m", yardPrefabName = "char_034y", dormPrefabName = "char_034d", assetBundleName = "characters/char_034.prefabs.assetbundle", lihuiID = 12715, headID = 12730, littleHeadID = 12730, DiamondHeadID = 12746, bustID = 12762, bigbustID = 12794, skillHeadID = 12778, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char034_break", live2DAssetBundleName = "live2d/char034_break.assetbundle", live2DScale = 3, photoScale = 3.5, 
photoLocation = {-59, -20}
, SteadyState = 1}
, 
[60024] = {id = 60024, type = 5, prefabName = "char_063_v1", prefabNameUI = "char_063_v1UI", mapPrefabName = "char_063_v1m", yardPrefabName = "char_063_v1y", dormPrefabName = "char_063_v1d", assetBundleName = "characters/char_063_v1.prefabs.assetbundle", lihuiID = 12717, headID = 12732, littleHeadID = 12732, DiamondHeadID = 12748, bustID = 12764, bigbustID = 12796, skillHeadID = 12780, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char063_v1", live2DAssetBundleName = "live2d/char063_v1.assetbundle", live2DScale = 3, photoScale = 3.5, 
photoLocation = {0, -150}
, SteadyState = 1}
, 
[60025] = {id = 60025, type = 5, prefabName = "char_065", prefabNameUI = "char_065UI", mapPrefabName = "char_065m", yardPrefabName = "char_065y", dormPrefabName = "char_065d", assetBundleName = "characters/char_065.prefabs.assetbundle", lihuiID = 12718, headID = 12733, littleHeadID = 12733, DiamondHeadID = 12749, bustID = 12765, bigbustID = 12797, skillHeadID = 12781, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char065_break", live2DAssetBundleName = "live2d/char065_break.assetbundle", live2DScale = 3, photoScale = 2.8, 
photoLocation = {-46, 7}
, SteadyState = 1}
, 
[60026] = {id = 60026, type = 5, prefabName = "char_071", prefabNameUI = "char_071UI", mapPrefabName = "char_071m", yardPrefabName = "char_071y", dormPrefabName = "char_071d", assetBundleName = "characters/char_071.prefabs.assetbundle", lihuiID = 12722, headID = 12737, littleHeadID = 12737, DiamondHeadID = 12753, bustID = 12769, bigbustID = 12801, skillHeadID = 12785, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char071_break", live2DAssetBundleName = "live2d/char071_break.assetbundle", live2DScale = 2.8, photoScale = 3.3, 
photoLocation = {-20, -130}
, SteadyState = 1}
, 
[60027] = {id = 60027, type = 5, prefabName = "char_072", prefabNameUI = "char_072UI", mapPrefabName = "char_072m", yardPrefabName = "char_072y", dormPrefabName = "char_072d", assetBundleName = "characters/char_072.prefabs.assetbundle", lihuiID = 12724, headID = 12739, littleHeadID = 12739, DiamondHeadID = 12755, bustID = 12771, bigbustID = 12803, skillHeadID = 12787, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char072_break", live2DAssetBundleName = "live2d/char072_break.assetbundle", live2DScale = 2.8, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60028] = {id = 60028, type = 5, prefabName = "char_055", prefabNameUI = "char_055UI", mapPrefabName = "char_055m", yardPrefabName = "char_055y", dormPrefabName = "char_055d", assetBundleName = "characters/char_055.prefabs.assetbundle", lihuiID = 12955, headID = 12958, littleHeadID = 12958, DiamondHeadID = 12957, bustID = 12959, bigbustID = 12960, skillHeadID = 12956, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 3, 
photoLocation = {15, 29}
, SteadyState = 1}
, 
[60029] = {id = 60029, type = 5, prefabName = "char_061", prefabNameUI = "char_061UI", mapPrefabName = "char_061m", yardPrefabName = "char_061y", dormPrefabName = "char_061d", assetBundleName = "characters/char_061.prefabs.assetbundle", lihuiID = 12961, headID = 12964, littleHeadID = 12964, DiamondHeadID = 12963, bustID = 12965, bigbustID = 12966, skillHeadID = 12962, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {-19, -16}
, SteadyState = 1}
, 
[60030] = {id = 60030, type = 5, prefabName = "char_073", prefabNameUI = "char_073UI", mapPrefabName = "char_073m", yardPrefabName = "char_073y", dormPrefabName = "char_073d", assetBundleName = "characters/char_073.prefabs.assetbundle", lihuiID = 12967, headID = 12970, littleHeadID = 12970, DiamondHeadID = 12969, bustID = 12971, bigbustID = 12972, skillHeadID = 12968, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 3, 
photoLocation = {-19, -44}
, SteadyState = 1}
, 
[60031] = {id = 60031, type = 5, prefabName = "char_063", prefabNameUI = "char_063UI", mapPrefabName = "char_063m", yardPrefabName = "char_063y", dormPrefabName = "char_063d", assetBundleName = "characters/char_063.prefabs.assetbundle", lihuiID = 13037, headID = 13040, littleHeadID = 13040, DiamondHeadID = 13039, bustID = 13041, bigbustID = 13042, skillHeadID = 13038, drawShowID = 12528, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 2.8, photoScale = 3.5, 
photoLocation = {-20, -170}
, SteadyState = 1}
, 
[60032] = {id = 60032, type = 5, prefabName = "char_016_v1", prefabNameUI = "char_016_v1UI", mapPrefabName = "char_016_v1m", yardPrefabName = "char_016_v1y", dormPrefabName = "char_016_v1d", assetBundleName = "characters/char_016_v1.prefabs.assetbundle", lihuiID = 13083, headID = 13086, littleHeadID = 13086, DiamondHeadID = 13085, bustID = 13087, bigbustID = 13088, skillHeadID = 13084, drawShowID = 12488, battleEmotion = "1", live2DPrefabName = "char016_v1", live2DAssetBundleName = "live2d/char016_v1.assetbundle", live2DScale = 3.3, photoScale = 3.2, 
photoLocation = {-56, 37}
, SteadyState = 1}
, 
[60033] = {id = 60033, type = 5, prefabName = "char_012_v1", prefabNameUI = "char_012_v1UI", mapPrefabName = "char_012_v1m", yardPrefabName = "char_012_v1y", dormPrefabName = "char_012_v1d", assetBundleName = "characters/char_012_v1.prefabs.assetbundle", lihuiID = 11970, headID = 12030, littleHeadID = 12030, DiamondHeadID = 12010, bustID = 12050, bigbustID = 12070, skillHeadID = 11990, drawShowID = 12485, battleEmotion = "1", live2DPrefabName = "char012_v1", live2DAssetBundleName = "live2d/char012_v1.assetbundle", live2DScale = 3.4, photoScale = 2.7, 
photoLocation = {0, 80}
, SteadyState = 1}
, 
[60034] = {id = 60034, type = 5, prefabName = "char_036_v1", prefabNameUI = "char_036_v1UI", mapPrefabName = "char_036_v1m", yardPrefabName = "char_036_v1y", dormPrefabName = "char_036_v1d", assetBundleName = "characters/char_036_v1.prefabs.assetbundle", lihuiID = 11972, headID = 12032, littleHeadID = 12032, DiamondHeadID = 12012, bustID = 12052, bigbustID = 12072, skillHeadID = 11992, drawShowID = 12506, battleEmotion = "1", live2DPrefabName = "char036_v1", live2DAssetBundleName = "live2d/char036_v1.assetbundle", live2DScale = 2.3, photoScale = 2.8, 
photoLocation = {-30, 80}
, SteadyState = 1}
, 
[60035] = {id = 60035, type = 5, prefabName = "char_081", prefabNameUI = "char_081UI", mapPrefabName = "char_081m", yardPrefabName = "char_081y", dormPrefabName = "char_081d", assetBundleName = "characters/char_081.prefabs.assetbundle", lihuiID = 13598, headID = 13601, littleHeadID = 13601, DiamondHeadID = 13600, bustID = 13602, bigbustID = 13603, skillHeadID = 13599, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char081_break", live2DAssetBundleName = "live2d/char081_break.assetbundle", live2DScale = 2.95, photoScale = 3.2, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60036] = {id = 60036, type = 5, prefabName = "char_078", prefabNameUI = "char_078UI", mapPrefabName = "char_078m", yardPrefabName = "char_078y", dormPrefabName = "char_078d", assetBundleName = "characters/char_078.prefabs.assetbundle", lihuiID = 13315, headID = 13318, littleHeadID = 13318, DiamondHeadID = 13317, bustID = 13319, bigbustID = 13320, skillHeadID = 13316, drawShowID = 13300, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.7, 
photoLocation = {-50, -18}
, SteadyState = 1}
, 
[60037] = {id = 60037, type = 5, prefabName = "char_079", prefabNameUI = "char_079UI", mapPrefabName = "char_079m", yardPrefabName = "char_079y", dormPrefabName = "char_079d", assetBundleName = "characters/char_079.prefabs.assetbundle", lihuiID = 13321, headID = 13324, littleHeadID = 13324, DiamondHeadID = 13323, bustID = 13325, bigbustID = 13326, skillHeadID = 13322, drawShowID = 13301, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.7, 
photoLocation = {-70, 30}
, SteadyState = 1}
, 
[60038] = {id = 60038, type = 4, prefabName = "char_012_v1", prefabNameUI = "char_012_v1UI", mapPrefabName = "char_012_v1m", yardPrefabName = "char_012_v1y", dormPrefabName = "char_012_v1d", assetBundleName = "characters/char_012_v1.prefabs.assetbundle", lihuiID = 11970, headID = 12030, littleHeadID = 12030, DiamondHeadID = 12010, bustID = 12050, bigbustID = 12070, skillHeadID = 11990, drawShowID = 12485, battleEmotion = "1", live2DPrefabName = "char012_v1_noback", live2DAssetBundleName = "live2d/char012_v1_noback.assetbundle", live2DScale = 3.2, photoScale = 2.7, 
photoLocation = {0, 80}
, SteadyState = 1}
, 
[60039] = {id = 60039, type = 4, prefabName = "char_053_v1", prefabNameUI = "char_053_v1UI", mapPrefabName = "char_053_v1m", yardPrefabName = "char_053_v1y", dormPrefabName = "char_053_v1d", assetBundleName = "characters/char_053_v1.prefabs.assetbundle", lihuiID = 11975, headID = 12035, littleHeadID = 12035, DiamondHeadID = 12015, bustID = 12055, bigbustID = 12075, skillHeadID = 11995, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char053_v1_noback", live2DAssetBundleName = "live2d/char053_v1_noback.assetbundle", live2DScale = 2, photoScale = 2.6, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60040] = {id = 60040, type = 4, prefabName = "char_054", prefabNameUI = "char_054UI", mapPrefabName = "char_054m", yardPrefabName = "char_054y", dormPrefabName = "char_054d", assetBundleName = "characters/char_054.prefabs.assetbundle", lihuiID = 12091, headID = 11530, littleHeadID = 11530, DiamondHeadID = 11522, bustID = 11538, bigbustID = 11546, skillHeadID = 11514, drawShowID = 12520, battleEmotion = "1", live2DPrefabName = "char054_noback", live2DAssetBundleName = "live2d/char054_noback.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-60, -140}
, SteadyState = 1}
, 
[60041] = {id = 60041, type = 4, prefabName = "char_079", prefabNameUI = "char_079UI", mapPrefabName = "char_079m", yardPrefabName = "char_079y", dormPrefabName = "char_079d", assetBundleName = "characters/char_079.prefabs.assetbundle", lihuiID = 13294, headID = 13297, littleHeadID = 13297, DiamondHeadID = 13296, bustID = 13298, bigbustID = 13299, skillHeadID = 13295, drawShowID = 13301, battleEmotion = "1", live2DPrefabName = "char079_noback", live2DAssetBundleName = "live2d/char079_noback.assetbundle", live2DScale = 2.8, photoScale = 3, 
photoLocation = {40, -152}
, SteadyState = 1}
, 
[60042] = {id = 60042, type = 4, prefabName = "char_036_v1", prefabNameUI = "char_036_v1UI", mapPrefabName = "char_036_v1m", yardPrefabName = "char_036_v1y", dormPrefabName = "char_036_v1d", assetBundleName = "characters/char_036_v1.prefabs.assetbundle", lihuiID = 11972, headID = 12032, littleHeadID = 12032, DiamondHeadID = 12012, bustID = 12052, bigbustID = 12072, skillHeadID = 11992, drawShowID = 12506, battleEmotion = "1", live2DPrefabName = "char036_v1_noback", live2DAssetBundleName = "live2d/char036_v1_noback.assetbundle", live2DScale = 2.5, photoScale = 2.8, 
photoLocation = {-30, 80}
, SteadyState = 1}
, 
[60043] = {id = 60043, type = 4, prefabName = "n014", prefabNameUI = "n014", mapPrefabName = "n014", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n014.prefabs.assetbundle", lihuiID = 13390, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.8, 
photoLocation = {0, -125}
, SteadyState = 0}
, 
[60044] = {id = 60044, type = 4, prefabName = "n015", prefabNameUI = "n015", mapPrefabName = "n015", yardPrefabName = "", dormPrefabName = "", assetBundleName = "characters/n015.prefabs.assetbundle", lihuiID = 13391, headID = 0, littleHeadID = 0, DiamondHeadID = 0, bustID = 0, bigbustID = 0, skillHeadID = 0, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 3, 
photoLocation = {26, -105}
, SteadyState = 0}
, 
[60045] = {id = 60045, type = 5, prefabName = "char_055_v1", prefabNameUI = "char_055_v1UI", mapPrefabName = "char_055_v1m", yardPrefabName = "char_055_v1y", dormPrefabName = "char_055_v1d", assetBundleName = "characters/char_055_v1.prefabs.assetbundle", lihuiID = 13478, headID = 13481, littleHeadID = 13481, DiamondHeadID = 13480, bustID = 13482, bigbustID = 13483, skillHeadID = 13479, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char055_v1", live2DAssetBundleName = "live2d/char055_v1.assetbundle", live2DScale = 3.5, photoScale = 4.5, 
photoLocation = {-77, -19}
, SteadyState = 1}
, 
[60046] = {id = 60046, type = 5, prefabName = "char_089", prefabNameUI = "char_089UI", mapPrefabName = "char_089m", yardPrefabName = "char_089y", dormPrefabName = "char_089d", assetBundleName = "characters/char_089.prefabs.assetbundle", lihuiID = 13560, headID = 13563, littleHeadID = 13563, DiamondHeadID = 13562, bustID = 13564, bigbustID = 13565, skillHeadID = 13561, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char089_break", live2DAssetBundleName = "live2d/char089_break.assetbundle", live2DScale = 3.8, photoScale = 3.7, 
photoLocation = {-61, 92}
, SteadyState = 1}
, 
[60047] = {id = 60047, type = 5, prefabName = "char_090", prefabNameUI = "char_090UI", mapPrefabName = "char_090m", yardPrefabName = "char_090y", dormPrefabName = "char_090d", assetBundleName = "characters/char_090.prefabs.assetbundle", lihuiID = 13471, headID = 13474, littleHeadID = 13474, DiamondHeadID = 13473, bustID = 13475, bigbustID = 13476, skillHeadID = 13472, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char090_break", live2DAssetBundleName = "live2d/char090_break.assetbundle", live2DScale = 3.2, photoScale = 2.8, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60048] = {id = 60048, type = 5, prefabName = "char_002_v1", prefabNameUI = "char_002_v1UI", mapPrefabName = "char_002_v1m", yardPrefabName = "char_002_v1y", dormPrefabName = "char_002_v1d", assetBundleName = "characters/char_002_v1.prefabs.assetbundle", lihuiID = 13604, headID = 13607, littleHeadID = 13607, DiamondHeadID = 13606, bustID = 13608, bigbustID = 13610, skillHeadID = 13605, drawShowID = 13609, battleEmotion = "1", live2DPrefabName = "char002_v1", live2DAssetBundleName = "live2d/char002_v1.assetbundle", live2DScale = 3.1, photoScale = 2.9, 
photoLocation = {-16, -163}
, SteadyState = 1}
, 
[60049] = {id = 60049, type = 5, prefabName = "char_018", prefabNameUI = "char_018UI", mapPrefabName = "char_018m", yardPrefabName = "char_018y", dormPrefabName = "char_018d", assetBundleName = "characters/char_018.prefabs.assetbundle", lihuiID = 13501, headID = 13504, littleHeadID = 13504, DiamondHeadID = 13503, bustID = 13505, bigbustID = 13507, skillHeadID = 13502, drawShowID = 13507, battleEmotion = "1", live2DPrefabName = "char018_break", live2DAssetBundleName = "live2d/char018_break.assetbundle", live2DScale = 2.3, photoScale = 2, 
photoLocation = {-24, 18}
, SteadyState = 1}
, 
[60050] = {id = 60050, type = 5, prefabName = "char_007", prefabNameUI = "char_007UI", mapPrefabName = "char_007m", yardPrefabName = "char_007y", dormPrefabName = "char_007d", assetBundleName = "characters/char_007.prefabs.assetbundle", lihuiID = 13508, headID = 13511, littleHeadID = 13511, DiamondHeadID = 13510, bustID = 13512, bigbustID = 13514, skillHeadID = 13509, drawShowID = 13514, battleEmotion = "1", live2DPrefabName = "n001_break", live2DAssetBundleName = "live2d/n001_break.assetbundle", live2DScale = 3, photoScale = 2.8, 
photoLocation = {0, -205}
, SteadyState = 1}
, 
[60051] = {id = 60051, type = 5, prefabName = "char_036", prefabNameUI = "char_036UI", mapPrefabName = "char_036m", yardPrefabName = "char_036y", dormPrefabName = "char_036d", assetBundleName = "characters/char_036.prefabs.assetbundle", lihuiID = 13515, headID = 13518, littleHeadID = 13518, DiamondHeadID = 13517, bustID = 13519, bigbustID = 13521, skillHeadID = 13516, drawShowID = 13521, battleEmotion = "1", live2DPrefabName = "char036_break", live2DAssetBundleName = "live2d/char036_break.assetbundle", live2DScale = 1.9, photoScale = 2.5, 
photoLocation = {0, -82}
, SteadyState = 1}
, 
[60052] = {id = 60052, type = 5, prefabName = "char_049", prefabNameUI = "char_049UI", mapPrefabName = "char_049m", yardPrefabName = "char_049y", dormPrefabName = "char_049d", assetBundleName = "characters/char_049.prefabs.assetbundle", lihuiID = 13522, headID = 13525, littleHeadID = 13525, DiamondHeadID = 13524, bustID = 13526, bigbustID = 13528, skillHeadID = 13523, drawShowID = 13528, battleEmotion = "1", live2DPrefabName = "char049_break", live2DAssetBundleName = "live2d/char049_break.assetbundle", live2DScale = 2.4, photoScale = 3.2, 
photoLocation = {-53, -38}
, SteadyState = 1}
, 
[60053] = {id = 60053, type = 5, prefabName = "char_040", prefabNameUI = "char_040UI", mapPrefabName = "char_040m", yardPrefabName = "char_040y", dormPrefabName = "char_040d", assetBundleName = "characters/char_040.prefabs.assetbundle", lihuiID = 13630, headID = 13633, littleHeadID = 13633, DiamondHeadID = 13632, bustID = 13634, bigbustID = 13636, skillHeadID = 13631, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char040_break", live2DAssetBundleName = "live2d/char040_break.assetbundle", live2DScale = 4.2, photoScale = 2.8, 
photoLocation = {-43, -133}
, SteadyState = 1}
, 
[60054] = {id = 60054, type = 5, prefabName = "char_048", prefabNameUI = "char_048UI", mapPrefabName = "char_048m", yardPrefabName = "char_048y", dormPrefabName = "char_048d", assetBundleName = "characters/char_048.prefabs.assetbundle", lihuiID = 13674, headID = 13677, littleHeadID = 13677, DiamondHeadID = 13676, bustID = 13678, bigbustID = 13680, skillHeadID = 13675, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60055] = {id = 60055, type = 5, prefabName = "char_041", prefabNameUI = "char_041UI", mapPrefabName = "char_041m", yardPrefabName = "char_041y", dormPrefabName = "char_041d", assetBundleName = "characters/char_041.prefabs.assetbundle", lihuiID = 13667, headID = 13670, littleHeadID = 13670, DiamondHeadID = 13669, bustID = 13671, bigbustID = 13673, skillHeadID = 13668, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3.5, photoScale = 3, 
photoLocation = {28, 72}
, SteadyState = 1}
, 
[60056] = {id = 60056, type = 5, prefabName = "char_068", prefabNameUI = "char_068UI", mapPrefabName = "char_068m", yardPrefabName = "char_068y", dormPrefabName = "char_068d", assetBundleName = "characters/char_068.prefabs.assetbundle", lihuiID = 13757, headID = 13760, littleHeadID = 13760, DiamondHeadID = 13759, bustID = 13761, bigbustID = 13762, skillHeadID = 13758, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char068_break", live2DAssetBundleName = "live2d/char068_break.assetbundle", live2DScale = 3.2, photoScale = 3, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60057] = {id = 60057, type = 5, prefabName = "char_083", prefabNameUI = "char_083UI", mapPrefabName = "char_083m", yardPrefabName = "char_083y", dormPrefabName = "char_083d", assetBundleName = "characters/char_083.prefabs.assetbundle", lihuiID = 13777, headID = 13780, littleHeadID = 13780, DiamondHeadID = 13779, bustID = 13781, bigbustID = 13782, skillHeadID = 13778, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char083_break", live2DAssetBundleName = "live2d/char083_break.assetbundle", live2DScale = 3.3, photoScale = 2.9, 
photoLocation = {-25, -223}
, SteadyState = 1}
, 
[60058] = {id = 60058, type = 5, prefabName = "char_060", prefabNameUI = "char_060UI", mapPrefabName = "char_060m", yardPrefabName = "char_060y", dormPrefabName = "char_060d", assetBundleName = "characters/char_060.prefabs.assetbundle", lihuiID = 13916, headID = 13919, littleHeadID = 13919, DiamondHeadID = 13918, bustID = 13920, bigbustID = 13922, skillHeadID = 13917, drawShowID = 13921, battleEmotion = "1", live2DPrefabName = "char060_break", live2DAssetBundleName = "live2d/char060_break.assetbundle", live2DScale = 5, photoScale = 3.2, 
photoLocation = {0, -74}
, SteadyState = 1}
, 
[60059] = {id = 60059, type = 5, prefabName = "char_033", prefabNameUI = "char_033UI", mapPrefabName = "char_033m", yardPrefabName = "char_033y", dormPrefabName = "char_033d", assetBundleName = "characters/char_033.prefabs.assetbundle", lihuiID = 13923, headID = 13926, littleHeadID = 13926, DiamondHeadID = 13925, bustID = 13927, bigbustID = 13929, skillHeadID = 13924, drawShowID = 13928, battleEmotion = "1", live2DPrefabName = "char033_break", live2DAssetBundleName = "live2d/char033_break.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-27, -120}
, SteadyState = 1}
, 
[60060] = {id = 60060, type = 5, prefabName = "char_071_v1", prefabNameUI = "char_071_v1UI", mapPrefabName = "char_071_v1m", yardPrefabName = "char_071_v1y", dormPrefabName = "char_071_v1d", assetBundleName = "characters/char_071_v1.prefabs.assetbundle", lihuiID = 14111, headID = 14114, littleHeadID = 14114, DiamondHeadID = 14113, bustID = 14115, bigbustID = 14116, skillHeadID = 14112, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char071_v1", live2DAssetBundleName = "live2d/char071_v1.assetbundle", live2DScale = 3.2, photoScale = 3.4, 
photoLocation = {-31, -52}
, SteadyState = 1}
, 
[60061] = {id = 60061, type = 5, prefabName = "char_049_v1", prefabNameUI = "char_049_v1UI", mapPrefabName = "char_049_v1m", yardPrefabName = "char_049_v1y", dormPrefabName = "char_049_v1d", assetBundleName = "characters/char_049_v1.prefabs.assetbundle", lihuiID = 14049, headID = 14052, littleHeadID = 14052, DiamondHeadID = 14051, bustID = 14053, bigbustID = 14054, skillHeadID = 14050, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char049_v1", live2DAssetBundleName = "live2d/char049_v1.assetbundle", live2DScale = 2.4, photoScale = 3.6, 
photoLocation = {-5, -49}
, SteadyState = 1}
, 
[60062] = {id = 60062, type = 5, prefabName = "char_080", prefabNameUI = "char_080UI", mapPrefabName = "char_080m", yardPrefabName = "char_080y", dormPrefabName = "char_080d", assetBundleName = "characters/char_080.prefabs.assetbundle", lihuiID = 13931, headID = 13934, littleHeadID = 13934, DiamondHeadID = 13933, bustID = 13935, bigbustID = 13936, skillHeadID = 13932, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char080_break", live2DAssetBundleName = "live2d/char080_break.assetbundle", live2DScale = 2.9, photoScale = 3, 
photoLocation = {5, -162}
, SteadyState = 1}
, 
[60063] = {id = 60063, type = 5, prefabName = "char_033_v1", prefabNameUI = "char_033_v1UI", mapPrefabName = "char_033_v1m", yardPrefabName = "char_033_v1y", dormPrefabName = "char_033_v1d", assetBundleName = "characters/char_033_v1.prefabs.assetbundle", lihuiID = 13978, headID = 13981, littleHeadID = 13981, DiamondHeadID = 13980, bustID = 13982, bigbustID = 13983, skillHeadID = 13979, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char033_v1", live2DAssetBundleName = "live2d/char033_v1.assetbundle", live2DScale = 3.6, photoScale = 2.8, 
photoLocation = {-75, 13}
, SteadyState = 1}
, 
[60064] = {id = 60064, type = 5, prefabName = "char_070_v1", prefabNameUI = "char_070_v1UI", mapPrefabName = "char_070_v1m", yardPrefabName = "char_070_v1y", dormPrefabName = "char_070_v1d", assetBundleName = "characters/char_070_v1.prefabs.assetbundle", lihuiID = 13984, headID = 13987, littleHeadID = 13987, DiamondHeadID = 13986, bustID = 13988, bigbustID = 13989, skillHeadID = 13985, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char070_v1_hx", live2DAssetBundleName = "live2d/char070_v1_hx.assetbundle", live2DScale = 2.6, photoScale = 3, 
photoLocation = {-49, -248}
, SteadyState = 1}
, 
[60065] = {id = 60065, type = 5, prefabName = "char_110", prefabNameUI = "char_110UI", mapPrefabName = "char_110m", yardPrefabName = "char_110y", dormPrefabName = "char_110d", assetBundleName = "characters/char_110.prefabs.assetbundle", lihuiID = 14078, headID = 14081, littleHeadID = 14081, DiamondHeadID = 14080, bustID = 14082, bigbustID = 14083, skillHeadID = 14079, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char110_break", live2DAssetBundleName = "live2d/char110_break.assetbundle", live2DScale = 3.8, photoScale = 3.3, 
photoLocation = {-28, 46}
, SteadyState = 1}
, 
[60066] = {id = 60066, type = 4, prefabName = "char_076", prefabNameUI = "char_076UI", mapPrefabName = "char_076m", yardPrefabName = "char_076y", dormPrefabName = "char_076d", assetBundleName = "characters/char_076.prefabs.assetbundle", lihuiID = 11978, headID = 12038, littleHeadID = 12038, DiamondHeadID = 12018, bustID = 12058, bigbustID = 12078, skillHeadID = 11998, drawShowID = 12534, battleEmotion = "1", live2DPrefabName = "char076_noback", live2DAssetBundleName = "live2d/char076_noback.assetbundle", live2DScale = 3.6, photoScale = 2.5, 
photoLocation = {-31, -124}
, SteadyState = 1}
, 
[60067] = {id = 60067, type = 5, prefabName = "char_066", prefabNameUI = "char_066UI", mapPrefabName = "char_066m", yardPrefabName = "char_066y", dormPrefabName = "char_066d", assetBundleName = "characters/char_066.prefabs.assetbundle", lihuiID = 14203, headID = 14206, littleHeadID = 14206, DiamondHeadID = 14205, bustID = 14207, bigbustID = 14208, skillHeadID = 14204, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char066_break", live2DAssetBundleName = "live2d/char066_break.assetbundle", live2DScale = 2, photoScale = 2.8, 
photoLocation = {-36, 19}
, SteadyState = 1}
, 
[60068] = {id = 60068, type = 5, prefabName = "char_067", prefabNameUI = "char_067UI", mapPrefabName = "char_067m", yardPrefabName = "char_067y", dormPrefabName = "char_067d", assetBundleName = "characters/char_067.prefabs.assetbundle", lihuiID = 14195, headID = 14198, littleHeadID = 14198, DiamondHeadID = 14197, bustID = 14199, bigbustID = 14200, skillHeadID = 14196, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char067_break", live2DAssetBundleName = "live2d/char067_break.assetbundle", live2DScale = 2.1, photoScale = 2.8, 
photoLocation = {-36, 19}
, SteadyState = 1}
, 
[60069] = {id = 60069, type = 5, prefabName = "char_018_v1", prefabNameUI = "char_018_v1UI", mapPrefabName = "char_018_v1m", yardPrefabName = "char_018_v1y", dormPrefabName = "char_018_v1d", assetBundleName = "characters/char_018_v1.prefabs.assetbundle", lihuiID = 14243, headID = 14246, littleHeadID = 14246, DiamondHeadID = 14245, bustID = 14247, bigbustID = 14248, skillHeadID = 14244, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char018_v1", live2DAssetBundleName = "live2d/char018_v1.assetbundle", live2DScale = 2.5, photoScale = 2.8, 
photoLocation = {-75, 13}
, SteadyState = 1}
, 
[60070] = {id = 60070, type = 5, prefabName = "char_086", prefabNameUI = "char_086UI", mapPrefabName = "char_086m", yardPrefabName = "char_086y", dormPrefabName = "char_086d", assetBundleName = "characters/char_086.prefabs.assetbundle", lihuiID = 14273, headID = 14276, littleHeadID = 14276, DiamondHeadID = 14275, bustID = 14277, bigbustID = 14278, skillHeadID = 14274, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char086_break", live2DAssetBundleName = "live2d/char086_break.assetbundle", live2DScale = 3, photoScale = 2.5, 
photoLocation = {2, 71}
, SteadyState = 1}
, 
[60071] = {id = 60071, type = 5, prefabName = "char_064", prefabNameUI = "char_064UI", mapPrefabName = "char_064m", yardPrefabName = "char_064y", dormPrefabName = "char_064d", assetBundleName = "characters/char_064.prefabs.assetbundle", lihuiID = 14326, headID = 14329, littleHeadID = 14329, DiamondHeadID = 14328, bustID = 14330, bigbustID = 14331, skillHeadID = 14327, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char064_break", live2DAssetBundleName = "live2d/char064_break.assetbundle", live2DScale = 2.4, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60072] = {id = 60072, type = 5, prefabName = "char_050", prefabNameUI = "char_050UI", mapPrefabName = "char_050m", yardPrefabName = "char_050y", dormPrefabName = "char_050d", assetBundleName = "characters/char_050.prefabs.assetbundle", lihuiID = 14343, headID = 14346, littleHeadID = 14346, DiamondHeadID = 14345, bustID = 14347, bigbustID = 14348, skillHeadID = 14344, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char050_break", live2DAssetBundleName = "overseas_live2d/char050_break.assetbundle", live2DScale = 2.5, photoScale = 2.5, 
photoLocation = {0, -135}
, SteadyState = 1}
, 
[60073] = {id = 60073, type = 5, prefabName = "char_072_v1", prefabNameUI = "char_072_v1UI", mapPrefabName = "char_072_v1m", yardPrefabName = "char_072_v1y", dormPrefabName = "char_072_v1d", assetBundleName = "characters/char_072_v1.prefabs.assetbundle", lihuiID = 14403, headID = 14406, littleHeadID = 14406, DiamondHeadID = 14405, bustID = 14407, bigbustID = 14408, skillHeadID = 14404, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char072_v1", live2DAssetBundleName = "live2d/char072_v1.assetbundle", live2DScale = 2.8, photoScale = 2.9, 
photoLocation = {-4, 150}
, SteadyState = 1}
, 
[60074] = {id = 60074, type = 5, prefabName = "char_051", prefabNameUI = "char_051UI", mapPrefabName = "char_051m", yardPrefabName = "char_051y", dormPrefabName = "char_051d", assetBundleName = "characters/char_051.prefabs.assetbundle", lihuiID = 14450, headID = 14453, littleHeadID = 14453, DiamondHeadID = 14452, bustID = 14454, bigbustID = 14455, skillHeadID = 14451, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char051_break", live2DAssetBundleName = "overseas_live2d/char051_break.assetbundle", live2DScale = 2.8, photoScale = 2.8, 
photoLocation = {-40, -70}
, SteadyState = 1}
, 
[60075] = {id = 60075, type = 5, prefabName = "char_069", prefabNameUI = "char_069UI", mapPrefabName = "char_069m", yardPrefabName = "char_069y", dormPrefabName = "char_069d", assetBundleName = "characters/char_069.prefabs.assetbundle", lihuiID = 14457, headID = 14460, littleHeadID = 14460, DiamondHeadID = 14459, bustID = 14461, bigbustID = 14462, skillHeadID = 14458, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char069_break", live2DAssetBundleName = "overseas_live2d/char069_break.assetbundle", live2DScale = 3, photoScale = 2.6, 
photoLocation = {-24, -63}
, SteadyState = 1}
, 
[60076] = {id = 60076, type = 5, prefabName = "char_091", prefabNameUI = "char_091UI", mapPrefabName = "char_091m", yardPrefabName = "char_091y", dormPrefabName = "char_091d", assetBundleName = "characters/char_091.prefabs.assetbundle", lihuiID = 14493, headID = 14496, littleHeadID = 14496, DiamondHeadID = 14495, bustID = 14497, bigbustID = 14498, skillHeadID = 14494, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char091_break", live2DAssetBundleName = "live2d/char091_break.assetbundle", live2DScale = 3.7, photoScale = 4.5, 
photoLocation = {-39, -33}
, SteadyState = 1}
, 
[60077] = {id = 60077, type = 5, prefabName = "char_021_v1", prefabNameUI = "char_021_v1UI", mapPrefabName = "char_021_v1m", yardPrefabName = "char_021_v1y", dormPrefabName = "char_021_v1d", assetBundleName = "characters/char_021_v1.prefabs.assetbundle", lihuiID = 14499, headID = 14502, littleHeadID = 14502, DiamondHeadID = 14501, bustID = 14503, bigbustID = 14504, skillHeadID = 14500, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char021_v1", live2DAssetBundleName = "live2d/char021_v1.assetbundle", live2DScale = 2.8, photoScale = 2.8, 
photoLocation = {-40, -70}
, SteadyState = 1}
, 
[60078] = {id = 60078, type = 5, prefabName = "char_054", prefabNameUI = "char_054UI", mapPrefabName = "char_054m", yardPrefabName = "char_054y", dormPrefabName = "char_054d", assetBundleName = "characters/char_054.prefabs.assetbundle", lihuiID = 12091, headID = 11530, littleHeadID = 11530, DiamondHeadID = 11522, bustID = 11538, bigbustID = 11546, skillHeadID = 11514, drawShowID = 12520, battleEmotion = "1", live2DPrefabName = "char054", live2DAssetBundleName = "live2d/char054.assetbundle", live2DScale = 3.5, photoScale = 3, 
photoLocation = {-60, -140}
, SteadyState = 1}
, 
[60079] = {id = 60079, type = 5, prefabName = "char_092", prefabNameUI = "char_092UI", mapPrefabName = "char_092m", yardPrefabName = "char_092y", dormPrefabName = "char_092d", assetBundleName = "characters/char_092.prefabs.assetbundle", lihuiID = 14557, headID = 14560, littleHeadID = 14560, DiamondHeadID = 14559, bustID = 14561, bigbustID = 14562, skillHeadID = 14558, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char092_break", live2DAssetBundleName = "live2d/char092_break.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-71, -62}
, SteadyState = 1}
, 
[60080] = {id = 60080, type = 5, prefabName = "char_065_v1", prefabNameUI = "char_065_v1UI", mapPrefabName = "char_065_v1m", yardPrefabName = "char_065_v1y", dormPrefabName = "char_065_v1d", assetBundleName = "characters/char_065_v1.prefabs.assetbundle", lihuiID = 14542, headID = 14545, littleHeadID = 14545, DiamondHeadID = 14544, bustID = 14546, bigbustID = 14547, skillHeadID = 14543, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char065_v1", live2DAssetBundleName = "live2d/char065_v1.assetbundle", live2DScale = 3.3, photoScale = 3.3, 
photoLocation = {41, -40}
, SteadyState = 1}
, 
[60081] = {id = 60081, type = 5, prefabName = "char_103", prefabNameUI = "char_103UI", mapPrefabName = "char_103m", yardPrefabName = "char_103y", dormPrefabName = "char_103d", assetBundleName = "characters/char_103.prefabs.assetbundle", lihuiID = 14662, headID = 14665, littleHeadID = 14665, DiamondHeadID = 14664, bustID = 14666, bigbustID = 14667, skillHeadID = 14663, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char103_break", live2DAssetBundleName = "live2d/char103_break.assetbundle", live2DScale = 3.5, photoScale = 3.2, 
photoLocation = {-17, -7}
, SteadyState = 1}
, 
[60083] = {id = 60083, type = 5, prefabName = "char_102", prefabNameUI = "char_102UI", mapPrefabName = "char_102m", yardPrefabName = "char_102y", dormPrefabName = "char_102d", assetBundleName = "characters/char_102.prefabs.assetbundle", lihuiID = 14656, headID = 14659, littleHeadID = 14659, DiamondHeadID = 14658, bustID = 14660, bigbustID = 14661, skillHeadID = 14657, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char102_break", live2DAssetBundleName = "live2d/char102_break.assetbundle", live2DScale = 2.8, photoScale = 3.5, 
photoLocation = {-31, -96}
, SteadyState = 1}
, 
[60084] = {id = 60084, type = 5, prefabName = "char_084", prefabNameUI = "char_084UI", mapPrefabName = "char_084m", yardPrefabName = "char_084y", dormPrefabName = "char_084d", assetBundleName = "characters/char_084.prefabs.assetbundle", lihuiID = 14895, headID = 14898, littleHeadID = 14898, DiamondHeadID = 14897, bustID = 14899, bigbustID = 14900, skillHeadID = 14896, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char084_break", live2DAssetBundleName = "live2d/char084_break.assetbundle", live2DScale = 3.2, photoScale = 4, 
photoLocation = {95, -27}
, SteadyState = 1}
, 
[60085] = {id = 60085, type = 5, prefabName = "char_085", prefabNameUI = "char_085UI", mapPrefabName = "char_085m", yardPrefabName = "char_085y", dormPrefabName = "char_085d", assetBundleName = "characters/char_085.prefabs.assetbundle", lihuiID = 14687, headID = 14690, littleHeadID = 14690, DiamondHeadID = 14689, bustID = 14691, bigbustID = 14692, skillHeadID = 14688, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char085_break", live2DAssetBundleName = "live2d/char085_break.assetbundle", live2DScale = 3.5, photoScale = 4.5, 
photoLocation = {-22, -35}
, SteadyState = 1}
, 
[60086] = {id = 60086, type = 5, prefabName = "char_040_v1", prefabNameUI = "char_040_v1UI", mapPrefabName = "char_040_v1m", yardPrefabName = "char_040_v1y", dormPrefabName = "char_040_v1d", assetBundleName = "characters/char_040_v1.prefabs.assetbundle", lihuiID = 15052, headID = 15055, littleHeadID = 15055, DiamondHeadID = 15054, bustID = 15056, bigbustID = 15057, skillHeadID = 15053, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char040_v1", live2DAssetBundleName = "live2d/char040_v1.assetbundle", live2DScale = 3.5, photoScale = 3.5, 
photoLocation = {-37, -52}
, SteadyState = 1}
, 
[60087] = {id = 60087, type = 5, prefabName = "char_069_v1", prefabNameUI = "char_069_v1UI", mapPrefabName = "char_069_v1m", yardPrefabName = "char_069_v1y", dormPrefabName = "char_069_v1d", assetBundleName = "characters/char_069_v1.prefabs.assetbundle", lihuiID = 14743, headID = 14746, littleHeadID = 14746, DiamondHeadID = 14745, bustID = 14747, bigbustID = 14748, skillHeadID = 14744, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char069_v1", live2DAssetBundleName = "live2d/char069_v1.assetbundle", live2DScale = 2.6, photoScale = 3.6, 
photoLocation = {15, -227}
, SteadyState = 1}
, 
[60088] = {id = 60088, type = 5, prefabName = "char_094", prefabNameUI = "char_094UI", mapPrefabName = "char_094m", yardPrefabName = "char_094y", dormPrefabName = "char_094d", assetBundleName = "characters/char_094.prefabs.assetbundle", lihuiID = 14795, headID = 14798, littleHeadID = 14798, DiamondHeadID = 14797, bustID = 14799, bigbustID = 14800, skillHeadID = 14796, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char094_break", live2DAssetBundleName = "live2d/char094_break.assetbundle", live2DScale = 3, photoScale = 3.5, 
photoLocation = {115, -73}
, SteadyState = 1}
, 
[60089] = {id = 60089, type = 5, prefabName = "char_101", prefabNameUI = "char_101UI", mapPrefabName = "char_101m", yardPrefabName = "char_101y", dormPrefabName = "char_101d", assetBundleName = "characters/char_101.prefabs.assetbundle", lihuiID = 14889, headID = 14892, littleHeadID = 14892, DiamondHeadID = 14891, bustID = 14893, bigbustID = 14894, skillHeadID = 14890, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char101_break", live2DAssetBundleName = "live2d/char101_break.assetbundle", live2DScale = 2.6, photoScale = 2.5, 
photoLocation = {-38, -16}
, SteadyState = 1}
, 
[60090] = {id = 60090, type = 5, prefabName = "char_095_v1", prefabNameUI = "char_095_v1UI", mapPrefabName = "char_095_v1m", yardPrefabName = "char_095_v1y", dormPrefabName = "char_095_v1d", assetBundleName = "characters/char_095_v1.prefabs.assetbundle", lihuiID = 14936, headID = 14939, littleHeadID = 14939, DiamondHeadID = 14938, bustID = 14940, bigbustID = 14941, skillHeadID = 14937, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char095_v1", live2DAssetBundleName = "live2d/char095_v1.assetbundle", live2DScale = 2.2, photoScale = 3.2, 
photoLocation = {-35, -103}
, SteadyState = 1}
, 
[60091] = {id = 60091, type = 5, prefabName = "char_097", prefabNameUI = "char_097UI", mapPrefabName = "char_097m", yardPrefabName = "char_097y", dormPrefabName = "char_097d", assetBundleName = "characters/char_097.prefabs.assetbundle", lihuiID = 14951, headID = 14954, littleHeadID = 14954, DiamondHeadID = 14953, bustID = 14955, bigbustID = 14956, skillHeadID = 14952, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char097_break", live2DAssetBundleName = "live2d/char097_break.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {4, -10}
, SteadyState = 1}
, 
[60092] = {id = 60092, type = 5, prefabName = "char_095", prefabNameUI = "char_095UI", mapPrefabName = "char_095m", yardPrefabName = "char_095y", dormPrefabName = "char_095d", assetBundleName = "characters/char_095.prefabs.assetbundle", lihuiID = 14962, headID = 14965, littleHeadID = 14965, DiamondHeadID = 14964, bustID = 14966, bigbustID = 14967, skillHeadID = 14963, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char095_break", live2DAssetBundleName = "live2d/char095_break.assetbundle", live2DScale = 2.4, photoScale = 2.6, 
photoLocation = {-35, 0}
, SteadyState = 1}
, 
[60093] = {id = 60093, type = 5, prefabName = "char_108", prefabNameUI = "char_108UI", mapPrefabName = "char_108m", yardPrefabName = "char_108y", dormPrefabName = "char_108d", assetBundleName = "characters/char_108.prefabs.assetbundle", lihuiID = 14719, headID = 14722, littleHeadID = 14722, DiamondHeadID = 14721, bustID = 14723, bigbustID = 14724, skillHeadID = 14720, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char108_break", live2DAssetBundleName = "live2d/char108_break.assetbundle", live2DScale = 3.5, photoScale = 4.1, 
photoLocation = {-102, -120}
, SteadyState = 1}
, 
[60094] = {id = 60094, type = 5, prefabName = "char_088_v1", prefabNameUI = "char_088_v1UI", mapPrefabName = "char_088_v1m", yardPrefabName = "char_088_v1y", dormPrefabName = "char_088_v1d", assetBundleName = "characters/char_088_v1.prefabs.assetbundle", lihuiID = 14999, headID = 15002, littleHeadID = 15002, DiamondHeadID = 15001, bustID = 15003, bigbustID = 15004, skillHeadID = 15000, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char088_break", live2DAssetBundleName = "live2d/char088_break.assetbundle", live2DScale = 3, photoScale = 3.6, 
photoLocation = {-102, -100}
, SteadyState = 1}
, 
[60095] = {id = 60095, type = 5, prefabName = "char_054", prefabNameUI = "char_054UI", mapPrefabName = "char_054m", yardPrefabName = "char_054y", dormPrefabName = "char_054d", assetBundleName = "characters/char_054.prefabs.assetbundle", lihuiID = 15031, headID = 15034, littleHeadID = 15034, DiamondHeadID = 15033, bustID = 15035, bigbustID = 15036, skillHeadID = 15032, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "", live2DAssetBundleName = "", live2DScale = 3.5, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60096] = {id = 60096, type = 5, prefabName = "char_112", prefabNameUI = "char_112UI", mapPrefabName = "char_112m", yardPrefabName = "char_112y", dormPrefabName = "char_112d", assetBundleName = "characters/char_112.prefabs.assetbundle", lihuiID = 15077, headID = 15080, littleHeadID = 15080, DiamondHeadID = 15079, bustID = 15081, bigbustID = 15082, skillHeadID = 15078, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char112_break", live2DAssetBundleName = "live2d/char112_break.assetbundle", live2DScale = 3.8, photoScale = 3.7, 
photoLocation = {-163, -195}
, SteadyState = 1}
, 
[60097] = {id = 60097, type = 5, prefabName = "char_104", prefabNameUI = "char_104UI", mapPrefabName = "char_104m", yardPrefabName = "char_104y", dormPrefabName = "char_104d", assetBundleName = "characters/char_104.prefabs.assetbundle", lihuiID = 14280, headID = 14283, littleHeadID = 14283, DiamondHeadID = 14282, bustID = 14284, bigbustID = 14285, skillHeadID = 14281, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char104_break", live2DAssetBundleName = "live2d/char104_break.assetbundle", live2DScale = 3.3, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60098] = {id = 60098, type = 5, prefabName = "char_052_v1", prefabNameUI = "char_052_v1UI", mapPrefabName = "char_052_v1m", yardPrefabName = "char_052_v1y", dormPrefabName = "char_052_v1d", assetBundleName = "characters/char_052_v1.prefabs.assetbundle", lihuiID = 15163, headID = 15166, littleHeadID = 15166, DiamondHeadID = 15165, bustID = 15167, bigbustID = 15168, skillHeadID = 15164, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char052_v1_hx", live2DAssetBundleName = "live2d/char052_v1_hx.assetbundle", live2DScale = 2, photoScale = 2.5, 
photoLocation = {-45, -17}
, SteadyState = 1}
, 
[60099] = {id = 60099, type = 5, prefabName = "char_120", prefabNameUI = "char_120UI", mapPrefabName = "char_120m", yardPrefabName = "char_120y", dormPrefabName = "char_120d", assetBundleName = "characters/char_120.prefabs.assetbundle", lihuiID = 15181, headID = 15184, littleHeadID = 15184, DiamondHeadID = 15183, bustID = 15185, bigbustID = 15186, skillHeadID = 15182, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char120_break", live2DAssetBundleName = "live2d/char120_break.assetbundle", live2DScale = 3, photoScale = 3.2, 
photoLocation = {-17, -57}
, SteadyState = 1}
, 
[60100] = {id = 60100, type = 5, prefabName = "char_111_v1", prefabNameUI = "char_111_v1UI", mapPrefabName = "char_111_v1m", yardPrefabName = "char_111_v1y", dormPrefabName = "char_111_v1d", assetBundleName = "characters/char_111_v1.prefabs.assetbundle", lihuiID = 15205, headID = 15208, littleHeadID = 15208, DiamondHeadID = 15207, bustID = 15209, bigbustID = 15210, skillHeadID = 15206, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char111_break", live2DAssetBundleName = "live2d/char111_break.assetbundle", live2DScale = 3, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60101] = {id = 60101, type = 5, prefabName = "char_113", prefabNameUI = "char_113UI", mapPrefabName = "char_113m", yardPrefabName = "char_113y", dormPrefabName = "char_113d", assetBundleName = "characters/char_113.prefabs.assetbundle", lihuiID = 15346, headID = 15349, littleHeadID = 15349, DiamondHeadID = 15348, bustID = 15350, bigbustID = 15351, skillHeadID = 15347, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char113_break", live2DAssetBundleName = "live2d/char113_break.assetbundle", live2DScale = 3, photoScale = 2.8, 
photoLocation = {-60, -17}
, SteadyState = 1}
, 
[60102] = {id = 60102, type = 5, prefabName = "char_109", prefabNameUI = "char_109UI", mapPrefabName = "char_109m", yardPrefabName = "char_109y", dormPrefabName = "char_109d", assetBundleName = "characters/char_109.prefabs.assetbundle", lihuiID = 15360, headID = 15363, littleHeadID = 15363, DiamondHeadID = 15362, bustID = 15364, bigbustID = 15365, skillHeadID = 15361, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char109_break", live2DAssetBundleName = "live2d/char109_break.assetbundle", live2DScale = 3, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60103] = {id = 60103, type = 5, prefabName = "char_115", prefabNameUI = "char_115UI", mapPrefabName = "char_115m", yardPrefabName = "char_115y", dormPrefabName = "char_115d", assetBundleName = "characters/char_115.prefabs.assetbundle", lihuiID = 15374, headID = 15377, littleHeadID = 15377, DiamondHeadID = 15376, bustID = 15378, bigbustID = 15379, skillHeadID = 15375, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char115_break", live2DAssetBundleName = "live2d/char115_break.assetbundle", live2DScale = 3.5, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60104] = {id = 60104, type = 5, prefabName = "char_043_v1", prefabNameUI = "char_043_v1UI", mapPrefabName = "char_043_v1m", yardPrefabName = "char_043_v1y", dormPrefabName = "char_043_v1d", assetBundleName = "characters/char_043_v1.prefabs.assetbundle", lihuiID = 15437, headID = 15440, littleHeadID = 15440, DiamondHeadID = 15439, bustID = 15441, bigbustID = 15442, skillHeadID = 15438, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char043_v1_hx", live2DAssetBundleName = "live2d/char043_v1_hx.assetbundle", live2DScale = 2, photoScale = 3, 
photoLocation = {-17, -150}
, SteadyState = 1}
, 
[60105] = {id = 60105, type = 5, prefabName = "char_063_v2", prefabNameUI = "char_063_v2UI", mapPrefabName = "char_063_v2m", yardPrefabName = "char_063_v2y", dormPrefabName = "char_063_v2d", assetBundleName = "characters/char_063_v2.prefabs.assetbundle", lihuiID = 15444, headID = 15447, littleHeadID = 15447, DiamondHeadID = 15446, bustID = 15448, bigbustID = 15449, skillHeadID = 15445, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char063_v2", live2DAssetBundleName = "live2d/char063_v2.assetbundle", live2DScale = 3.3, photoScale = 3, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60106] = {id = 60106, type = 5, prefabName = "char_032_v1", prefabNameUI = "char_032_v1UI", mapPrefabName = "char_032_v1m", yardPrefabName = "char_032_v1y", dormPrefabName = "char_032_v1d", assetBundleName = "characters/char_032_v1.prefabs.assetbundle", lihuiID = 15451, headID = 15454, littleHeadID = 15454, DiamondHeadID = 15453, bustID = 15455, bigbustID = 15456, skillHeadID = 15452, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char032_v1", live2DAssetBundleName = "live2d/char032_v1.assetbundle", live2DScale = 3.3, photoScale = 3.3, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60107] = {id = 60107, type = 5, prefabName = "char_098", prefabNameUI = "char_098UI", mapPrefabName = "char_098m", yardPrefabName = "char_098y", dormPrefabName = "char_098d", assetBundleName = "characters/char_098.prefabs.assetbundle", lihuiID = 15388, headID = 15391, littleHeadID = 15391, DiamondHeadID = 15390, bustID = 15392, bigbustID = 15393, skillHeadID = 15389, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char098_break", live2DAssetBundleName = "live2d/char098_break.assetbundle", live2DScale = 2.5, photoScale = 2.9, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60108] = {id = 60108, type = 5, prefabName = "char_107", prefabNameUI = "char_107UI", mapPrefabName = "char_107m", yardPrefabName = "char_107y", dormPrefabName = "char_107d", assetBundleName = "characters/char_107.prefabs.assetbundle", lihuiID = 15416, headID = 15419, littleHeadID = 15419, DiamondHeadID = 15418, bustID = 15420, bigbustID = 15421, skillHeadID = 15417, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char107_break", live2DAssetBundleName = "live2d/char107_break.assetbundle", live2DScale = 3.5, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60109] = {id = 60109, type = 5, prefabName = "char_119", prefabNameUI = "char_119UI", mapPrefabName = "char_119m", yardPrefabName = "char_119y", dormPrefabName = "char_119d", assetBundleName = "characters/char_119.prefabs.assetbundle", lihuiID = 15402, headID = 15405, littleHeadID = 15405, DiamondHeadID = 15404, bustID = 15406, bigbustID = 15407, skillHeadID = 15403, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char119_break", live2DAssetBundleName = "live2d/char119_break.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60110] = {id = 60110, type = 5, prefabName = "char_105", prefabNameUI = "char_105UI", mapPrefabName = "char_105m", yardPrefabName = "char_105y", dormPrefabName = "char_105d", assetBundleName = "characters/char_105.prefabs.assetbundle", lihuiID = 15430, headID = 15433, littleHeadID = 15433, DiamondHeadID = 15432, bustID = 15434, bigbustID = 15435, skillHeadID = 15431, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char105_break", live2DAssetBundleName = "live2d/char105_break.assetbundle", live2DScale = 2.8, photoScale = 3.4, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60116] = {id = 60116, type = 5, prefabName = "char_024_v2", prefabNameUI = "char_024_v2UI", mapPrefabName = "char_024_v2m", yardPrefabName = "char_024_v2y", dormPrefabName = "char_024_v2d", assetBundleName = "characters/char_024_v2.prefabs.assetbundle", lihuiID = 15729, headID = 15732, littleHeadID = 15732, DiamondHeadID = 15731, bustID = 15733, bigbustID = 15734, skillHeadID = 15730, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char024_v2", live2DAssetBundleName = "live2d/char024_v2.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60117] = {id = 60117, type = 5, prefabName = "char_024_dragon", prefabNameUI = "char_024_dragon", mapPrefabName = "char_024_dragonm", yardPrefabName = "char_024y", dormPrefabName = "char_024d", assetBundleName = "characters/char_024_dragon.prefabs.assetbundle", lihuiID = 15729, headID = 15732, littleHeadID = 15732, DiamondHeadID = 15731, bustID = 15733, bigbustID = 15734, skillHeadID = 15730, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char024_v2", live2DAssetBundleName = "live2d/char024_v2.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60118] = {id = 60118, type = 5, prefabName = "char_052_v2", prefabNameUI = "char_052_v2UI", mapPrefabName = "char_052_v2m", yardPrefabName = "char_052_v2y", dormPrefabName = "char_052_v2d", assetBundleName = "characters/char_052_v2.prefabs.assetbundle", lihuiID = 15458, headID = 15461, littleHeadID = 15461, DiamondHeadID = 15460, bustID = 15462, bigbustID = 15463, skillHeadID = 15459, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char052_v2", live2DAssetBundleName = "live2d/char052_v2.assetbundle", live2DScale = 2.1, photoScale = 2.5, 
photoLocation = {-45, -17}
, SteadyState = 1}
, 
[60119] = {id = 60119, type = 5, prefabName = "char_117", prefabNameUI = "char_117UI", mapPrefabName = "char_117m", yardPrefabName = "char_117y", dormPrefabName = "char_117d", assetBundleName = "characters/char_117.prefabs.assetbundle", lihuiID = 15784, headID = 15787, littleHeadID = 15787, DiamondHeadID = 15786, bustID = 15788, bigbustID = 15789, skillHeadID = 15785, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char117_break", live2DAssetBundleName = "live2d/char117_break.assetbundle", live2DScale = 3.1, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60120] = {id = 60120, type = 5, prefabName = "char_122", prefabNameUI = "char_122UI", mapPrefabName = "char_122m", yardPrefabName = "char_122y", dormPrefabName = "char_122d", assetBundleName = "characters/char_122.prefabs.assetbundle", lihuiID = 15807, headID = 15810, littleHeadID = 15810, DiamondHeadID = 15809, bustID = 15811, bigbustID = 15812, skillHeadID = 15808, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char122_break", live2DAssetBundleName = "live2d/char122_break.assetbundle", live2DScale = 3.1, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60121] = {id = 60121, type = 5, prefabName = "char_121", prefabNameUI = "char_121UI", mapPrefabName = "char_121m", yardPrefabName = "char_121y", dormPrefabName = "char_121d", assetBundleName = "characters/char_121.prefabs.assetbundle", lihuiID = 15824, headID = 15827, littleHeadID = 15827, DiamondHeadID = 15826, bustID = 15828, bigbustID = 15829, skillHeadID = 15825, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char121_break", live2DAssetBundleName = "live2d/char121_break.assetbundle", live2DScale = 3.1, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60122] = {id = 60122, type = 5, prefabName = "char_104_v1", prefabNameUI = "char_104_v1UI", mapPrefabName = "char_104_v1m", yardPrefabName = "char_104_v1y", dormPrefabName = "char_104_v1d", assetBundleName = "characters/char_104_v1.prefabs.assetbundle", lihuiID = 15834, headID = 15837, littleHeadID = 15837, DiamondHeadID = 15836, bustID = 15838, bigbustID = 15839, skillHeadID = 15835, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char104_v1", live2DAssetBundleName = "live2d/char104_v1.assetbundle", live2DScale = 2.5, photoScale = 2.5, 
photoLocation = {-45, -17}
, SteadyState = 1}
, 
[60123] = {id = 60123, type = 5, prefabName = "char_123", prefabNameUI = "char_123UI", mapPrefabName = "char_123m", yardPrefabName = "char_123y", dormPrefabName = "char_123d", assetBundleName = "characters/char_123.prefabs.assetbundle", lihuiID = 15890, headID = 15893, littleHeadID = 15893, DiamondHeadID = 15892, bustID = 15894, bigbustID = 15895, skillHeadID = 15891, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char123_break", live2DAssetBundleName = "live2d/char123_break.assetbundle", live2DScale = 2.1, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60124] = {id = 60124, type = 5, prefabName = "char_103_v1", prefabNameUI = "char_103_v1UI", mapPrefabName = "char_103_v1m", yardPrefabName = "char_103_v1y", dormPrefabName = "char_103_v1d", assetBundleName = "characters/char_103_v1.prefabs.assetbundle", lihuiID = 15905, headID = 15908, littleHeadID = 15908, DiamondHeadID = 15907, bustID = 15909, bigbustID = 15910, skillHeadID = 15906, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char103_v1", live2DAssetBundleName = "live2d/char103_v1.assetbundle", live2DScale = 3, photoScale = 3, 
photoLocation = {-45, -17}
, SteadyState = 1}
, 
[60125] = {id = 60125, type = 5, prefabName = "char_082", prefabNameUI = "char_082UI", mapPrefabName = "char_082m", yardPrefabName = "char_082y", dormPrefabName = "char_082d", assetBundleName = "characters/char_082.prefabs.assetbundle", lihuiID = 15919, headID = 15922, littleHeadID = 15922, DiamondHeadID = 15921, bustID = 15923, bigbustID = 15924, skillHeadID = 15920, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char082_break", live2DAssetBundleName = "live2d/char082_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60126] = {id = 60126, type = 5, prefabName = "char_124", prefabNameUI = "char_124UI", mapPrefabName = "char_124m", yardPrefabName = "char_124y", dormPrefabName = "char_124d", assetBundleName = "characters/char_124.prefabs.assetbundle", lihuiID = 15943, headID = 15946, littleHeadID = 15946, DiamondHeadID = 15945, bustID = 15947, bigbustID = 15948, skillHeadID = 15944, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char124_break", live2DAssetBundleName = "live2d/char124_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60127] = {id = 60127, type = 5, prefabName = "char_048_v1", prefabNameUI = "char_048_v1UI", mapPrefabName = "char_048_v1m", yardPrefabName = "char_048_v1y", dormPrefabName = "char_048_v1d", assetBundleName = "characters/char_048_v1.prefabs.assetbundle", lihuiID = 15953, headID = 15956, littleHeadID = 15956, DiamondHeadID = 15955, bustID = 15957, bigbustID = 15958, skillHeadID = 15954, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char048_v1", live2DAssetBundleName = "live2d/char048_v1.assetbundle", live2DScale = 3, photoScale = 2.4, 
photoLocation = {0, 0}
, SteadyState = 1}
, 
[60128] = {id = 60128, type = 5, prefabName = "char_116", prefabNameUI = "char_116UI", mapPrefabName = "char_116m", yardPrefabName = "char_116y", dormPrefabName = "char_116d", assetBundleName = "characters/char_116.prefabs.assetbundle", lihuiID = 15967, headID = 15970, littleHeadID = 15970, DiamondHeadID = 15969, bustID = 15971, bigbustID = 15972, skillHeadID = 15968, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char116_break", live2DAssetBundleName = "live2d/char116_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60129] = {id = 60129, type = 5, prefabName = "char_093", prefabNameUI = "char_093UI", mapPrefabName = "char_093m", yardPrefabName = "char_093y", dormPrefabName = "char_093d", assetBundleName = "characters/char_093.prefabs.assetbundle", lihuiID = 15991, headID = 15994, littleHeadID = 15994, DiamondHeadID = 15993, bustID = 15995, bigbustID = 15996, skillHeadID = 15992, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char093_break", live2DAssetBundleName = "live2d/char093_break.assetbundle", live2DScale = 2.3, photoScale = 2.5, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60130] = {id = 60130, type = 5, prefabName = "char_118", prefabNameUI = "char_118UI", mapPrefabName = "char_118m", yardPrefabName = "char_118y", dormPrefabName = "char_118d", assetBundleName = "characters/char_118.prefabs.assetbundle", lihuiID = 16023, headID = 16026, littleHeadID = 16026, DiamondHeadID = 16025, bustID = 16027, bigbustID = 16028, skillHeadID = 16024, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char118_break", live2DAssetBundleName = "live2d/char118_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60131] = {id = 60131, type = 5, prefabName = "char_126", prefabNameUI = "char_126UI", mapPrefabName = "char_126m", yardPrefabName = "char_126y", dormPrefabName = "char_126d", assetBundleName = "characters/char_126.prefabs.assetbundle", lihuiID = 16043, headID = 16046, littleHeadID = 16046, DiamondHeadID = 16045, bustID = 16047, bigbustID = 16048, skillHeadID = 16044, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char126_break", live2DAssetBundleName = "live2d/char126_break.assetbundle", live2DScale = 2.8, photoScale = 2.6, 
photoLocation = {-17, -17}
, SteadyState = 1}
, 
[60133] = {id = 60133, type = 5, prefabName = "char_130", prefabNameUI = "char_130UI", mapPrefabName = "char_130m", yardPrefabName = "char_130y", dormPrefabName = "char_130d", assetBundleName = "characters/char_130.prefabs.assetbundle", lihuiID = 16091, headID = 16094, littleHeadID = 16094, DiamondHeadID = 16093, bustID = 16095, bigbustID = 16096, skillHeadID = 16092, drawShowID = 0, battleEmotion = "1", live2DPrefabName = "char130_break", live2DAssetBundleName = "live2d/char130_break.assetbundle", live2DScale = 2.5, photoScale = 2.5, 
photoLocation = {-17, -17}
, SteadyState = 1}
}
cnpcshape.AllIds = {1, 9, 10, 11, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1142, 5001, 5002, 5003, 5004, 5005, 5006, 5007, 5008, 5009, 5010, 5011, 5012, 5013, 5014, 5015, 5016, 5017, 5018, 5019, 5020, 5021, 5022, 5023, 5024, 5025, 5026, 5027, 5028, 5029, 5030, 5031, 5032, 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10046, 10047, 10048, 10049, 10050, 10051, 10052, 10053, 10054, 10055, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020, 20021, 20022, 20023, 20024, 20025, 20026, 20027, 20028, 20029, 20030, 20031, 20032, 20033, 20034, 20035, 20036, 20037, 20038, 20039, 20040, 20041, 20042, 20043, 20044, 20045, 20046, 20047, 20048, 20049, 20050, 20051, 20052, 20053, 20054, 20055, 20056, 20057, 20058, 20059, 20060, 20061, 20062, 20063, 20064, 20065, 20066, 20067, 20068, 20069, 20070, 20071, 20072, 20073, 20074, 20075, 20076, 20077, 20078, 20079, 20080, 20081, 20082, 20083, 20084, 20085, 20086, 20087, 20088, 20089, 20090, 20091, 20092, 20093, 20094, 20095, 20096, 20097, 20098, 20099, 20100, 20101, 20102, 20103, 20104, 20105, 20106, 20107, 20108, 20109, 20110, 20111, 20112, 20113, 20114, 20115, 20116, 20117, 20118, 20119, 20120, 20121, 20122, 20123, 20124, 20125, 20126, 20127, 20128, 20129, 20130, 20131, 20132, 20133, 20134, 20135, 20136, 20137, 20138, 20139, 20140, 20141, 20142, 20143, 20144, 20145, 20146, 20147, 20148, 20149, 20150, 20151, 20152, 20153, 20154, 20155, 20156, 20157, 20158, 20159, 20160, 20161, 20162, 20163, 20164, 20165, 20166, 20167, 20168, 20169, 20170, 20171, 20172, 20173, 20174, 20175, 20176, 20177, 20178, 20179, 20180, 20181, 20182, 20183, 20184, 20185, 20186, 20187, 20188, 20189, 20190, 20191, 20192, 20193, 20194, 20195, 20196, 20197, 20198, 20199, 20200, 20201, 20202, 20203, 20204, 20205, 20206, 20207, 20208, 20209, 20210, 20211, 20212, 20213, 20214, 20215, 20216, 50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014, 50015, 50016, 50017, 50018, 50019, 50020, 50021, 50022, 50023, 50024, 50025, 50026, 50027, 50028, 60001, 60002, 60003, 60004, 60005, 60006, 60007, 60008, 60009, 60010, 60011, 60012, 60013, 60014, 60015, 60016, 60017, 60018, 60019, 60020, 60021, 60022, 60023, 60024, 60025, 60026, 60027, 60028, 60029, 60030, 60031, 60032, 60033, 60034, 60035, 60036, 60037, 60038, 60039, 60040, 60041, 60042, 60043, 60044, 60045, 60046, 60047, 60048, 60049, 60050, 60051, 60052, 60053, 60054, 60055, 60056, 60057, 60058, 60059, 60060, 60061, 60062, 60063, 60064, 60065, 60066, 60067, 60068, 60069, 60070, 60071, 60072, 60073, 60074, 60075, 60076, 60077, 60078, 60079, 60080, 60081, 60083, 60084, 60085, 60086, 60087, 60088, 60089, 60090, 60091, 60092, 60093, 60094, 60095, 60096, 60097, 60098, 60099, 60100, 60101, 60102, 60103, 60104, 60105, 60106, 60107, 60108, 60109, 60110, 60116, 60117, 60118, 60119, 60120, 60121, 60122, 60123, 60124, 60125, 60126, 60127, 60128, 60129, 60130, 60131, 60133}
return cnpcshape

