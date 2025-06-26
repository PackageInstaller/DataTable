-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dialog/chomechatconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local chomechatconfig = {}
chomechatconfig.Data = {
[1] = {id = 1, dialogList = "1", nextDialog = 0, character = 1, weight = 1, effectRange = "1", wetherOnlyOnce = 0, animation = "0"}
, 
[2] = {id = 2, dialogList = "2", nextDialog = 0, character = 1, weight = 1, effectRange = "1", wetherOnlyOnce = 0, animation = "0"}
, 
[3] = {id = 3, dialogList = "3", nextDialog = 0, character = 1, weight = 1, effectRange = "2", wetherOnlyOnce = 0, animation = "0"}
, 
[4] = {id = 4, dialogList = "6", nextDialog = 0, character = 1, weight = 1, effectRange = "2", wetherOnlyOnce = 0, animation = "0"}
, 
[5] = {id = 5, dialogList = "7", nextDialog = 0, character = 1, weight = 1, effectRange = "3", wetherOnlyOnce = 0, animation = "0"}
, 
[6] = {id = 6, dialogList = "9", nextDialog = 0, character = 1, weight = 1, effectRange = "4,6", wetherOnlyOnce = 0, animation = "0"}
, 
[7] = {id = 7, dialogList = "11", nextDialog = 0, character = 1, weight = 1, effectRange = "7,8", wetherOnlyOnce = 0, animation = "0"}
, 
[8] = {id = 8, dialogList = "14", nextDialog = 0, character = 1, weight = 1, effectRange = "9,10", wetherOnlyOnce = 0, animation = "0"}
, 
[9] = {id = 9, dialogList = "16", nextDialog = 0, character = 1, weight = 1, effectRange = "9,10", wetherOnlyOnce = 0, animation = "0"}
, 
[10] = {id = 10, dialogList = "19", nextDialog = 0, character = 1, weight = 1, effectRange = "11,12", wetherOnlyOnce = 0, animation = "0"}
, 
[11] = {id = 11, dialogList = "21", nextDialog = 0, character = 1, weight = 1, effectRange = "11,12", wetherOnlyOnce = 0, animation = "0"}
, 
[12] = {id = 12, dialogList = "23", nextDialog = 0, character = 1, weight = 1, effectRange = "13", wetherOnlyOnce = 0, animation = "0"}
, 
[13] = {id = 13, dialogList = "25", nextDialog = 0, character = 1, weight = 1, effectRange = "14", wetherOnlyOnce = 0, animation = "0"}
, 
[14] = {id = 14, dialogList = "27", nextDialog = 0, character = 1, weight = 1, effectRange = "15", wetherOnlyOnce = 0, animation = "0"}
, 
[15] = {id = 15, dialogList = "28", nextDialog = 0, character = 1, weight = 1, effectRange = "16", wetherOnlyOnce = 0, animation = "0"}
, 
[16] = {id = 16, dialogList = "31", nextDialog = 0, character = 1, weight = 1, effectRange = "17", wetherOnlyOnce = 0, animation = "0"}
, 
[17] = {id = 17, dialogList = "32", nextDialog = 0, character = 1, weight = 1, effectRange = "18,20", wetherOnlyOnce = 0, animation = "0"}
, 
[18] = {id = 18, dialogList = "33", nextDialog = 0, character = 1, weight = 1, effectRange = "21,23", wetherOnlyOnce = 0, animation = "0"}
, 
[19] = {id = 19, dialogList = "36", nextDialog = 0, character = 1, weight = 1, effectRange = "24,25", wetherOnlyOnce = 0, animation = "0"}
, 
[20] = {id = 20, dialogList = "43", nextDialog = 0, character = 1, weight = 1, effectRange = "26,28", wetherOnlyOnce = 0, animation = "0"}
, 
[21] = {id = 21, dialogList = "48", nextDialog = 0, character = 1, weight = 1, effectRange = "26,28", wetherOnlyOnce = 0, animation = "0"}
, 
[22] = {id = 22, dialogList = "51", nextDialog = 0, character = 1, weight = 1, effectRange = "29,31", wetherOnlyOnce = 0, animation = "0"}
, 
[23] = {id = 23, dialogList = "56", nextDialog = 0, character = 1, weight = 1, effectRange = "32,33", wetherOnlyOnce = 0, animation = "0"}
, 
[24] = {id = 24, dialogList = "60", nextDialog = 0, character = 1, weight = 1, effectRange = "32,33", wetherOnlyOnce = 0, animation = "0"}
, 
[25] = {id = 25, dialogList = "61", nextDialog = 0, character = 1, weight = 1, effectRange = "34,36", wetherOnlyOnce = 0, animation = "0"}
, 
[26] = {id = 26, dialogList = "64", nextDialog = 0, character = 1, weight = 1, effectRange = "37,38", wetherOnlyOnce = 0, animation = "0"}
, 
[27] = {id = 27, dialogList = "66", nextDialog = 0, character = 1, weight = 1, effectRange = "39,40", wetherOnlyOnce = 0, animation = "0"}
, 
[28] = {id = 28, dialogList = "67", nextDialog = 0, character = 1, weight = 1, effectRange = "41", wetherOnlyOnce = 0, animation = "0"}
, 
[29] = {id = 29, dialogList = "68", nextDialog = 0, character = 1, weight = 1, effectRange = "41", wetherOnlyOnce = 0, animation = "0"}
, 
[30] = {id = 30, dialogList = "69", nextDialog = 0, character = 1, weight = 1, effectRange = "41", wetherOnlyOnce = 0, animation = "0"}
, 
[31] = {id = 31, dialogList = "70", nextDialog = 0, character = 1, weight = 1, effectRange = "41", wetherOnlyOnce = 0, animation = "0"}
, 
[32] = {id = 32, dialogList = "71", nextDialog = 0, character = 1, weight = 1, effectRange = "6,73", wetherOnlyOnce = 0, animation = "0"}
, 
[33] = {id = 33, dialogList = "72", nextDialog = 0, character = 2, weight = 1, effectRange = "-1", wetherOnlyOnce = 0, animation = "talk"}
, 
[34] = {id = 34, dialogList = "73", nextDialog = 0, character = 2, weight = 1, effectRange = "-1", wetherOnlyOnce = 0, animation = "laugh"}
, 
[35] = {id = 35, dialogList = "74", nextDialog = 0, character = 1, weight = 1, effectRange = "-1", wetherOnlyOnce = 0, animation = "0"}
, 
[36] = {id = 36, dialogList = "75", nextDialog = 0, character = 1, weight = 1, effectRange = "48,55", wetherOnlyOnce = 0, animation = "0"}
, 
[37] = {id = 37, dialogList = "77", nextDialog = 0, character = 1, weight = 1, effectRange = "56,61", wetherOnlyOnce = 0, animation = "0"}
, 
[38] = {id = 38, dialogList = "79", nextDialog = 0, character = 1, weight = 1, effectRange = "62,67", wetherOnlyOnce = 0, animation = "0"}
, 
[39] = {id = 39, dialogList = "80", nextDialog = 0, character = 1, weight = 1, effectRange = "58,73", wetherOnlyOnce = 0, animation = "0"}
}
chomechatconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39}
return chomechatconfig

