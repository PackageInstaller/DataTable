-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/item/cfurnitureitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cfurnitureitem = {}
cfurnitureitem.Data = {
[80001] = {id = 80001, type = 1, level = 1, comfortPoint = 10, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80002] = {id = 80002, type = 2, level = 4, comfortPoint = 10, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80003] = {id = 80003, type = 3, level = 6, comfortPoint = 15, cover = "4*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_window_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80004] = {id = 80004, type = 4, level = 3, comfortPoint = 15, cover = "4*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 2, prefabName = "dorm_large_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80005] = {id = 80005, type = 4, level = 3, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80006] = {id = 80006, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80007] = {id = 80007, type = 5, level = 3, comfortPoint = 10, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80008] = {id = 80008, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80009] = {id = 80009, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80010] = {id = 80010, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80011] = {id = 80011, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80012] = {id = 80012, type = 6, level = 2, comfortPoint = 10, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80013] = {id = 80013, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80014] = {id = 80014, type = 7, level = 6, comfortPoint = 10, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80015] = {id = 80015, type = 7, level = 6, comfortPoint = 10, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80016] = {id = 80016, type = 7, level = 6, comfortPoint = 10, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80017] = {id = 80017, type = 7, level = 6, comfortPoint = 10, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80051] = {id = 80051, type = 5, level = 3, comfortPoint = 20, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80052] = {id = 80052, type = 5, level = 3, comfortPoint = 20, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80053] = {id = 80053, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80054] = {id = 80054, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80055] = {id = 80055, type = 5, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80056] = {id = 80056, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80057] = {id = 80057, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_b09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80058] = {id = 80058, type = 4, level = 3, comfortPoint = 20, cover = "6*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 2, prefabName = "dorm_large_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80059] = {id = 80059, type = 7, level = 6, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80060] = {id = 80060, type = 7, level = 6, comfortPoint = 20, cover = "2*2", 
putRange = {"1,6", "20,7"}
, putRangeShow = 4, prefabName = "dorm_wallobj_b02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80061] = {id = 80061, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_b03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80062] = {id = 80062, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_b04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80063] = {id = 80063, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_b05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80064] = {id = 80064, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_b06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80065] = {id = 80065, type = 3, level = 6, comfortPoint = 20, cover = "3*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_window_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80066] = {id = 80066, type = 1, level = 1, comfortPoint = 15, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80067] = {id = 80067, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80068] = {id = 80068, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_b01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80101] = {id = 80101, type = 4, level = 3, comfortPoint = 15, cover = "4*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 2, prefabName = "dorm_large_c01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80102] = {id = 80102, type = 4, level = 3, comfortPoint = 15, cover = "6*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 2, prefabName = "dorm_large_c02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80103] = {id = 80103, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80104] = {id = 80104, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80105] = {id = 80105, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80106] = {id = 80106, type = 5, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80107] = {id = 80107, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80108] = {id = 80108, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80109] = {id = 80109, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80110] = {id = 80110, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_c08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80111] = {id = 80111, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,6", "20,7"}
, putRangeShow = 4, prefabName = "dorm_wallobj_c01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80112] = {id = 80112, type = 7, level = 6, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_c02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80113] = {id = 80113, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_c03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80114] = {id = 80114, type = 3, level = 6, comfortPoint = 15, cover = "4*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_window_c01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80115] = {id = 80115, type = 1, level = 1, comfortPoint = 15, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80116] = {id = 80116, type = 2, level = 4, comfortPoint = 15, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_c01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80117] = {id = 80117, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_c02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80118] = {id = 80118, type = 4, level = 3, comfortPoint = 20, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_d02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80119] = {id = 80119, type = 4, level = 3, comfortPoint = 20, cover = "8*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_d01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80120] = {id = 80120, type = 7, level = 6, comfortPoint = 15, cover = "4*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_d02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80121] = {id = 80121, type = 5, level = 3, comfortPoint = 15, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_d01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80122] = {id = 80122, type = 1, level = 1, comfortPoint = 15, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_floor_d01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80123] = {id = 80123, type = 2, level = 4, comfortPoint = 15, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_wall_d01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80124] = {id = 80124, type = 4, level = 3, comfortPoint = 20, cover = "3*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_d03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80125] = {id = 80125, type = 7, level = 6, comfortPoint = 20, cover = "4*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_d01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80126] = {id = 80126, type = 5, level = 3, comfortPoint = 15, cover = "3*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_t01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80127] = {id = 80127, type = 7, level = 6, comfortPoint = 10, cover = "4*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_t01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80128] = {id = 80128, type = 5, level = 3, comfortPoint = 15, cover = "3*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_h01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80129] = {id = 80129, type = 7, level = 6, comfortPoint = 10, cover = "4*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_wallobj_h01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80130] = {id = 80130, type = 2, level = 4, comfortPoint = 15, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_wall_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80131] = {id = 80131, type = 1, level = 1, comfortPoint = 15, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_floor_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80132] = {id = 80132, type = 7, level = 6, comfortPoint = 90, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_wallobj_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80133] = {id = 80133, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80134] = {id = 80134, type = 4, level = 3, comfortPoint = 20, cover = "6*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80135] = {id = 80135, type = 5, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80136] = {id = 80136, type = 4, level = 3, comfortPoint = 25, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_e03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80137] = {id = 80137, type = 4, level = 3, comfortPoint = 20, cover = "4*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_e02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80138] = {id = 80138, type = 5, level = 3, comfortPoint = 10, cover = "1*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80139] = {id = 80139, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80140] = {id = 80140, type = 6, level = 2, comfortPoint = 15, cover = "7*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_e02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80141] = {id = 80141, type = 6, level = 2, comfortPoint = 15, cover = "7*2", 
putRange = {"1,3", "20,4"}
, putRangeShow = 1, prefabName = "dorm_carpet_e01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80142] = {id = 80142, type = 5, level = 3, comfortPoint = 50, cover = "1*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80143] = {id = 80143, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_bilibili", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80144] = {id = 80144, type = 5, level = 3, comfortPoint = 50, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_e08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80145] = {id = 80145, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_other", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80146] = {id = 80146, type = 4, level = 3, comfortPoint = 20, cover = "4*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_kaze", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80147] = {id = 80147, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_AcFun", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80148] = {id = 80148, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_potato", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80149] = {id = 80149, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_witchpillow", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80150] = {id = 80150, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_large_Anemone", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80151] = {id = 80151, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,2", "20,7"}
, putRangeShow = 3, prefabName = "dorm_sum_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80152] = {id = 80152, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_sum_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80153] = {id = 80153, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_sum_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80154] = {id = 80154, type = 4, level = 3, comfortPoint = 20, cover = "5*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80155] = {id = 80155, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80156] = {id = 80156, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80157] = {id = 80157, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80158] = {id = 80158, type = 5, level = 3, comfortPoint = 20, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80159] = {id = 80159, type = 4, level = 3, comfortPoint = 20, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80160] = {id = 80160, type = 4, level = 3, comfortPoint = 20, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80161] = {id = 80161, type = 5, level = 3, comfortPoint = 10, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80162] = {id = 80162, type = 5, level = 3, comfortPoint = 10, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_sum_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80163] = {id = 80163, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_sum_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80164] = {id = 80164, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_sum_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80168] = {id = 80168, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_hallowood_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80169] = {id = 80169, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_hallowood_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80170] = {id = 80170, type = 3, level = 6, comfortPoint = 15, cover = "3*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80171] = {id = 80171, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80172] = {id = 80172, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80173] = {id = 80173, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_15", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80174] = {id = 80174, type = 7, level = 6, comfortPoint = 15, cover = "3*1", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80175] = {id = 80175, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_hallowood_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80176] = {id = 80176, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_16", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80177] = {id = 80177, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80178] = {id = 80178, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80179] = {id = 80179, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80180] = {id = 80180, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80181] = {id = 80181, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80182] = {id = 80182, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80183] = {id = 80183, type = 4, level = 3, comfortPoint = 20, cover = "4*1", 
putRange = {"1,3", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80184] = {id = 80184, type = 4, level = 3, comfortPoint = 20, cover = "3*3", 
putRange = {"1,3", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80185] = {id = 80185, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_hallowood_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80186] = {id = 80186, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_cake", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80187] = {id = 80187, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80188] = {id = 80188, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_xmas_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80189] = {id = 80189, type = 5, level = 3, comfortPoint = 50, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80190] = {id = 80190, type = 4, level = 3, comfortPoint = 20, cover = "4*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80191] = {id = 80191, type = 7, level = 6, comfortPoint = 15, cover = "3*1", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_xmas_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80192] = {id = 80192, type = 5, level = 3, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80193] = {id = 80193, type = 3, level = 6, comfortPoint = 15, cover = "3*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_xmas_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80194] = {id = 80194, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80195] = {id = 80195, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_xmas_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80196] = {id = 80196, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80197] = {id = 80197, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80198] = {id = 80198, type = 4, level = 3, comfortPoint = 20, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80199] = {id = 80199, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_xmas_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80200] = {id = 80200, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_xmas_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80201] = {id = 80201, type = 2, level = 4, comfortPoint = 15, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_xmas_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80202] = {id = 80202, type = 1, level = 1, comfortPoint = 15, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_xmas_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80203] = {id = 80203, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_Valentin02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80204] = {id = 80204, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_small_Valentin01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80205] = {id = 80205, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80206] = {id = 80206, type = 4, level = 3, comfortPoint = 20, cover = "2*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80207] = {id = 80207, type = 4, level = 3, comfortPoint = 20, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80208] = {id = 80208, type = 5, level = 3, comfortPoint = 15, cover = "3*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80209] = {id = 80209, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_year_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80210] = {id = 80210, type = 3, level = 6, comfortPoint = 15, cover = "4*4", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_year_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80211] = {id = 80211, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_year_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80212] = {id = 80212, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_year_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80213] = {id = 80213, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_year_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80214] = {id = 80214, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80215] = {id = 80215, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80216] = {id = 80216, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80217] = {id = 80217, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80218] = {id = 80218, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80219] = {id = 80219, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_year_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80220] = {id = 80220, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_year_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80221] = {id = 80221, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_year_15", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80242] = {id = 80242, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_children_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80243] = {id = 80243, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_children_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80244] = {id = 80244, type = 4, level = 3, comfortPoint = 20, cover = "5*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80245] = {id = 80245, type = 4, level = 3, comfortPoint = 20, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80246] = {id = 80246, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_children_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80247] = {id = 80247, type = 7, level = 6, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_children_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80248] = {id = 80248, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80249] = {id = 80249, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80250] = {id = 80250, type = 5, level = 3, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80251] = {id = 80251, type = 5, level = 3, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80252] = {id = 80252, type = 4, level = 3, comfortPoint = 20, cover = "3*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80253] = {id = 80253, type = 7, level = 6, comfortPoint = 15, cover = "4*3", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_children_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80254] = {id = 80254, type = 5, level = 3, comfortPoint = 15, cover = "2*3", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80255] = {id = 80255, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_children_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80256] = {id = 80256, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_children_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80257] = {id = 80257, type = 3, level = 6, comfortPoint = 20, cover = "3*5", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_children_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80258] = {id = 80258, type = 6, level = 2, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_children_15", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80259] = {id = 80259, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_anniversary_", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80260] = {id = 80260, type = 6, level = 2, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_anniversary_15", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80261] = {id = 80261, type = 3, level = 6, comfortPoint = 20, cover = "3*4", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_anniversary_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80262] = {id = 80262, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 3, prefabName = "dorm_anniversary_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80263] = {id = 80263, type = 7, level = 6, comfortPoint = 15, cover = "2*4", 
putRange = {"1,4", "20,7"}
, putRangeShow = 4, prefabName = "dorm_anniversary_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80264] = {id = 80264, type = 7, level = 6, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_anniversary_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80265] = {id = 80265, type = 7, level = 6, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_anniversary_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80266] = {id = 80266, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80267] = {id = 80267, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80268] = {id = 80268, type = 5, level = 3, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80269] = {id = 80269, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80270] = {id = 80270, type = 5, level = 3, comfortPoint = 15, cover = "4*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80271] = {id = 80271, type = 5, level = 3, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80272] = {id = 80272, type = 4, level = 3, comfortPoint = 15, cover = "5*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80273] = {id = 80273, type = 4, level = 3, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80274] = {id = 80274, type = 4, level = 3, comfortPoint = 15, cover = "8*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_anniversary_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80275] = {id = 80275, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_anniversary_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80276] = {id = 80276, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_Halloween_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80277] = {id = 80277, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_Halloween_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80278] = {id = 80278, type = 3, level = 6, comfortPoint = 20, cover = "3*4", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_Halloween_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80279] = {id = 80279, type = 7, level = 6, comfortPoint = 15, cover = "1*3", 
putRange = {"1,4", "20,7"}
, putRangeShow = 3, prefabName = "dorm_Halloween_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80280] = {id = 80280, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_Halloween_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80281] = {id = 80281, type = 7, level = 6, comfortPoint = 15, cover = "1*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_Halloween_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80282] = {id = 80282, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80283] = {id = 80283, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80284] = {id = 80284, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80285] = {id = 80285, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80286] = {id = 80286, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80287] = {id = 80287, type = 6, level = 2, comfortPoint = 15, cover = "4*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_Halloween_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80288] = {id = 80288, type = 4, level = 3, comfortPoint = 15, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80289] = {id = 80289, type = 4, level = 3, comfortPoint = 15, cover = "6*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_Halloween_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80290] = {id = 80290, type = 4, level = 3, comfortPoint = 15, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 2, prefabName = "dorm_Halloween_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80291] = {id = 80291, type = 2, level = 4, comfortPoint = 20, cover = "20*7", 
putRange = {"1,1", "20,7"}
, putRangeShow = 0, prefabName = "dorm_wall_canteen_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80292] = {id = 80292, type = 1, level = 1, comfortPoint = 20, cover = "20*2", 
putRange = {"1,1", "20,4"}
, putRangeShow = 0, prefabName = "dorm_floor_canteen_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80293] = {id = 80293, type = 3, level = 6, comfortPoint = 20, cover = "3*4", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_canteen_11", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80294] = {id = 80294, type = 7, level = 6, comfortPoint = 15, cover = "3*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_canteen_13", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80295] = {id = 80295, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,4", "20,7"}
, putRangeShow = 4, prefabName = "dorm_canteen_10", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80296] = {id = 80296, type = 7, level = 6, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 3, prefabName = "dorm_canteen_12", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80297] = {id = 80297, type = 7, level = 6, comfortPoint = 15, cover = "4*2", 
putRange = {"1,4", "20,7"}
, putRangeShow = 4, prefabName = "dorm_canteen_14", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80298] = {id = 80298, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_01", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80299] = {id = 80299, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_05", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80300] = {id = 80300, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_04", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80301] = {id = 80301, type = 5, level = 3, comfortPoint = 15, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_07", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80302] = {id = 80302, type = 5, level = 3, comfortPoint = 15, cover = "1*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_03", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80303] = {id = 80303, type = 5, level = 3, comfortPoint = 15, cover = "2*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_02", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80304] = {id = 80304, type = 4, level = 3, comfortPoint = 15, cover = "7*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_08", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80305] = {id = 80305, type = 4, level = 3, comfortPoint = 15, cover = "4*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 1, prefabName = "dorm_canteen_06", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80306] = {id = 80306, type = 4, level = 3, comfortPoint = 15, cover = "6*1", 
putRange = {"1,1", "20,4"}
, putRangeShow = 2, prefabName = "dorm_canteen_09", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
, 
[80307] = {id = 80307, type = 6, level = 2, comfortPoint = 15, cover = "2*2", 
putRange = {"1,1", "20,7"}
, putRangeShow = 1, prefabName = "dorm_canteen_15", assetBundle = "sceneobjects/dorm.prefabs.assetbundle"}
}
cfurnitureitem.AllIds = {80001, 80002, 80003, 80004, 80005, 80006, 80007, 80008, 80009, 80010, 80011, 80012, 80013, 80014, 80015, 80016, 80017, 80051, 80052, 80053, 80054, 80055, 80056, 80057, 80058, 80059, 80060, 80061, 80062, 80063, 80064, 80065, 80066, 80067, 80068, 80101, 80102, 80103, 80104, 80105, 80106, 80107, 80108, 80109, 80110, 80111, 80112, 80113, 80114, 80115, 80116, 80117, 80118, 80119, 80120, 80121, 80122, 80123, 80124, 80125, 80126, 80127, 80128, 80129, 80130, 80131, 80132, 80133, 80134, 80135, 80136, 80137, 80138, 80139, 80140, 80141, 80142, 80143, 80144, 80145, 80146, 80147, 80148, 80149, 80150, 80151, 80152, 80153, 80154, 80155, 80156, 80157, 80158, 80159, 80160, 80161, 80162, 80163, 80164, 80168, 80169, 80170, 80171, 80172, 80173, 80174, 80175, 80176, 80177, 80178, 80179, 80180, 80181, 80182, 80183, 80184, 80185, 80186, 80187, 80188, 80189, 80190, 80191, 80192, 80193, 80194, 80195, 80196, 80197, 80198, 80199, 80200, 80201, 80202, 80203, 80204, 80205, 80206, 80207, 80208, 80209, 80210, 80211, 80212, 80213, 80214, 80215, 80216, 80217, 80218, 80219, 80220, 80221, 80242, 80243, 80244, 80245, 80246, 80247, 80248, 80249, 80250, 80251, 80252, 80253, 80254, 80255, 80256, 80257, 80258, 80259, 80260, 80261, 80262, 80263, 80264, 80265, 80266, 80267, 80268, 80269, 80270, 80271, 80272, 80273, 80274, 80275, 80276, 80277, 80278, 80279, 80280, 80281, 80282, 80283, 80284, 80285, 80286, 80287, 80288, 80289, 80290, 80291, 80292, 80293, 80294, 80295, 80296, 80297, 80298, 80299, 80300, 80301, 80302, 80303, 80304, 80305, 80306, 80307}
return cfurnitureitem

