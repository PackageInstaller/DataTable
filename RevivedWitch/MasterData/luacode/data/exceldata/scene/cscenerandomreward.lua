-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/scene/cscenerandomreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cscenerandomreward = {}
cscenerandomreward.Data = {
[3] = {id = 3, sceneID = 12005, type = 2, effect = 100, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_hp_01", crashCubeHeight = 0.4, crashCubeWidth = 0.56}
, 
[4] = {id = 4, sceneID = 12002, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[5] = {id = 5, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[6] = {id = 6, sceneID = 12002, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[8] = {id = 8, sceneID = 12003, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[11] = {id = 11, sceneID = 12003, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[12] = {id = 12, sceneID = 12004, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[14] = {id = 14, sceneID = 12004, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[16] = {id = 16, sceneID = 12005, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[17] = {id = 17, sceneID = 12005, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[19] = {id = 19, sceneID = 12006, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[20] = {id = 20, sceneID = 12006, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[25] = {id = 25, sceneID = 12007, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[26] = {id = 26, sceneID = 12007, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[32] = {id = 32, sceneID = 12008, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[33] = {id = 33, sceneID = 12008, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[34] = {id = 34, sceneID = 12008, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[36] = {id = 36, sceneID = 12009, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[37] = {id = 37, sceneID = 12009, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[41] = {id = 41, sceneID = 12010, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[43] = {id = 43, sceneID = 12010, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[46] = {id = 46, sceneID = 12011, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[47] = {id = 47, sceneID = 12011, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[51] = {id = 51, sceneID = 12012, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[52] = {id = 52, sceneID = 12012, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[57] = {id = 57, sceneID = 12013, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[59] = {id = 59, sceneID = 12013, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[64] = {id = 64, sceneID = 12014, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[69] = {id = 69, sceneID = 12015, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[70] = {id = 70, sceneID = 12015, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[71] = {id = 71, sceneID = 12015, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[73] = {id = 73, sceneID = 12016, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[74] = {id = 74, sceneID = 12016, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[78] = {id = 78, sceneID = 12017, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[79] = {id = 79, sceneID = 12017, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[84] = {id = 84, sceneID = 12018, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[90] = {id = 90, sceneID = 12019, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[91] = {id = 91, sceneID = 12019, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[92] = {id = 92, sceneID = 12019, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[93] = {id = 93, sceneID = 12019, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[97] = {id = 97, sceneID = 12020, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[98] = {id = 98, sceneID = 12020, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[102] = {id = 102, sceneID = 12021, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[103] = {id = 103, sceneID = 12021, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[108] = {id = 108, sceneID = 12022, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[109] = {id = 109, sceneID = 12022, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[118] = {id = 118, sceneID = 12024, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[119] = {id = 119, sceneID = 12024, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[121] = {id = 121, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[140] = {id = 140, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[142] = {id = 142, sceneID = 12003, type = 2, effect = 100, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_hp_01", crashCubeHeight = 0.4, crashCubeWidth = 0.56}
, 
[143] = {id = 143, sceneID = 12004, type = 2, effect = 100, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_hp_01", crashCubeHeight = 0.4, crashCubeWidth = 0.56}
, 
[144] = {id = 144, sceneID = 12023, type = 3, effect = 5, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[145] = {id = 145, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[146] = {id = 146, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[147] = {id = 147, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[148] = {id = 148, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[149] = {id = 149, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[150] = {id = 150, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[151] = {id = 151, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[152] = {id = 152, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[153] = {id = 153, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[154] = {id = 154, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[155] = {id = 155, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[156] = {id = 156, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[157] = {id = 157, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[158] = {id = 158, sceneID = 13001, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[159] = {id = 159, sceneID = 13002, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[160] = {id = 160, sceneID = 13002, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[161] = {id = 161, sceneID = 13003, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[162] = {id = 162, sceneID = 13003, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[163] = {id = 163, sceneID = 13004, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[164] = {id = 164, sceneID = 13004, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[165] = {id = 165, sceneID = 13005, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[166] = {id = 166, sceneID = 13005, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[167] = {id = 167, sceneID = 13006, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[168] = {id = 168, sceneID = 13006, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[169] = {id = 169, sceneID = 13007, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[170] = {id = 170, sceneID = 13007, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[171] = {id = 171, sceneID = 13008, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[172] = {id = 172, sceneID = 13008, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[173] = {id = 173, sceneID = 13010, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[174] = {id = 174, sceneID = 13010, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[175] = {id = 175, sceneID = 13011, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[176] = {id = 176, sceneID = 13012, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[177] = {id = 177, sceneID = 13012, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[178] = {id = 178, sceneID = 13013, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[179] = {id = 179, sceneID = 13013, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[180] = {id = 180, sceneID = 13014, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[181] = {id = 181, sceneID = 13014, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[182] = {id = 182, sceneID = 13015, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[183] = {id = 183, sceneID = 13016, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[184] = {id = 184, sceneID = 13016, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[185] = {id = 185, sceneID = 13017, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[186] = {id = 186, sceneID = 13017, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[187] = {id = 187, sceneID = 13017, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[188] = {id = 188, sceneID = 13019, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[189] = {id = 189, sceneID = 13019, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[190] = {id = 190, sceneID = 13020, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[191] = {id = 191, sceneID = 13021, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[192] = {id = 192, sceneID = 13021, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[193] = {id = 193, sceneID = 13022, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[194] = {id = 194, sceneID = 13023, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[195] = {id = 195, sceneID = 13023, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[196] = {id = 196, sceneID = 13024, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[197] = {id = 197, sceneID = 13025, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[198] = {id = 198, sceneID = 13025, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[199] = {id = 199, sceneID = 13026, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[200] = {id = 200, sceneID = 13026, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[201] = {id = 201, sceneID = 13027, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[202] = {id = 202, sceneID = 13027, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[203] = {id = 203, sceneID = 13028, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[204] = {id = 204, sceneID = 13028, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[205] = {id = 205, sceneID = 13029, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[206] = {id = 206, sceneID = 13029, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[207] = {id = 207, sceneID = 13030, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[208] = {id = 208, sceneID = 13031, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[209] = {id = 209, sceneID = 13031, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[210] = {id = 210, sceneID = 13032, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[211] = {id = 211, sceneID = 13032, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[212] = {id = 212, sceneID = 13032, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[213] = {id = 213, sceneID = 13033, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[214] = {id = 214, sceneID = 13033, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[215] = {id = 215, sceneID = 13034, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[216] = {id = 216, sceneID = 13034, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[217] = {id = 217, sceneID = 13009, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[218] = {id = 218, sceneID = 14001, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[219] = {id = 219, sceneID = 14001, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[220] = {id = 220, sceneID = 14002, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[221] = {id = 221, sceneID = 14003, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[222] = {id = 222, sceneID = 14004, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[223] = {id = 223, sceneID = 14004, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[224] = {id = 224, sceneID = 14005, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[225] = {id = 225, sceneID = 14005, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[226] = {id = 226, sceneID = 14006, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[227] = {id = 227, sceneID = 14006, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[228] = {id = 228, sceneID = 14007, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[229] = {id = 229, sceneID = 14007, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[230] = {id = 230, sceneID = 14008, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[231] = {id = 231, sceneID = 14009, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[232] = {id = 232, sceneID = 14009, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[233] = {id = 233, sceneID = 14010, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[234] = {id = 234, sceneID = 14011, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[235] = {id = 235, sceneID = 14012, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[236] = {id = 236, sceneID = 14012, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[237] = {id = 237, sceneID = 14013, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[238] = {id = 238, sceneID = 14013, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[239] = {id = 239, sceneID = 14014, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[240] = {id = 240, sceneID = 14015, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[241] = {id = 241, sceneID = 14015, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[242] = {id = 242, sceneID = 14016, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[243] = {id = 243, sceneID = 14016, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[244] = {id = 244, sceneID = 14017, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[245] = {id = 245, sceneID = 14017, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[246] = {id = 246, sceneID = 14019, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[247] = {id = 247, sceneID = 14019, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[248] = {id = 248, sceneID = 14020, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[249] = {id = 249, sceneID = 14020, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[250] = {id = 250, sceneID = 14021, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[251] = {id = 251, sceneID = 14021, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[252] = {id = 252, sceneID = 14022, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[253] = {id = 253, sceneID = 14022, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[254] = {id = 254, sceneID = 14023, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[255] = {id = 255, sceneID = 14023, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[256] = {id = 256, sceneID = 14024, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[257] = {id = 257, sceneID = 14025, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[258] = {id = 258, sceneID = 14026, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[259] = {id = 259, sceneID = 14026, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[260] = {id = 260, sceneID = 14026, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[261] = {id = 261, sceneID = 14027, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[262] = {id = 262, sceneID = 14027, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[263] = {id = 263, sceneID = 14029, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[264] = {id = 264, sceneID = 14030, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[265] = {id = 265, sceneID = 14030, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[266] = {id = 266, sceneID = 14031, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[267] = {id = 267, sceneID = 14031, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[268] = {id = 268, sceneID = 14032, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[269] = {id = 269, sceneID = 14032, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[270] = {id = 270, sceneID = 14033, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[271] = {id = 271, sceneID = 14033, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[272] = {id = 272, sceneID = 14034, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[273] = {id = 273, sceneID = 14034, type = 3, effect = 5, assetBundle = "sceneobjects/w4.prefabs.assetbundle", assetName = "w4_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[274] = {id = 274, sceneID = 14037, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[275] = {id = 275, sceneID = 14037, type = 3, effect = 5, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[276] = {id = 276, sceneID = 14016, type = 2, effect = 100, assetBundle = "sceneobjects/w2.prefabs.assetbundle", assetName = "w2_m_hp_01", crashCubeHeight = 0.4, crashCubeWidth = 0.56}
, 
[277] = {id = 277, sceneID = 12025, type = 2, effect = 100, assetBundle = "sceneobjects/w1.prefabs.assetbundle", assetName = "w1_m_hp_01", crashCubeHeight = 0.4, crashCubeWidth = 0.56}
, 
[278] = {id = 278, sceneID = 10002, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[279] = {id = 279, sceneID = 10005, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[280] = {id = 280, sceneID = 10007, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[281] = {id = 281, sceneID = 10009, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[282] = {id = 282, sceneID = 10012, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[283] = {id = 283, sceneID = 10013, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[284] = {id = 284, sceneID = 10014, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[285] = {id = 285, sceneID = 10015, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[286] = {id = 286, sceneID = 10017, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[287] = {id = 287, sceneID = 10018, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[288] = {id = 288, sceneID = 10020, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[289] = {id = 289, sceneID = 10022, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[290] = {id = 290, sceneID = 10023, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[291] = {id = 291, sceneID = 10024, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[292] = {id = 292, sceneID = 10025, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[293] = {id = 293, sceneID = 10026, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[294] = {id = 294, sceneID = 10028, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[295] = {id = 295, sceneID = 10029, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[296] = {id = 296, sceneID = 10032, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[297] = {id = 297, sceneID = 10033, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[298] = {id = 298, sceneID = 10033, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[299] = {id = 299, sceneID = 10034, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[300] = {id = 300, sceneID = 10034, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[301] = {id = 301, sceneID = 10035, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[302] = {id = 302, sceneID = 10035, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[303] = {id = 303, sceneID = 10036, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[304] = {id = 304, sceneID = 10036, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[305] = {id = 305, sceneID = 10038, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[306] = {id = 306, sceneID = 10038, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[307] = {id = 307, sceneID = 10039, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[308] = {id = 308, sceneID = 10040, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[309] = {id = 309, sceneID = 10040, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[310] = {id = 310, sceneID = 10037, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[311] = {id = 311, sceneID = 10037, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[312] = {id = 312, sceneID = 15001, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[313] = {id = 313, sceneID = 15001, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[314] = {id = 314, sceneID = 15002, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[315] = {id = 315, sceneID = 15002, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[316] = {id = 316, sceneID = 15003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[317] = {id = 317, sceneID = 15003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[318] = {id = 318, sceneID = 15004, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[319] = {id = 319, sceneID = 15005, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[320] = {id = 320, sceneID = 15005, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[321] = {id = 321, sceneID = 15006, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[322] = {id = 322, sceneID = 15006, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[323] = {id = 323, sceneID = 15006, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[324] = {id = 324, sceneID = 15007, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[325] = {id = 325, sceneID = 15007, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[326] = {id = 326, sceneID = 15008, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[327] = {id = 327, sceneID = 15008, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[328] = {id = 328, sceneID = 15009, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[329] = {id = 329, sceneID = 15009, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[330] = {id = 330, sceneID = 15011, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[331] = {id = 331, sceneID = 15011, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[332] = {id = 332, sceneID = 15012, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[333] = {id = 333, sceneID = 15013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[334] = {id = 334, sceneID = 15013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[335] = {id = 335, sceneID = 15013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[336] = {id = 336, sceneID = 15014, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[337] = {id = 337, sceneID = 15014, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[338] = {id = 338, sceneID = 15015, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[339] = {id = 339, sceneID = 15015, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[340] = {id = 340, sceneID = 15016, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[341] = {id = 341, sceneID = 15016, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[342] = {id = 342, sceneID = 15017, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[343] = {id = 343, sceneID = 15017, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[344] = {id = 344, sceneID = 15018, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[345] = {id = 345, sceneID = 15018, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[346] = {id = 346, sceneID = 15018, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[347] = {id = 347, sceneID = 15019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[348] = {id = 348, sceneID = 15019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[349] = {id = 349, sceneID = 15019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[350] = {id = 350, sceneID = 15020, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[351] = {id = 351, sceneID = 15020, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[352] = {id = 352, sceneID = 15020, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[353] = {id = 353, sceneID = 15021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[354] = {id = 354, sceneID = 15021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[355] = {id = 355, sceneID = 15021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[356] = {id = 356, sceneID = 15022, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[357] = {id = 357, sceneID = 15022, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[358] = {id = 358, sceneID = 15022, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[359] = {id = 359, sceneID = 15023, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[360] = {id = 360, sceneID = 15023, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[361] = {id = 361, sceneID = 15024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[362] = {id = 362, sceneID = 15024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[363] = {id = 363, sceneID = 15024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[364] = {id = 364, sceneID = 15025, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[365] = {id = 365, sceneID = 15025, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[366] = {id = 366, sceneID = 15026, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[367] = {id = 367, sceneID = 15026, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[368] = {id = 368, sceneID = 15026, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[369] = {id = 369, sceneID = 15027, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[370] = {id = 370, sceneID = 15027, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[371] = {id = 371, sceneID = 15028, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[372] = {id = 372, sceneID = 15028, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[373] = {id = 373, sceneID = 15028, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[374] = {id = 374, sceneID = 15029, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[375] = {id = 375, sceneID = 15029, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[376] = {id = 376, sceneID = 15029, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[377] = {id = 377, sceneID = 15030, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[378] = {id = 378, sceneID = 15030, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[379] = {id = 379, sceneID = 15030, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[380] = {id = 380, sceneID = 15031, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[381] = {id = 381, sceneID = 15031, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[382] = {id = 382, sceneID = 15031, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[383] = {id = 383, sceneID = 15032, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[384] = {id = 384, sceneID = 15032, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[385] = {id = 385, sceneID = 15033, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[386] = {id = 386, sceneID = 15033, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[387] = {id = 387, sceneID = 15034, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[388] = {id = 388, sceneID = 15034, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[389] = {id = 389, sceneID = 15034, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[390] = {id = 390, sceneID = 10010, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[391] = {id = 391, sceneID = 10013, type = 3, effect = 5, assetBundle = "sceneobjects/t1.prefabs.assetbundle", assetName = "t1_m_mana_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[392] = {id = 392, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[393] = {id = 393, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[394] = {id = 394, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[395] = {id = 395, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[396] = {id = 396, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[397] = {id = 397, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[398] = {id = 398, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[399] = {id = 399, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[400] = {id = 400, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[401] = {id = 401, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[402] = {id = 402, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[403] = {id = 403, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[404] = {id = 404, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[405] = {id = 405, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[406] = {id = 406, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[407] = {id = 407, sceneID = -1, type = 1, effect = -1, assetBundle = "sceneobjects/common.prefabs.assetbundle", assetName = "com_m_manaJumped", crashCubeHeight = 0.6, crashCubeWidth = 0.5}
, 
[408] = {id = 408, sceneID = 16001, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[409] = {id = 409, sceneID = 16001, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[410] = {id = 410, sceneID = 16001, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[411] = {id = 411, sceneID = 16002, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[412] = {id = 412, sceneID = 16002, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[413] = {id = 413, sceneID = 16002, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[414] = {id = 414, sceneID = 16003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[415] = {id = 415, sceneID = 16003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[416] = {id = 416, sceneID = 16003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[417] = {id = 417, sceneID = 16003, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[418] = {id = 418, sceneID = 16005, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[419] = {id = 419, sceneID = 16005, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[420] = {id = 420, sceneID = 16005, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[421] = {id = 421, sceneID = 16006, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[422] = {id = 422, sceneID = 16006, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[423] = {id = 423, sceneID = 16007, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[424] = {id = 424, sceneID = 16007, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[425] = {id = 425, sceneID = 16007, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[426] = {id = 426, sceneID = 16008, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[427] = {id = 427, sceneID = 16008, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[428] = {id = 428, sceneID = 16009, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[429] = {id = 429, sceneID = 16009, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[430] = {id = 430, sceneID = 16009, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[431] = {id = 431, sceneID = 16010, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[432] = {id = 432, sceneID = 16010, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[433] = {id = 433, sceneID = 16010, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[434] = {id = 434, sceneID = 16011, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[435] = {id = 435, sceneID = 16011, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[436] = {id = 436, sceneID = 16011, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[437] = {id = 437, sceneID = 16012, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[438] = {id = 438, sceneID = 16012, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[439] = {id = 439, sceneID = 16012, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[440] = {id = 440, sceneID = 16013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[441] = {id = 441, sceneID = 16013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[442] = {id = 442, sceneID = 16013, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[443] = {id = 443, sceneID = 16014, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[444] = {id = 444, sceneID = 16014, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[445] = {id = 445, sceneID = 16015, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[446] = {id = 446, sceneID = 16015, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[447] = {id = 447, sceneID = 16015, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[448] = {id = 448, sceneID = 16016, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[449] = {id = 449, sceneID = 16016, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[450] = {id = 450, sceneID = 16016, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[451] = {id = 451, sceneID = 16017, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[452] = {id = 452, sceneID = 16017, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[453] = {id = 453, sceneID = 16017, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[454] = {id = 454, sceneID = 16018, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[455] = {id = 455, sceneID = 16019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[456] = {id = 456, sceneID = 16019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[457] = {id = 457, sceneID = 16019, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[458] = {id = 458, sceneID = 16020, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[459] = {id = 459, sceneID = 16020, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[460] = {id = 460, sceneID = 16021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[461] = {id = 461, sceneID = 16021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[462] = {id = 462, sceneID = 16021, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[463] = {id = 463, sceneID = 16022, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[464] = {id = 464, sceneID = 16022, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[465] = {id = 465, sceneID = 16023, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[466] = {id = 466, sceneID = 16023, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[467] = {id = 467, sceneID = 16024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[468] = {id = 468, sceneID = 16024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[469] = {id = 469, sceneID = 16024, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[470] = {id = 470, sceneID = 16025, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[471] = {id = 471, sceneID = 16025, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[472] = {id = 472, sceneID = 16025, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[473] = {id = 473, sceneID = 16026, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[474] = {id = 474, sceneID = 16026, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[475] = {id = 475, sceneID = 16027, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[476] = {id = 476, sceneID = 16027, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[477] = {id = 477, sceneID = 16028, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[478] = {id = 478, sceneID = 16028, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[479] = {id = 479, sceneID = 16029, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[480] = {id = 480, sceneID = 16029, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_m_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[481] = {id = 481, sceneID = 16030, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[482] = {id = 482, sceneID = 16030, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[483] = {id = 483, sceneID = 16031, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[484] = {id = 484, sceneID = 16031, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[485] = {id = 485, sceneID = 16032, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[486] = {id = 486, sceneID = 16032, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[488] = {id = 488, sceneID = 16033, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[489] = {id = 489, sceneID = 16033, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[490] = {id = 490, sceneID = 16033, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[491] = {id = 491, sceneID = 16034, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
, 
[492] = {id = 492, sceneID = 16034, type = 3, effect = 5, assetBundle = "sceneobjects/w3.prefabs.assetbundle", assetName = "w3_n_manatree_01", crashCubeHeight = 0.4, crashCubeWidth = 0.4}
}
cscenerandomreward.AllIds = {3, 4, 5, 6, 8, 11, 12, 14, 16, 17, 19, 20, 25, 26, 32, 33, 34, 36, 37, 41, 43, 46, 47, 51, 52, 57, 59, 64, 69, 70, 71, 73, 74, 78, 79, 84, 90, 91, 92, 93, 97, 98, 102, 103, 108, 109, 118, 119, 121, 140, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 488, 489, 490, 491, 492}
return cscenerandomreward

