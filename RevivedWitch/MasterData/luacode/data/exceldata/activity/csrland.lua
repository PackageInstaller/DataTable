-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/activity/csrland.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csrland = {}
csrland.Data = {
[2] = {id = 2, name = 702277, destribe = 702277, shapeType = 1, functionList = "", landCoordinate = "11,-7", image = 13271, timeCondition = "", prefabName = "Beach_12", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[3] = {id = 3, name = 702278, destribe = 702278, shapeType = 1, functionList = "", landCoordinate = "17,-4", image = 13271, timeCondition = "", prefabName = "Beach_11", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[4] = {id = 4, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,-5", image = 13271, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[5] = {id = 5, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,5", image = 13271, timeCondition = "", prefabName = "Beach_Plane04", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[6] = {id = 6, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,9", image = 13271, timeCondition = "", prefabName = "Beach_12", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[12] = {id = 12, name = 702295, destribe = 702295, shapeType = 1, functionList = "46001501", landCoordinate = "-1,4", image = 13273, timeCondition = "", prefabName = "Beach02_01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[15] = {id = 15, name = 702293, destribe = 702473, shapeType = 1, functionList = "46001306,46001307,46001308,46001309,46001310", landCoordinate = "20,-2", image = 13273, timeCondition = "2022-09-15 04:00:00", prefabName = "Beach02_04", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {-50, 23}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[17] = {id = 17, name = 702294, destribe = 702294, shapeType = 1, functionList = "46001401,46001402", landCoordinate = "4,-2", image = 13270, timeCondition = "", prefabName = "Beach02_06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, -105}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[18] = {id = 18, name = 702296, destribe = 702296, shapeType = 1, functionList = "46001601", landCoordinate = "15,-8", image = 13270, timeCondition = "2022-09-15 04:00:00", prefabName = "Beach02_07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 145}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[21] = {id = 21, name = 702292, destribe = 702472, shapeType = 1, functionList = "46001301,46001302,46001303,46001304,46001305", landCoordinate = "6,-2", image = 0, timeCondition = "", prefabName = "Beach02_10", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {248, 146}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[22] = {id = 22, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,5", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[24] = {id = 24, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,5", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[26] = {id = 26, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,6", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[27] = {id = 27, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,4", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[28] = {id = 28, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,-9", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[29] = {id = 29, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,6", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[30] = {id = 30, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,-8", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[31] = {id = 31, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,6", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[32] = {id = 32, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,5", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[33] = {id = 33, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,1", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[34] = {id = 34, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,7", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[35] = {id = 35, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,5", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[36] = {id = 36, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,5", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[37] = {id = 37, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-5,5", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[38] = {id = 38, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,5", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[39] = {id = 39, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,10", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[40] = {id = 40, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,7", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[41] = {id = 41, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,6", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[42] = {id = 42, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,7", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[43] = {id = 43, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,5", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[44] = {id = 44, name = 702282, destribe = 702480, shapeType = 1, functionList = "46001107", landCoordinate = "14,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[45] = {id = 45, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[46] = {id = 46, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[47] = {id = 47, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[48] = {id = 48, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[49] = {id = 49, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[50] = {id = 50, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[51] = {id = 51, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[52] = {id = 52, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[53] = {id = 53, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[54] = {id = 54, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[55] = {id = 55, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[56] = {id = 56, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[57] = {id = 57, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[58] = {id = 58, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[59] = {id = 59, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[60] = {id = 60, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[61] = {id = 61, name = 702286, destribe = 702466, shapeType = 1, functionList = "46001203", landCoordinate = "3,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[62] = {id = 62, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-7", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[63] = {id = 63, name = 702287, destribe = 702467, shapeType = 1, functionList = "46001204", landCoordinate = "10,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[64] = {id = 64, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[65] = {id = 65, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[66] = {id = 66, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-6", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[67] = {id = 67, name = 702289, destribe = 702469, shapeType = 1, functionList = "46001206", landCoordinate = "14,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[68] = {id = 68, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[69] = {id = 69, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-6", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[70] = {id = 70, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[71] = {id = 71, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[72] = {id = 72, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[73] = {id = 73, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[74] = {id = 74, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,3", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[75] = {id = 75, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,4", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[76] = {id = 76, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[77] = {id = 77, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[78] = {id = 78, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[79] = {id = 79, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[80] = {id = 80, name = 702279, destribe = 702477, shapeType = 1, functionList = "46001104", landCoordinate = "7,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[81] = {id = 81, name = 702278, destribe = 702476, shapeType = 1, functionList = "46001103", landCoordinate = "0,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[82] = {id = 82, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[83] = {id = 83, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[84] = {id = 84, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,0", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[85] = {id = 85, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,0", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[86] = {id = 86, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[87] = {id = 87, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,-8", image = 0, timeCondition = "", prefabName = "Beach_Plane04", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[88] = {id = 88, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "3,0", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[90] = {id = 90, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,3", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[91] = {id = 91, name = 702284, destribe = 702482, shapeType = 1, functionList = "46001201", landCoordinate = "-1,7", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[93] = {id = 93, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,6", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[94] = {id = 94, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,2", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[95] = {id = 95, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,5", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[96] = {id = 96, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-6,6", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[98] = {id = 98, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,2", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[99] = {id = 99, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,7", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[100] = {id = 100, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,6", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[101] = {id = 101, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "3,6", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[102] = {id = 102, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,-9", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[103] = {id = 103, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,-3", image = 0, timeCondition = "", prefabName = "Beach_11", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[104] = {id = 104, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "23,-11", image = 0, timeCondition = "", prefabName = "Beach_11", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[105] = {id = 105, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "20,1", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[106] = {id = 106, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,2", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[107] = {id = 107, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,4", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[108] = {id = 108, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,7", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[109] = {id = 109, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-3,3", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[110] = {id = 110, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,3", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[111] = {id = 111, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,0", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[112] = {id = 112, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,8", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[113] = {id = 113, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,3", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[114] = {id = 114, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,7", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[116] = {id = 116, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,0", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[117] = {id = 117, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,5", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[119] = {id = 119, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,5", image = 0, timeCondition = "", prefabName = "Beach_13", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[120] = {id = 120, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,9", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[121] = {id = 121, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,0", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[123] = {id = 123, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,8", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[127] = {id = 127, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,1", image = 0, timeCondition = "", prefabName = "Beach_15", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[128] = {id = 128, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,3", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[129] = {id = 129, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,1", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[130] = {id = 130, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,9", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[131] = {id = 131, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-3,6", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[132] = {id = 132, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,6", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[134] = {id = 134, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-3,8", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[135] = {id = 135, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,8", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[136] = {id = 136, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[137] = {id = 137, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,-9", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[138] = {id = 138, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[139] = {id = 139, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,-8", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[140] = {id = 140, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[141] = {id = 141, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-11", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[143] = {id = 143, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[144] = {id = 144, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[145] = {id = 145, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-7", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[146] = {id = 146, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[147] = {id = 147, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[148] = {id = 148, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[149] = {id = 149, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,-8", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[150] = {id = 150, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[151] = {id = 151, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "3,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[152] = {id = 152, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[153] = {id = 153, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[154] = {id = 154, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[155] = {id = 155, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[156] = {id = 156, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[157] = {id = 157, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-6", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[158] = {id = 158, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[160] = {id = 160, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "3,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[161] = {id = 161, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[162] = {id = 162, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[163] = {id = 163, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[165] = {id = 165, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[166] = {id = 166, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,-6", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[167] = {id = 167, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "20,0", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[168] = {id = 168, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-10", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[169] = {id = 169, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,-10", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[170] = {id = 170, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,3", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[171] = {id = 171, name = 702290, destribe = 702470, shapeType = 1, functionList = "46001207", landCoordinate = "17,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[172] = {id = 172, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,3", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[173] = {id = 173, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[174] = {id = 174, name = 702288, destribe = 702468, shapeType = 1, functionList = "46001205", landCoordinate = "11,3", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[175] = {id = 175, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,-10", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[176] = {id = 176, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[177] = {id = 177, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[178] = {id = 178, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,-11", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[179] = {id = 179, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,2", image = 0, timeCondition = "", prefabName = "Beach_Plane04", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[180] = {id = 180, name = 702280, destribe = 702478, shapeType = 1, functionList = "46001105", landCoordinate = "9,4", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[182] = {id = 182, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,1", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[183] = {id = 183, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,2", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[184] = {id = 184, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,0", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[185] = {id = 185, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-5,6", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[186] = {id = 186, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,1", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[187] = {id = 187, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,4", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[188] = {id = 188, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "7,7", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[189] = {id = 189, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,3", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[190] = {id = 190, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,6", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[191] = {id = 191, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,3", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[192] = {id = 192, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "9,7", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[193] = {id = 193, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,2", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[194] = {id = 194, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,6", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[195] = {id = 195, name = 702276, destribe = 702474, shapeType = 1, functionList = "46001101", landCoordinate = "-3,7", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[196] = {id = 196, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,9", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[197] = {id = 197, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,4", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[198] = {id = 198, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-6,7", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[199] = {id = 199, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,9", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[200] = {id = 200, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,2", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[201] = {id = 201, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,9", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[202] = {id = 202, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,11", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[203] = {id = 203, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,9", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[204] = {id = 204, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,10", image = 0, timeCondition = "", prefabName = "Beach_Plane05", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[205] = {id = 205, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "3,5", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[206] = {id = 206, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,7", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[207] = {id = 207, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,7", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[208] = {id = 208, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-5,4", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[209] = {id = 209, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,10", image = 0, timeCondition = "", prefabName = "Beach_14", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[210] = {id = 210, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,10", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[211] = {id = 211, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-1,6", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[215] = {id = 215, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,0", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[216] = {id = 216, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,-9", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[217] = {id = 217, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,1", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[218] = {id = 218, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,0", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[219] = {id = 219, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,2", image = 0, timeCondition = "", prefabName = "Beach_Plane01", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[220] = {id = 220, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,2", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[221] = {id = 221, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[222] = {id = 222, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[223] = {id = 223, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[225] = {id = 225, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-7,7", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[227] = {id = 227, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,11", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[229] = {id = 229, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,7", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[230] = {id = 230, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,8", image = 0, timeCondition = "", prefabName = "Beach_Plane06", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[235] = {id = 235, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,4", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[236] = {id = 236, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,4", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[237] = {id = 237, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "0,6", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[238] = {id = 238, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,5", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[239] = {id = 239, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,6", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[241] = {id = 241, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,6", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[242] = {id = 242, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "5,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[243] = {id = 243, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,3", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[244] = {id = 244, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[245] = {id = 245, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,3", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[246] = {id = 246, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "1,1", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[247] = {id = 247, name = 702285, destribe = 702465, shapeType = 1, functionList = "46001202", landCoordinate = "1,2", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[248] = {id = 248, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "2,2", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[249] = {id = 249, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,0", image = 0, timeCondition = "", prefabName = "Beach_Plane02", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[250] = {id = 250, name = 702277, destribe = 702475, shapeType = 1, functionList = "46001102", landCoordinate = "-1,2", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[251] = {id = 251, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "-2,6", image = 0, timeCondition = "", prefabName = "Beach_Plane07", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[254] = {id = 254, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[255] = {id = 255, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,6", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[256] = {id = 256, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,7", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[257] = {id = 257, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[258] = {id = 258, name = 702281, destribe = 702479, shapeType = 1, functionList = "46001106", landCoordinate = "12,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[259] = {id = 259, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[260] = {id = 260, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[261] = {id = 261, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[262] = {id = 262, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[263] = {id = 263, name = 702283, destribe = 702481, shapeType = 1, functionList = "46001108", landCoordinate = "18,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[264] = {id = 264, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[265] = {id = 265, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "18,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[266] = {id = 266, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[267] = {id = 267, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[268] = {id = 268, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "17,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[269] = {id = 269, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "16,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[270] = {id = 270, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "12,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[271] = {id = 271, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "15,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[272] = {id = 272, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "11,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[273] = {id = 273, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "13,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[274] = {id = 274, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "14,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[275] = {id = 275, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "20,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[276] = {id = 276, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,-2", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[277] = {id = 277, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,-1", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[278] = {id = 278, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,0", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[279] = {id = 279, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-3", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[280] = {id = 280, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[281] = {id = 281, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[282] = {id = 282, name = 702291, destribe = 702471, shapeType = 1, functionList = "46001208", landCoordinate = "20,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[283] = {id = 283, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "19,-4", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[284] = {id = 284, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "21,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[285] = {id = 285, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "22,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[286] = {id = 286, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "20,-5", image = 0, timeCondition = "", prefabName = "Beach_Plane03", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "", fogAssetBundle = ""}
, 
[287] = {id = 287, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "4,2", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[288] = {id = 288, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,2", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[289] = {id = 289, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,2", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[290] = {id = 290, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "6,0", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[291] = {id = 291, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "8,0", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
, 
[292] = {id = 292, name = 0, destribe = 0, shapeType = 1, functionList = "", landCoordinate = "10,0", image = 0, timeCondition = "", prefabName = "Beach_Plane00_none", assetBundle = "sceneobjects/beach_area.prefabs.assetbundle", 
fogOffset = {0, -5}
, 
titleOffset = {0, 1}
, fogPrefabName = "Sence_TX_beach2_2", fogAssetBundle = "effects/particles.prefabs.assetbundle"}
}
csrland.AllIds = {2, 3, 4, 5, 6, 12, 15, 17, 18, 21, 22, 24, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 90, 91, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 116, 117, 119, 120, 121, 123, 127, 128, 129, 130, 131, 132, 134, 135, 136, 137, 138, 139, 140, 141, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 160, 161, 162, 163, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 215, 216, 217, 218, 219, 220, 221, 222, 223, 225, 227, 229, 230, 235, 236, 237, 238, 239, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292}
return csrland

