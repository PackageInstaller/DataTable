-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cstaireventtype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstaireventtype = {}
cstaireventtype.Data = {
[1] = {id = 1, eventName = "普通怪物", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_battle_01"}
, 
[2] = {id = 2, eventName = "精英怪物", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_battle_02"}
, 
[3] = {id = 3, eventName = "普通宝箱", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_chest_02"}
, 
[5] = {id = 5, eventName = "极品宝箱", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_chest_03"}
, 
[6] = {id = 6, eventName = "故事", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_event_01"}
, 
[7] = {id = 7, eventName = "BOSS", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_battle_03"}
, 
[8] = {id = 8, eventName = "圣坛", assetBundle = "sceneobjects/tower.prefabs.assetbundle", assetName = "tower_hp_01"}
}
cstaireventtype.AllIds = {1, 2, 3, 5, 6, 7, 8}
return cstaireventtype

