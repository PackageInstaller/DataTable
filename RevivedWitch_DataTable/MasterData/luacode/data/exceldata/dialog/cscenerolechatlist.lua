-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dialog/cscenerolechatlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cscenerolechatlist = {}
cscenerolechatlist.Data = {
[1] = {id = 1, Dialogid = 1, isRandom = 0, Roleid = 76, Sceneid = 10004, Zone = "20,22,5,1", Textid = 203288, SkipTime = 3}
, 
[2] = {id = 2, Dialogid = 1, isRandom = 0, Roleid = 16, Sceneid = 10004, Zone = "20,22,5,1", Textid = 203289, SkipTime = 6}
, 
[3] = {id = 3, Dialogid = 1, isRandom = 0, Roleid = 76, Sceneid = 10004, Zone = "20,22,5,1", Textid = 203290, SkipTime = 6}
, 
[4] = {id = 4, Dialogid = 1, isRandom = 0, Roleid = 16, Sceneid = 10004, Zone = "20,22,5,1", Textid = 203291, SkipTime = 4}
, 
[5] = {id = 5, Dialogid = 2, isRandom = 1, Roleid = -1, Sceneid = 10010, Zone = "9,7,1,4", Textid = 203292, SkipTime = 5}
, 
[6] = {id = 6, Dialogid = 3, isRandom = 1, Roleid = -1, Sceneid = -1, Zone = "-1", Textid = 203293, SkipTime = 3}
, 
[7] = {id = 7, Dialogid = 4, isRandom = 1, Roleid = -1, Sceneid = -1, Zone = "-1", Textid = 203294, SkipTime = 3}
, 
[8] = {id = 8, Dialogid = 5, isRandom = 1, Roleid = -1, Sceneid = 10009, Zone = "3,15,4,1", Textid = 203295, SkipTime = 2}
, 
[9] = {id = 9, Dialogid = 5, isRandom = 1, Roleid = -1, Sceneid = 10009, Zone = "3,15,4,1", Textid = 203296, SkipTime = 2}
, 
[10] = {id = 10, Dialogid = 5, isRandom = 1, Roleid = -1, Sceneid = 10009, Zone = "3,15,4,1", Textid = 203297, SkipTime = 6}
, 
[11] = {id = 11, Dialogid = 6, isRandom = 1, Roleid = -1, Sceneid = -1, Zone = "-1", Textid = 203298, SkipTime = 2}
, 
[12] = {id = 12, Dialogid = 7, isRandom = 1, Roleid = -1, Sceneid = 12004, Zone = "10,22,1,3", Textid = 203314, SkipTime = 4}
, 
[13] = {id = 13, Dialogid = 7, isRandom = 1, Roleid = -1, Sceneid = 12004, Zone = "10,22,1,3", Textid = 203315, SkipTime = 3}
, 
[14] = {id = 14, Dialogid = 8, isRandom = 1, Roleid = -1, Sceneid = 12008, Zone = "10,22,5,1", Textid = 203316, SkipTime = 1}
, 
[15] = {id = 15, Dialogid = 8, isRandom = 0, Roleid = 1, Sceneid = 12008, Zone = "10,22,5,1", Textid = 203317, SkipTime = 2}
, 
[16] = {id = 16, Dialogid = 8, isRandom = 1, Roleid = -1, Sceneid = 12008, Zone = "10,22,5,1", Textid = 203318, SkipTime = 3}
, 
[17] = {id = 17, Dialogid = 8, isRandom = 0, Roleid = 1, Sceneid = 12008, Zone = "10,22,5,1", Textid = 203319, SkipTime = 2}
, 
[18] = {id = 18, Dialogid = 9, isRandom = 1, Roleid = -1, Sceneid = 12010, Zone = "7,24,4,1", Textid = 203339, SkipTime = 4}
, 
[19] = {id = 19, Dialogid = 9, isRandom = 0, Roleid = 1, Sceneid = 12010, Zone = "7,24,4,1", Textid = 203340, SkipTime = 2}
, 
[20] = {id = 20, Dialogid = 9, isRandom = 1, Roleid = -1, Sceneid = 12010, Zone = "7,24,4,1", Textid = 203341, SkipTime = 6}
, 
[21] = {id = 21, Dialogid = 9, isRandom = 0, Roleid = 1, Sceneid = 12010, Zone = "7,24,4,1", Textid = 203342, SkipTime = 2}
, 
[22] = {id = 22, Dialogid = 10, isRandom = 1, Roleid = -1, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203361, SkipTime = 2}
, 
[23] = {id = 23, Dialogid = 10, isRandom = 1, Roleid = -2, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203362, SkipTime = 2}
, 
[24] = {id = 24, Dialogid = 10, isRandom = 1, Roleid = -1, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203363, SkipTime = 3}
, 
[25] = {id = 25, Dialogid = 10, isRandom = 0, Roleid = 1, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203364, SkipTime = 2}
, 
[26] = {id = 26, Dialogid = 10, isRandom = 1, Roleid = -1, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203365, SkipTime = 3}
, 
[27] = {id = 27, Dialogid = 10, isRandom = 1, Roleid = -2, Sceneid = 12015, Zone = "2,22,3,1", Textid = 203366, SkipTime = 2}
, 
[28] = {id = 28, Dialogid = 11, isRandom = 1, Roleid = -1, Sceneid = 12016, Zone = "6,20,3,1", Textid = 203379, SkipTime = 3}
, 
[29] = {id = 29, Dialogid = 12, isRandom = 1, Roleid = -1, Sceneid = 12018, Zone = "9,12,1,2", Textid = 203392, SkipTime = 2}
, 
[30] = {id = 30, Dialogid = 12, isRandom = 1, Roleid = -2, Sceneid = 12018, Zone = "9,12,1,2", Textid = 203393, SkipTime = 3}
, 
[31] = {id = 31, Dialogid = 13, isRandom = 1, Roleid = -1, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203410, SkipTime = 2}
, 
[32] = {id = 32, Dialogid = 13, isRandom = 0, Roleid = 1, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203411, SkipTime = 2}
, 
[33] = {id = 33, Dialogid = 13, isRandom = 1, Roleid = -1, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203412, SkipTime = 2}
, 
[34] = {id = 34, Dialogid = 13, isRandom = 1, Roleid = -2, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203413, SkipTime = 2}
, 
[35] = {id = 35, Dialogid = 13, isRandom = 0, Roleid = 1, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203414, SkipTime = 2}
, 
[36] = {id = 36, Dialogid = 13, isRandom = 1, Roleid = -1, Sceneid = 12021, Zone = "5,2,1,4", Textid = 203415, SkipTime = 2}
, 
[37] = {id = 37, Dialogid = 14, isRandom = 1, Roleid = -1, Sceneid = 12022, Zone = "12,7,4,1", Textid = 203416, SkipTime = 3}
, 
[38] = {id = 38, Dialogid = 14, isRandom = 0, Roleid = 1, Sceneid = 12022, Zone = "12,7,4,1", Textid = 203417, SkipTime = 2}
, 
[39] = {id = 39, Dialogid = 14, isRandom = 1, Roleid = -1, Sceneid = 12022, Zone = "12,7,4,1", Textid = 203418, SkipTime = 4}
, 
[40] = {id = 40, Dialogid = 15, isRandom = 1, Roleid = -1, Sceneid = 10011, Zone = "13,24,1,4", Textid = 203438, SkipTime = 2}
, 
[41] = {id = 41, Dialogid = 15, isRandom = 0, Roleid = 1, Sceneid = 10011, Zone = "13,24,1,4", Textid = 203439, SkipTime = 2}
, 
[42] = {id = 42, Dialogid = 15, isRandom = 1, Roleid = -1, Sceneid = 10011, Zone = "13,24,1,4", Textid = 203440, SkipTime = 3}
, 
[43] = {id = 43, Dialogid = 16, isRandom = 1, Roleid = -1, Sceneid = 10012, Zone = "23,14,3,1", Textid = 203441, SkipTime = 2}
, 
[44] = {id = 44, Dialogid = 16, isRandom = 0, Roleid = 1, Sceneid = 10012, Zone = "23,14,3,1", Textid = 203442, SkipTime = 2}
, 
[45] = {id = 45, Dialogid = 16, isRandom = 1, Roleid = -1, Sceneid = 10012, Zone = "23,14,3,1", Textid = 203443, SkipTime = 2}
, 
[46] = {id = 46, Dialogid = 17, isRandom = 1, Roleid = -1, Sceneid = 10014, Zone = "8,23,3,1", Textid = 203447, SkipTime = 2}
, 
[47] = {id = 47, Dialogid = 17, isRandom = 1, Roleid = -2, Sceneid = 10014, Zone = "8,23,3,1", Textid = 203448, SkipTime = 3}
, 
[48] = {id = 48, Dialogid = 17, isRandom = 1, Roleid = -1, Sceneid = 10014, Zone = "8,23,3,1", Textid = 203449, SkipTime = 4}
, 
[49] = {id = 49, Dialogid = 18, isRandom = 1, Roleid = -1, Sceneid = 10015, Zone = "15,17,3,3", Textid = 203450, SkipTime = 2}
, 
[50] = {id = 50, Dialogid = 18, isRandom = 1, Roleid = -1, Sceneid = 10015, Zone = "15,17,3,3", Textid = 203451, SkipTime = 4}
, 
[51] = {id = 51, Dialogid = 19, isRandom = 1, Roleid = -1, Sceneid = 10017, Zone = "3,19,2,2", Textid = 203452, SkipTime = 1}
, 
[52] = {id = 52, Dialogid = 19, isRandom = 1, Roleid = -2, Sceneid = 10017, Zone = "3,19,2,2", Textid = 203453, SkipTime = 3}
, 
[53] = {id = 53, Dialogid = 19, isRandom = 1, Roleid = -1, Sceneid = 10017, Zone = "3,19,2,2", Textid = 203454, SkipTime = 1}
, 
[54] = {id = 54, Dialogid = 19, isRandom = 1, Roleid = -2, Sceneid = 10017, Zone = "3,19,2,2", Textid = 203455, SkipTime = 2}
, 
[55] = {id = 55, Dialogid = 19, isRandom = 1, Roleid = -1, Sceneid = 10017, Zone = "3,19,2,2", Textid = 203456, SkipTime = 1}
, 
[56] = {id = 56, Dialogid = 20, isRandom = 1, Roleid = -1, Sceneid = 13001, Zone = "15,10,4,2", Textid = 203478, SkipTime = 1}
, 
[57] = {id = 57, Dialogid = 20, isRandom = 1, Roleid = -1, Sceneid = 13001, Zone = "15,10,4,2", Textid = 203479, SkipTime = 1}
, 
[58] = {id = 58, Dialogid = 20, isRandom = 1, Roleid = -2, Sceneid = 13001, Zone = "15,10,4,2", Textid = 203480, SkipTime = 3}
, 
[59] = {id = 59, Dialogid = 21, isRandom = 1, Roleid = -1, Sceneid = 13003, Zone = "18,21,1,5", Textid = 203481, SkipTime = 2}
, 
[60] = {id = 60, Dialogid = 21, isRandom = 1, Roleid = -1, Sceneid = 13003, Zone = "18,21,1,5", Textid = 203482, SkipTime = 1}
, 
[61] = {id = 61, Dialogid = 21, isRandom = 0, Roleid = 1, Sceneid = 13003, Zone = "18,21,1,5", Textid = 203483, SkipTime = 2}
, 
[62] = {id = 62, Dialogid = 22, isRandom = 1, Roleid = -1, Sceneid = 13005, Zone = "11,18,11,3", Textid = 203484, SkipTime = 4}
, 
[63] = {id = 63, Dialogid = 23, isRandom = 1, Roleid = -1, Sceneid = 13006, Zone = "29,16,5,1", Textid = 203493, SkipTime = 4}
, 
[64] = {id = 64, Dialogid = 23, isRandom = 1, Roleid = -1, Sceneid = 13006, Zone = "29,16,5,1", Textid = 203494, SkipTime = 2}
, 
[65] = {id = 65, Dialogid = 23, isRandom = 1, Roleid = -2, Sceneid = 13006, Zone = "29,16,5,1", Textid = 203495, SkipTime = 2}
, 
[66] = {id = 66, Dialogid = 23, isRandom = 1, Roleid = -1, Sceneid = 13006, Zone = "29,16,5,1", Textid = 203496, SkipTime = 4}
, 
[67] = {id = 67, Dialogid = 24, isRandom = 1, Roleid = -1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204214, SkipTime = 4}
, 
[68] = {id = 68, Dialogid = 24, isRandom = 0, Roleid = 1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204215, SkipTime = 2}
, 
[69] = {id = 69, Dialogid = 24, isRandom = 1, Roleid = -1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204216, SkipTime = 2}
, 
[70] = {id = 70, Dialogid = 24, isRandom = 0, Roleid = 1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204217, SkipTime = 2}
, 
[71] = {id = 71, Dialogid = 24, isRandom = 1, Roleid = -1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204218, SkipTime = 2}
, 
[72] = {id = 72, Dialogid = 24, isRandom = 0, Roleid = 1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204219, SkipTime = 2}
, 
[73] = {id = 73, Dialogid = 24, isRandom = 1, Roleid = -1, Sceneid = 13009, Zone = "15,10,4,2", Textid = 204220, SkipTime = 5}
, 
[74] = {id = 74, Dialogid = 25, isRandom = 1, Roleid = -1, Sceneid = 13010, Zone = "10,2,1,6", Textid = 204221, SkipTime = 4}
, 
[75] = {id = 75, Dialogid = 25, isRandom = 1, Roleid = -2, Sceneid = 13010, Zone = "10,2,1,6", Textid = 204222, SkipTime = 2}
, 
[76] = {id = 76, Dialogid = 25, isRandom = 1, Roleid = -1, Sceneid = 13010, Zone = "10,2,1,6", Textid = 204223, SkipTime = 4}
, 
[77] = {id = 77, Dialogid = 25, isRandom = 0, Roleid = 1, Sceneid = 13010, Zone = "10,2,1,6", Textid = 204224, SkipTime = 2}
, 
[78] = {id = 78, Dialogid = 25, isRandom = 1, Roleid = -1, Sceneid = 13010, Zone = "10,2,1,6", Textid = 204225, SkipTime = 4}
, 
[79] = {id = 79, Dialogid = 26, isRandom = 1, Roleid = -1, Sceneid = 13014, Zone = "17,12,4,2", Textid = 204226, SkipTime = 3}
, 
[80] = {id = 80, Dialogid = 26, isRandom = 1, Roleid = -1, Sceneid = 13014, Zone = "17,12,4,2", Textid = 204227, SkipTime = 4}
, 
[81] = {id = 81, Dialogid = 26, isRandom = 1, Roleid = -1, Sceneid = 13014, Zone = "17,12,4,2", Textid = 204228, SkipTime = 3}
, 
[82] = {id = 82, Dialogid = 26, isRandom = 0, Roleid = 1, Sceneid = 13014, Zone = "17,12,4,2", Textid = 204229, SkipTime = 2}
, 
[83] = {id = 83, Dialogid = 27, isRandom = 1, Roleid = -1, Sceneid = 13015, Zone = "4,13,4,1", Textid = 204230, SkipTime = 2}
, 
[84] = {id = 84, Dialogid = 27, isRandom = 1, Roleid = -1, Sceneid = 13015, Zone = "4,13,4,1", Textid = 204231, SkipTime = 2}
, 
[85] = {id = 85, Dialogid = 28, isRandom = 1, Roleid = -1, Sceneid = 13020, Zone = "21,11,5,3", Textid = 204232, SkipTime = 2}
, 
[86] = {id = 86, Dialogid = 28, isRandom = 0, Roleid = 1, Sceneid = 13020, Zone = "21,11,5,3", Textid = 204233, SkipTime = 2}
, 
[87] = {id = 87, Dialogid = 28, isRandom = 1, Roleid = -1, Sceneid = 13020, Zone = "21,11,5,3", Textid = 204234, SkipTime = 2}
, 
[88] = {id = 88, Dialogid = 29, isRandom = 1, Roleid = -1, Sceneid = 13022, Zone = "6,11,6,2", Textid = 204235, SkipTime = 2}
, 
[89] = {id = 89, Dialogid = 29, isRandom = 0, Roleid = 1, Sceneid = 13022, Zone = "6,11,6,2", Textid = 204236, SkipTime = 2}
, 
[90] = {id = 90, Dialogid = 29, isRandom = 1, Roleid = -1, Sceneid = 13022, Zone = "6,11,6,2", Textid = 204237, SkipTime = 4}
, 
[91] = {id = 91, Dialogid = 30, isRandom = 1, Roleid = -1, Sceneid = 13027, Zone = "8,28,7,1", Textid = 204264, SkipTime = 2}
, 
[92] = {id = 92, Dialogid = 30, isRandom = 1, Roleid = -1, Sceneid = 13027, Zone = "8,28,7,1", Textid = 204265, SkipTime = 5}
, 
[93] = {id = 93, Dialogid = 31, isRandom = 1, Roleid = -1, Sceneid = 10026, Zone = "22,11,1,4", Textid = 204273, SkipTime = 3}
, 
[94] = {id = 94, Dialogid = 31, isRandom = 0, Roleid = 1, Sceneid = 10026, Zone = "22,11,1,4", Textid = 204274, SkipTime = 2}
, 
[95] = {id = 95, Dialogid = 31, isRandom = 1, Roleid = -1, Sceneid = 10026, Zone = "22,11,1,4", Textid = 204275, SkipTime = 5}
, 
[96] = {id = 96, Dialogid = 32, isRandom = 1, Roleid = -1, Sceneid = 14003, Zone = "18,13,3,3", Textid = 204276, SkipTime = 2}
, 
[97] = {id = 97, Dialogid = 32, isRandom = 1, Roleid = -1, Sceneid = 14003, Zone = "18,13,3,3", Textid = 204277, SkipTime = 4}
, 
[98] = {id = 98, Dialogid = 32, isRandom = 0, Roleid = 1, Sceneid = 14003, Zone = "18,13,3,3", Textid = 204278, SkipTime = 2}
, 
[99] = {id = 99, Dialogid = 32, isRandom = 1, Roleid = -1, Sceneid = 14003, Zone = "18,13,3,3", Textid = 204279, SkipTime = 4}
, 
[100] = {id = 100, Dialogid = 33, isRandom = 1, Roleid = -1, Sceneid = 14006, Zone = "2,25,4,1", Textid = 204280, SkipTime = 2}
, 
[101] = {id = 101, Dialogid = 33, isRandom = 1, Roleid = -1, Sceneid = 14006, Zone = "2,25,4,1", Textid = 204281, SkipTime = 2}
, 
[102] = {id = 102, Dialogid = 34, isRandom = 1, Roleid = -1, Sceneid = 14008, Zone = "4,20,4,2", Textid = 204282, SkipTime = 2}
, 
[103] = {id = 103, Dialogid = 34, isRandom = 1, Roleid = -1, Sceneid = 14008, Zone = "4,20,4,2", Textid = 204283, SkipTime = 3}
, 
[104] = {id = 104, Dialogid = 34, isRandom = 0, Roleid = 1, Sceneid = 14008, Zone = "4,20,4,2", Textid = 204284, SkipTime = 2}
, 
[105] = {id = 105, Dialogid = 35, isRandom = 1, Roleid = -1, Sceneid = 14010, Zone = "14,30,4,1", Textid = 204285, SkipTime = 3}
, 
[106] = {id = 106, Dialogid = 36, isRandom = 0, Roleid = 1, Sceneid = 14016, Zone = "9,13,4,3", Textid = 204286, SkipTime = 2}
, 
[107] = {id = 107, Dialogid = 36, isRandom = 1, Roleid = -1, Sceneid = 14016, Zone = "9,13,4,3", Textid = 204287, SkipTime = 3}
, 
[108] = {id = 108, Dialogid = 36, isRandom = 1, Roleid = -1, Sceneid = 14016, Zone = "9,13,4,3", Textid = 204288, SkipTime = 4}
, 
[109] = {id = 109, Dialogid = 37, isRandom = 1, Roleid = -1, Sceneid = 14020, Zone = "14,24,4,1", Textid = 204289, SkipTime = 2}
, 
[110] = {id = 110, Dialogid = 37, isRandom = 1, Roleid = -2, Sceneid = 14020, Zone = "14,24,4,1", Textid = 204290, SkipTime = 3}
, 
[111] = {id = 111, Dialogid = 37, isRandom = 1, Roleid = -1, Sceneid = 14020, Zone = "14,24,4,1", Textid = 204291, SkipTime = 4}
, 
[112] = {id = 112, Dialogid = 37, isRandom = 0, Roleid = 1, Sceneid = 14020, Zone = "14,24,4,1", Textid = 204292, SkipTime = 2}
, 
[113] = {id = 113, Dialogid = 37, isRandom = 1, Roleid = -1, Sceneid = 14020, Zone = "14,24,4,1", Textid = 204293, SkipTime = 4}
, 
[114] = {id = 114, Dialogid = 38, isRandom = 1, Roleid = -1, Sceneid = 14021, Zone = "13,24,1,4", Textid = 204294, SkipTime = 4}
, 
[115] = {id = 115, Dialogid = 38, isRandom = 1, Roleid = -2, Sceneid = 14021, Zone = "13,24,1,4", Textid = 204295, SkipTime = 4}
, 
[116] = {id = 116, Dialogid = 39, isRandom = 1, Roleid = -1, Sceneid = 14022, Zone = "11,17,5,2", Textid = 204296, SkipTime = 2}
, 
[117] = {id = 117, Dialogid = 39, isRandom = 0, Roleid = 1, Sceneid = 14022, Zone = "11,17,5,2", Textid = 204297, SkipTime = 2}
, 
[118] = {id = 118, Dialogid = 39, isRandom = 1, Roleid = -1, Sceneid = 14022, Zone = "11,17,5,2", Textid = 204298, SkipTime = 2}
, 
[119] = {id = 119, Dialogid = 39, isRandom = 0, Roleid = 1, Sceneid = 14022, Zone = "11,17,5,2", Textid = 204299, SkipTime = 2}
, 
[120] = {id = 120, Dialogid = 40, isRandom = 1, Roleid = -1, Sceneid = 10034, Zone = "10,7,2,2", Textid = 204478, SkipTime = 2}
, 
[121] = {id = 121, Dialogid = 40, isRandom = 1, Roleid = -1, Sceneid = 10034, Zone = "10,7,2,2", Textid = 204479, SkipTime = 2}
, 
[122] = {id = 122, Dialogid = 41, isRandom = 1, Roleid = -1, Sceneid = 10037, Zone = "18,20,3,2", Textid = 204480, SkipTime = 3}
}
cscenerolechatlist.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122}
return cscenerolechatlist

