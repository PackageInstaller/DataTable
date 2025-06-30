-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/buff/cskillchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cskillchange = {}
cskillchange.Data = {
[1] = {id = 1, aSkillId = 201053, buffId = "20105", bSkillId = "201056"}
, 
[2] = {id = 2, aSkillId = 201054, buffId = "20105", bSkillId = "201057"}
, 
[3] = {id = 3, aSkillId = 10017, buffId = "20113", bSkillId = "19017"}
, 
[4] = {id = 4, aSkillId = 10014, buffId = "20045", bSkillId = "6014401"}
, 
[5] = {id = 5, aSkillId = 10014, buffId = "20151", bSkillId = "6014402"}
, 
[6] = {id = 6, aSkillId = 10014, buffId = "20152", bSkillId = "6014403"}
, 
[7] = {id = 7, aSkillId = 10014, buffId = "20153", bSkillId = "6014404"}
, 
[8] = {id = 8, aSkillId = 10014, buffId = "20154", bSkillId = "6014405"}
, 
[9] = {id = 9, aSkillId = 6017101, buffId = "20113", bSkillId = "6017301"}
, 
[10] = {id = 10, aSkillId = 6017102, buffId = "20113", bSkillId = "6017302"}
, 
[11] = {id = 11, aSkillId = 6017103, buffId = "20113", bSkillId = "6017303"}
, 
[12] = {id = 12, aSkillId = 6017104, buffId = "20113", bSkillId = "6017304"}
, 
[13] = {id = 13, aSkillId = 6017105, buffId = "20113", bSkillId = "6017305"}
, 
[14] = {id = 14, aSkillId = 6041201, buffId = "20517", bSkillId = "6041301"}
, 
[15] = {id = 15, aSkillId = 6041202, buffId = "20517", bSkillId = "6041302"}
, 
[16] = {id = 16, aSkillId = 6041203, buffId = "20517", bSkillId = "6041303"}
, 
[17] = {id = 17, aSkillId = 6041204, buffId = "20517", bSkillId = "6041304"}
, 
[18] = {id = 18, aSkillId = 6041205, buffId = "20517", bSkillId = "6041305"}
, 
[19] = {id = 19, aSkillId = 6041201, buffId = "20518", bSkillId = "6041301"}
, 
[20] = {id = 20, aSkillId = 6041202, buffId = "20518", bSkillId = "6041302"}
, 
[21] = {id = 21, aSkillId = 6041203, buffId = "20518", bSkillId = "6041303"}
, 
[22] = {id = 22, aSkillId = 6041204, buffId = "20518", bSkillId = "6041304"}
, 
[23] = {id = 23, aSkillId = 6041205, buffId = "20518", bSkillId = "6041305"}
, 
[24] = {id = 24, aSkillId = 10029, buffId = "20571", bSkillId = "19029"}
, 
[25] = {id = 25, aSkillId = 6022101, buffId = "20609", bSkillId = "6022401"}
, 
[26] = {id = 26, aSkillId = 6022102, buffId = "20609", bSkillId = "6022402"}
, 
[27] = {id = 27, aSkillId = 6022103, buffId = "20609", bSkillId = "6022403"}
, 
[28] = {id = 28, aSkillId = 6022104, buffId = "20609", bSkillId = "6022404"}
, 
[29] = {id = 29, aSkillId = 6022105, buffId = "20609", bSkillId = "6022405"}
, 
[30] = {id = 30, aSkillId = 6022101, buffId = "20610", bSkillId = "6022501"}
, 
[31] = {id = 31, aSkillId = 6022102, buffId = "20610", bSkillId = "6022502"}
, 
[32] = {id = 32, aSkillId = 6022103, buffId = "20610", bSkillId = "6022503"}
, 
[33] = {id = 33, aSkillId = 6022104, buffId = "20610", bSkillId = "6022504"}
, 
[34] = {id = 34, aSkillId = 6022105, buffId = "20610", bSkillId = "6022505"}
, 
[35] = {id = 35, aSkillId = 10061, buffId = "20664", bSkillId = "19061"}
, 
[36] = {id = 36, aSkillId = 10061, buffId = "20665", bSkillId = "18061"}
, 
[37] = {id = 37, aSkillId = 10061, buffId = "20666", bSkillId = "17061"}
, 
[38] = {id = 38, aSkillId = 10061, buffId = "20667", bSkillId = "16061"}
, 
[39] = {id = 39, aSkillId = 10061, buffId = "20668", bSkillId = "15061"}
, 
[40] = {id = 40, aSkillId = 6061101, buffId = "20664;20665;20666;20667;20668", bSkillId = "6061301"}
, 
[41] = {id = 41, aSkillId = 6061102, buffId = "20664;20665;20666;20667;20668", bSkillId = "6061302"}
, 
[42] = {id = 42, aSkillId = 6061103, buffId = "20664;20665;20666;20667;20668", bSkillId = "6061303"}
, 
[43] = {id = 43, aSkillId = 6061104, buffId = "20664;20665;20666;20667;20668", bSkillId = "6061304"}
, 
[44] = {id = 44, aSkillId = 6061105, buffId = "20664;20665;20666;20667;20668", bSkillId = "6061305"}
, 
[45] = {id = 45, aSkillId = 10003, buffId = "20683;20684;20685;20686;20687", bSkillId = "19003"}
, 
[46] = {id = 46, aSkillId = 6003101, buffId = "20683;20684;20685;20686;20687", bSkillId = "6003301"}
, 
[47] = {id = 47, aSkillId = 6003102, buffId = "20683;20684;20685;20686;20687", bSkillId = "6003302"}
, 
[48] = {id = 48, aSkillId = 6003103, buffId = "20683;20684;20685;20686;20687", bSkillId = "6003303"}
, 
[49] = {id = 49, aSkillId = 6003104, buffId = "20683;20684;20685;20686;20687", bSkillId = "6003304"}
, 
[50] = {id = 50, aSkillId = 6003105, buffId = "20683;20684;20685;20686;20687", bSkillId = "6003305"}
, 
[51] = {id = 51, aSkillId = 6075101, buffId = "20688", bSkillId = "6075301"}
, 
[52] = {id = 52, aSkillId = 6075102, buffId = "20688", bSkillId = "6075302"}
, 
[53] = {id = 53, aSkillId = 6075103, buffId = "20688", bSkillId = "6075303"}
, 
[54] = {id = 54, aSkillId = 6075104, buffId = "20688", bSkillId = "6075304"}
, 
[55] = {id = 55, aSkillId = 6075105, buffId = "20688", bSkillId = "6075305"}
, 
[56] = {id = 56, aSkillId = 10075, buffId = "20696", bSkillId = "15075"}
, 
[57] = {id = 57, aSkillId = 10075, buffId = "20697", bSkillId = "16075"}
, 
[58] = {id = 58, aSkillId = 10075, buffId = "20698", bSkillId = "17075"}
, 
[59] = {id = 59, aSkillId = 10075, buffId = "20699", bSkillId = "18075"}
, 
[60] = {id = 60, aSkillId = 10075, buffId = "20700", bSkillId = "19075"}
, 
[66] = {id = 66, aSkillId = 10051, buffId = "20305", bSkillId = "19051"}
, 
[67] = {id = 67, aSkillId = 10067, buffId = "20962", bSkillId = "19067"}
, 
[68] = {id = 68, aSkillId = 6067101, buffId = "20962", bSkillId = "6067301"}
, 
[69] = {id = 69, aSkillId = 6067102, buffId = "20962", bSkillId = "6067302"}
, 
[70] = {id = 70, aSkillId = 6067103, buffId = "20962", bSkillId = "6067303"}
, 
[71] = {id = 71, aSkillId = 6067104, buffId = "20962", bSkillId = "6067304"}
, 
[72] = {id = 72, aSkillId = 6067105, buffId = "20962", bSkillId = "6067305"}
, 
[73] = {id = 73, aSkillId = 6068101, buffId = "20975", bSkillId = "6068301"}
, 
[74] = {id = 74, aSkillId = 6068102, buffId = "20975", bSkillId = "6068302"}
, 
[75] = {id = 75, aSkillId = 6068103, buffId = "20975", bSkillId = "6068303"}
, 
[76] = {id = 76, aSkillId = 6068104, buffId = "20975", bSkillId = "6068304"}
, 
[77] = {id = 77, aSkillId = 6068105, buffId = "20975", bSkillId = "6068305"}
, 
[78] = {id = 78, aSkillId = 6012101, buffId = "21019", bSkillId = "6012401"}
, 
[79] = {id = 79, aSkillId = 6012102, buffId = "21019", bSkillId = "6012402"}
, 
[80] = {id = 80, aSkillId = 6012103, buffId = "21019", bSkillId = "6012403"}
, 
[81] = {id = 81, aSkillId = 6012104, buffId = "21019", bSkillId = "6012404"}
, 
[82] = {id = 82, aSkillId = 6012105, buffId = "21019", bSkillId = "6012405"}
, 
[83] = {id = 83, aSkillId = 6012101, buffId = "21020", bSkillId = "6012501"}
, 
[84] = {id = 84, aSkillId = 6012102, buffId = "21020", bSkillId = "6012502"}
, 
[85] = {id = 85, aSkillId = 6012103, buffId = "21020", bSkillId = "6012503"}
, 
[86] = {id = 86, aSkillId = 6012104, buffId = "21020", bSkillId = "6012504"}
, 
[87] = {id = 87, aSkillId = 6012105, buffId = "21020", bSkillId = "6012505"}
, 
[88] = {id = 88, aSkillId = 6012201, buffId = "21021", bSkillId = "6012301"}
, 
[89] = {id = 89, aSkillId = 6012202, buffId = "21021", bSkillId = "6012302"}
, 
[90] = {id = 90, aSkillId = 6012203, buffId = "21021", bSkillId = "6012303"}
, 
[91] = {id = 91, aSkillId = 6012204, buffId = "21021", bSkillId = "6012304"}
, 
[92] = {id = 92, aSkillId = 6012205, buffId = "21021", bSkillId = "6012305"}
, 
[93] = {id = 93, aSkillId = 6012201, buffId = "21022", bSkillId = "6012601"}
, 
[94] = {id = 94, aSkillId = 6012202, buffId = "21022", bSkillId = "6012602"}
, 
[95] = {id = 95, aSkillId = 6012203, buffId = "21022", bSkillId = "6012603"}
, 
[96] = {id = 96, aSkillId = 6012204, buffId = "21022", bSkillId = "6012604"}
, 
[97] = {id = 97, aSkillId = 6012205, buffId = "21022", bSkillId = "6012605"}
, 
[98] = {id = 98, aSkillId = 6063101, buffId = "21033", bSkillId = "6063301"}
, 
[99] = {id = 99, aSkillId = 6063102, buffId = "21033", bSkillId = "6063302"}
, 
[100] = {id = 100, aSkillId = 6063103, buffId = "21033", bSkillId = "6063303"}
, 
[101] = {id = 101, aSkillId = 6063104, buffId = "21033", bSkillId = "6063304"}
, 
[102] = {id = 102, aSkillId = 6063105, buffId = "21033", bSkillId = "6063305"}
, 
[103] = {id = 103, aSkillId = 6038701, buffId = "20592", bSkillId = "60381001"}
, 
[104] = {id = 104, aSkillId = 6038702, buffId = "20592", bSkillId = "60381002"}
, 
[105] = {id = 105, aSkillId = 6038703, buffId = "20592", bSkillId = "60381003"}
, 
[106] = {id = 106, aSkillId = 6038704, buffId = "20592", bSkillId = "60381004"}
, 
[107] = {id = 107, aSkillId = 6038705, buffId = "20592", bSkillId = "60381005"}
, 
[108] = {id = 108, aSkillId = 6038701, buffId = "20590", bSkillId = "60381201"}
, 
[109] = {id = 109, aSkillId = 6038702, buffId = "20590", bSkillId = "60381202"}
, 
[110] = {id = 110, aSkillId = 6038703, buffId = "20590", bSkillId = "60381203"}
, 
[111] = {id = 111, aSkillId = 6038704, buffId = "20590", bSkillId = "60381204"}
, 
[112] = {id = 112, aSkillId = 6038705, buffId = "20590", bSkillId = "60381205"}
, 
[113] = {id = 113, aSkillId = 6038701, buffId = "20591", bSkillId = "60381101"}
, 
[114] = {id = 114, aSkillId = 6038702, buffId = "20591", bSkillId = "60381102"}
, 
[115] = {id = 115, aSkillId = 6038703, buffId = "20591", bSkillId = "60381103"}
, 
[116] = {id = 116, aSkillId = 6038704, buffId = "20591", bSkillId = "60381104"}
, 
[117] = {id = 117, aSkillId = 6038705, buffId = "20591", bSkillId = "60381105"}
, 
[118] = {id = 118, aSkillId = 6038801, buffId = "20592", bSkillId = "6038201"}
, 
[119] = {id = 119, aSkillId = 6038802, buffId = "20592", bSkillId = "6038202"}
, 
[120] = {id = 120, aSkillId = 6038803, buffId = "20592", bSkillId = "6038203"}
, 
[121] = {id = 121, aSkillId = 6038804, buffId = "20592", bSkillId = "6038204"}
, 
[122] = {id = 122, aSkillId = 6038805, buffId = "20592", bSkillId = "6038205"}
, 
[123] = {id = 123, aSkillId = 6038801, buffId = "20590", bSkillId = "6038401"}
, 
[124] = {id = 124, aSkillId = 6038802, buffId = "20590", bSkillId = "6038402"}
, 
[125] = {id = 125, aSkillId = 6038803, buffId = "20590", bSkillId = "6038403"}
, 
[126] = {id = 126, aSkillId = 6038804, buffId = "20590", bSkillId = "6038404"}
, 
[127] = {id = 127, aSkillId = 6038805, buffId = "20590", bSkillId = "6038405"}
, 
[128] = {id = 128, aSkillId = 6038801, buffId = "20591", bSkillId = "6038601"}
, 
[129] = {id = 129, aSkillId = 6038802, buffId = "20591", bSkillId = "6038602"}
, 
[130] = {id = 130, aSkillId = 6038803, buffId = "20591", bSkillId = "6038603"}
, 
[131] = {id = 131, aSkillId = 6038804, buffId = "20591", bSkillId = "6038604"}
, 
[132] = {id = 132, aSkillId = 6038805, buffId = "20591", bSkillId = "6038605"}
, 
[133] = {id = 133, aSkillId = 6017201, buffId = "20113", bSkillId = "6017401"}
, 
[134] = {id = 134, aSkillId = 6017202, buffId = "20113", bSkillId = "6017402"}
, 
[135] = {id = 135, aSkillId = 6017203, buffId = "20113", bSkillId = "6017403"}
, 
[136] = {id = 136, aSkillId = 6017204, buffId = "20113", bSkillId = "6017404"}
, 
[137] = {id = 137, aSkillId = 6017205, buffId = "20113", bSkillId = "6017405"}
, 
[138] = {id = 138, aSkillId = 6025101, buffId = "20480", bSkillId = "6025301"}
, 
[139] = {id = 139, aSkillId = 6025102, buffId = "20480", bSkillId = "6025302"}
, 
[140] = {id = 140, aSkillId = 6025103, buffId = "20480", bSkillId = "6025303"}
, 
[141] = {id = 141, aSkillId = 6025104, buffId = "20480", bSkillId = "6025304"}
, 
[142] = {id = 142, aSkillId = 6025105, buffId = "20480", bSkillId = "6025305"}
, 
[147] = {id = 147, aSkillId = 6083201, buffId = "21454", bSkillId = "6083301"}
, 
[148] = {id = 148, aSkillId = 6083202, buffId = "21454", bSkillId = "6083302"}
, 
[149] = {id = 149, aSkillId = 6083203, buffId = "21454", bSkillId = "6083303"}
, 
[150] = {id = 150, aSkillId = 6083204, buffId = "21454", bSkillId = "6083304"}
, 
[151] = {id = 151, aSkillId = 6083205, buffId = "21454", bSkillId = "6083305"}
, 
[152] = {id = 152, aSkillId = 6095201, buffId = "21445", bSkillId = "6095301"}
, 
[153] = {id = 153, aSkillId = 6095202, buffId = "21445", bSkillId = "6095302"}
, 
[154] = {id = 154, aSkillId = 6095203, buffId = "21445", bSkillId = "6095303"}
, 
[155] = {id = 155, aSkillId = 6095204, buffId = "21445", bSkillId = "6095304"}
, 
[156] = {id = 156, aSkillId = 6095205, buffId = "21445", bSkillId = "6095305"}
, 
[157] = {id = 157, aSkillId = 6066101, buffId = "21574", bSkillId = "6066301"}
, 
[158] = {id = 158, aSkillId = 6066102, buffId = "21574", bSkillId = "6066302"}
, 
[159] = {id = 159, aSkillId = 6066103, buffId = "21574", bSkillId = "6066303"}
, 
[160] = {id = 160, aSkillId = 6066104, buffId = "21574", bSkillId = "6066304"}
, 
[161] = {id = 161, aSkillId = 6066105, buffId = "21574", bSkillId = "6066305"}
, 
[162] = {id = 162, aSkillId = 6066101, buffId = "21575", bSkillId = "6066401"}
, 
[163] = {id = 163, aSkillId = 6066102, buffId = "21575", bSkillId = "6066402"}
, 
[164] = {id = 164, aSkillId = 6066103, buffId = "21575", bSkillId = "6066403"}
, 
[165] = {id = 165, aSkillId = 6066104, buffId = "21575", bSkillId = "6066404"}
, 
[166] = {id = 166, aSkillId = 6066105, buffId = "21575", bSkillId = "6066405"}
, 
[167] = {id = 167, aSkillId = 6039201, buffId = "21602", bSkillId = "6039301"}
, 
[168] = {id = 168, aSkillId = 6039202, buffId = "21602", bSkillId = "6039302"}
, 
[169] = {id = 169, aSkillId = 6039203, buffId = "21602", bSkillId = "6039303"}
, 
[170] = {id = 170, aSkillId = 6039204, buffId = "21602", bSkillId = "6039304"}
, 
[171] = {id = 171, aSkillId = 6039205, buffId = "21602", bSkillId = "6039305"}
, 
[172] = {id = 172, aSkillId = 6039101, buffId = "21602", bSkillId = "6039111"}
, 
[173] = {id = 173, aSkillId = 6039102, buffId = "21602", bSkillId = "6039112"}
, 
[174] = {id = 174, aSkillId = 6039103, buffId = "21602", bSkillId = "6039113"}
, 
[175] = {id = 175, aSkillId = 6039104, buffId = "21602", bSkillId = "6039114"}
, 
[176] = {id = 176, aSkillId = 6039105, buffId = "21602", bSkillId = "6039115"}
, 
[177] = {id = 177, aSkillId = 6085101, buffId = "21668", bSkillId = "6085111"}
, 
[178] = {id = 178, aSkillId = 6085102, buffId = "21668", bSkillId = "6085112"}
, 
[179] = {id = 179, aSkillId = 6085103, buffId = "21668", bSkillId = "6085113"}
, 
[180] = {id = 180, aSkillId = 6085104, buffId = "21668", bSkillId = "6085114"}
, 
[181] = {id = 181, aSkillId = 6085105, buffId = "21668", bSkillId = "6085115"}
, 
[182] = {id = 182, aSkillId = 6085201, buffId = "21668", bSkillId = "6085211"}
, 
[183] = {id = 183, aSkillId = 6085202, buffId = "21668", bSkillId = "6085212"}
, 
[184] = {id = 184, aSkillId = 6085203, buffId = "21668", bSkillId = "6085213"}
, 
[185] = {id = 185, aSkillId = 6085204, buffId = "21668", bSkillId = "6085214"}
, 
[186] = {id = 186, aSkillId = 6085205, buffId = "21668", bSkillId = "6085215"}
, 
[187] = {id = 187, aSkillId = 6088101, buffId = "21814", bSkillId = "6088111"}
, 
[188] = {id = 188, aSkillId = 6088102, buffId = "21814", bSkillId = "6088112"}
, 
[189] = {id = 189, aSkillId = 6088103, buffId = "21814", bSkillId = "6088113"}
, 
[190] = {id = 190, aSkillId = 6088104, buffId = "21814", bSkillId = "6088114"}
, 
[191] = {id = 191, aSkillId = 6088105, buffId = "21814", bSkillId = "6088115"}
, 
[192] = {id = 192, aSkillId = 6082201, buffId = "21954", bSkillId = "6082301"}
, 
[193] = {id = 193, aSkillId = 6082202, buffId = "21954", bSkillId = "6082302"}
, 
[194] = {id = 194, aSkillId = 6082203, buffId = "21954", bSkillId = "6082303"}
, 
[195] = {id = 195, aSkillId = 6082204, buffId = "21954", bSkillId = "6082304"}
, 
[196] = {id = 196, aSkillId = 6082205, buffId = "21954", bSkillId = "6082305"}
}
cskillchange.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196}
return cskillchange

