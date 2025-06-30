-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cislandtypeconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cislandtypeconfig = {}
cislandtypeconfig.Data = {
[1] = {id = 1, islandName = "塔内普通怪物", TypeImageid = 10001, worldsType = 1, functionType = 1, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_05", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_01"}
, 
[2] = {id = 2, islandName = "森林普通怪物", TypeImageid = 10001, worldsType = 2, functionType = 1, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_07", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_01"}
, 
[3] = {id = 3, islandName = "冰雪普通怪物", TypeImageid = 10001, worldsType = 3, functionType = 1, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_06", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_01"}
, 
[4] = {id = 4, islandName = "塔内精英怪物", TypeImageid = 10002, worldsType = 1, functionType = 2, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_05", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_02"}
, 
[5] = {id = 5, islandName = "森林精英怪物", TypeImageid = 10002, worldsType = 2, functionType = 2, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_07", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_02"}
, 
[6] = {id = 6, islandName = "冰雪精英怪物", TypeImageid = 10002, worldsType = 3, functionType = 2, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_06", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_02"}
, 
[7] = {id = 7, islandName = "塔内普通宝箱", TypeImageid = 10004, worldsType = 1, functionType = 3, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[8] = {id = 8, islandName = "森林普通宝箱", TypeImageid = 10004, worldsType = 2, functionType = 3, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[9] = {id = 9, islandName = "冰雪普通宝箱", TypeImageid = 10004, worldsType = 3, functionType = 3, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[10] = {id = 10, islandName = "塔内哥布林宝箱", TypeImageid = 10005, worldsType = 1, functionType = 4, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[11] = {id = 11, islandName = "森林哥布林宝箱", TypeImageid = 10005, worldsType = 2, functionType = 4, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[12] = {id = 12, islandName = "冰雪哥布林宝箱", TypeImageid = 10005, worldsType = 3, functionType = 4, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_02"}
, 
[13] = {id = 13, islandName = "塔内极品宝箱", TypeImageid = 10006, worldsType = 1, functionType = 5, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_03"}
, 
[14] = {id = 14, islandName = "森林极品宝箱", TypeImageid = 10006, worldsType = 2, functionType = 5, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_03"}
, 
[15] = {id = 15, islandName = "冰雪极品宝箱", TypeImageid = 10006, worldsType = 3, functionType = 5, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_chest_03"}
, 
[16] = {id = 16, islandName = "塔内事件", TypeImageid = 10007, worldsType = 1, functionType = 6, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_event_01"}
, 
[17] = {id = 17, islandName = "森林事件", TypeImageid = 10007, worldsType = 2, functionType = 6, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_event_01"}
, 
[18] = {id = 18, islandName = "冰雪事件", TypeImageid = 10007, worldsType = 3, functionType = 6, isShow = 0, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_event_01"}
, 
[19] = {id = 19, islandName = "塔内BOSS", TypeImageid = 10003, worldsType = 1, functionType = 7, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_05", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_03"}
, 
[20] = {id = 20, islandName = "森林BOSS", TypeImageid = 10003, worldsType = 2, functionType = 7, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_07", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_03"}
, 
[21] = {id = 21, islandName = "冰雪BOSS", TypeImageid = 10003, worldsType = 3, functionType = 7, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_06", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_battle_03"}
, 
[22] = {id = 22, islandName = "塔内圣坛", TypeImageid = 10008, worldsType = 1, functionType = 8, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_hp_01"}
, 
[23] = {id = 23, islandName = "森林圣坛", TypeImageid = 10008, worldsType = 2, functionType = 8, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_hp_01"}
, 
[24] = {id = 24, islandName = "冰雪圣坛", TypeImageid = 10008, worldsType = 3, functionType = 8, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_hp_01"}
, 
[25] = {id = 25, islandName = "塔内起点", TypeImageid = 0, worldsType = 1, functionType = 99, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "", imgassetName = ""}
, 
[26] = {id = 26, islandName = "森林起点", TypeImageid = 0, worldsType = 2, functionType = 99, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_02", imgassetBundleName = "", imgassetName = ""}
, 
[27] = {id = 27, islandName = "冰雪起点", TypeImageid = 0, worldsType = 3, functionType = 99, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_03", imgassetBundleName = "", imgassetName = ""}
, 
[28] = {id = 28, islandName = "出口", TypeImageid = 10003, worldsType = 0, functionType = 98, isShow = 1, assetBundleName = "", assetName = "", imgassetBundleName = "sceneobjects/tower.prefabs.assetbundle", imgassetName = "Tower_stair"}
, 
[29] = {id = 29, islandName = "商店", TypeImageid = 10009, worldsType = 1, functionType = 9, isShow = 1, assetBundleName = "sceneobjects/tower.prefabs.assetbundle", assetName = "Tower_tile_01", imgassetBundleName = "", imgassetName = ""}
}
cislandtypeconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29}
return cislandtypeconfig

