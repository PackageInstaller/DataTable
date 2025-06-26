-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dialog/cdramachatlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cdramachatlist = {}
cdramachatlist.Data = {
[1] = {id = 1, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200177, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020001, skipTime = 30}
, 
[2] = {id = 2, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200178, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020002, skipTime = 30}
, 
[3] = {id = 3, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200179, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010004, skipTime = 30}
, 
[4] = {id = 4, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201630, 202025}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[5] = {id = 5, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200180, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[6] = {id = 6, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200181, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[7] = {id = 7, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200182, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020015, skipTime = 30}
, 
[8] = {id = 8, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200183, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[9] = {id = 9, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200184, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020021, skipTime = 30}
, 
[10] = {id = 10, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201631}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[11] = {id = 11, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200185, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[12] = {id = 12, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200186, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[13] = {id = 13, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201632}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[14] = {id = 14, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201633}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[15] = {id = 15, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201633}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[16] = {id = 16, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200187, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[17] = {id = 17, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201634}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[18] = {id = 18, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200188, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010005, skipTime = 30}
, 
[19] = {id = 19, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200189, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010006, skipTime = 30}
, 
[20] = {id = 20, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200190, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010007, skipTime = 30}
, 
[21] = {id = 21, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200191, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010008, skipTime = 30}
, 
[22] = {id = 22, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201635}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[23] = {id = 23, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200192, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010009, skipTime = 30}
, 
[24] = {id = 24, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201636}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[25] = {id = 25, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200193, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010010, skipTime = 30}
, 
[26] = {id = 26, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200194, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[27] = {id = 27, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201637}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[28] = {id = 28, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200195, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[29] = {id = 29, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200196, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010012, skipTime = 30}
, 
[30] = {id = 30, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200197, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010013, skipTime = 30}
, 
[31] = {id = 31, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201638, 202026, 202054, 201654}
, 
chooseValue = {278, 279, 394, 1600}
, voiceId = 0, skipTime = 0}
, 
[32] = {id = 32, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200198, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010015, skipTime = 30}
, 
[33] = {id = 33, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200199, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010016, skipTime = 30}
, 
[34] = {id = 34, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200200, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100171, skipTime = 30}
, 
[35] = {id = 35, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200201, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100172, skipTime = 30}
, 
[36] = {id = 36, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201639}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[37] = {id = 37, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201640}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[38] = {id = 38, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201641}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[39] = {id = 39, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 1}
, contentTextID = 200202, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020006, skipTime = 30}
, 
[40] = {id = 40, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201642}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[41] = {id = 41, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 1}
, contentTextID = 200203, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200071, skipTime = 30}
, 
[42] = {id = 42, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 1}
, contentTextID = 200204, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200072, skipTime = 30}
, 
[43] = {id = 43, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200205, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020008, skipTime = 30}
, 
[44] = {id = 44, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200206, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[45] = {id = 45, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200207, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020009, skipTime = 30}
, 
[46] = {id = 46, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200208, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020010, skipTime = 30}
, 
[47] = {id = 47, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200209, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020011, skipTime = 30}
, 
[48] = {id = 48, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200210, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020012, skipTime = 30}
, 
[49] = {id = 49, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201643}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[50] = {id = 50, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200211, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020013, skipTime = 30}
, 
[51] = {id = 51, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200212, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200141, skipTime = 30}
, 
[52] = {id = 52, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200110, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200213, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200142, skipTime = 30}
, 
[53] = {id = 53, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200214, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020016, skipTime = 30}
, 
[54] = {id = 54, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201644}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[55] = {id = 55, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200215, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[56] = {id = 56, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201645}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[57] = {id = 57, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200216, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020017, skipTime = 30}
, 
[58] = {id = 58, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201646}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[59] = {id = 59, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200217, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020018, skipTime = 30}
, 
[60] = {id = 60, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201647}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[61] = {id = 61, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200218, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020038, skipTime = 30}
, 
[62] = {id = 62, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201648}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[63] = {id = 63, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200219, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[64] = {id = 64, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200220, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020039, skipTime = 30}
, 
[65] = {id = 65, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[66] = {id = 66, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200221, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020040, skipTime = 30}
, 
[67] = {id = 67, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200222, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[68] = {id = 68, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200223, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020041, skipTime = 30}
, 
[69] = {id = 69, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201650}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[70] = {id = 70, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200224, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020042, skipTime = 30}
, 
[71] = {id = 71, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201651}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[72] = {id = 72, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200225, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020043, skipTime = 30}
, 
[73] = {id = 73, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200226, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[74] = {id = 74, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201652}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[75] = {id = 75, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200227, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200441, skipTime = 30}
, 
[76] = {id = 76, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200228, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[77] = {id = 77, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200229, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200442, skipTime = 30}
, 
[78] = {id = 78, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200230, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020045, skipTime = 30}
, 
[79] = {id = 79, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201653}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[80] = {id = 80, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200231, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[81] = {id = 81, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[82] = {id = 82, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200232, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020046, skipTime = 30}
, 
[83] = {id = 83, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200233, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020020, skipTime = 30}
, 
[84] = {id = 84, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201655}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[85] = {id = 85, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200234, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020021, skipTime = 30}
, 
[86] = {id = 86, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200108, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200235, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020022, skipTime = 30}
, 
[87] = {id = 87, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200236, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020023, skipTime = 30}
, 
[88] = {id = 88, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201656}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[89] = {id = 89, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200237, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020024, skipTime = 30}
, 
[90] = {id = 90, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200238, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020025, skipTime = 30}
, 
[91] = {id = 91, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200239, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020026, skipTime = 30}
, 
[92] = {id = 92, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200112}
, 
emotionId = {0, 1}
, contentTextID = 200240, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020027, skipTime = 30}
, 
[93] = {id = 93, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020028, skipTime = 30}
, 
[94] = {id = 94, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200112}
, 
emotionId = {0, 1}
, contentTextID = 200242, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020029, skipTime = 30}
, 
[95] = {id = 95, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200243, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[96] = {id = 96, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200112}
, 
emotionId = {0, 6}
, contentTextID = 200244, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020030, skipTime = 30}
, 
[97] = {id = 97, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200245, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[98] = {id = 98, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201657}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[99] = {id = 99, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200246, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020031, skipTime = 30}
, 
[100] = {id = 100, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200247, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[101] = {id = 101, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201658}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[102] = {id = 102, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200248, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[103] = {id = 103, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200249, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[104] = {id = 104, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200250, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020032, skipTime = 30}
, 
[105] = {id = 105, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201659}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[106] = {id = 106, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200251, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[107] = {id = 107, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200252, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020033, skipTime = 30}
, 
[108] = {id = 108, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200253, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[109] = {id = 109, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1013, 0}
, 
nameTextID = {200112, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200254, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020034, skipTime = 30}
, 
[110] = {id = 110, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201660}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[111] = {id = 111, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1013, 0}
, 
nameTextID = {200112, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200255, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020035, skipTime = 30}
, 
[112] = {id = 112, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[113] = {id = 113, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 200256, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020036, skipTime = 30}
, 
[114] = {id = 114, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 200257, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[115] = {id = 115, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 200258, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[116] = {id = 116, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 1}
, contentTextID = -1, speed = "0", 
chooseTextID = {201643}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[117] = {id = 117, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 200259, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200371, skipTime = 30}
, 
[118] = {id = 118, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 200260, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200372, skipTime = 30}
, 
[119] = {id = 119, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200261, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020047, skipTime = 30}
, 
[120] = {id = 120, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200262, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020048, skipTime = 30}
, 
[121] = {id = 121, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200263, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020056, skipTime = 30}
, 
[122] = {id = 122, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200264, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020057, skipTime = 30}
, 
[123] = {id = 123, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200265, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020058, skipTime = 30}
, 
[124] = {id = 124, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200114, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200266, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030006, skipTime = 30}
, 
[125] = {id = 125, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201661}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[126] = {id = 126, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200114, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200267, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300071, skipTime = 30}
, 
[127] = {id = 127, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200268, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300072, skipTime = 30}
, 
[128] = {id = 128, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200269, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300073, skipTime = 30}
, 
[129] = {id = 129, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200270, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300081, skipTime = 30}
, 
[130] = {id = 130, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200271, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300082, skipTime = 30}
, 
[131] = {id = 131, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201662}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[132] = {id = 132, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200272, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030009, skipTime = 30}
, 
[133] = {id = 133, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[134] = {id = 134, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200116, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200274, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030001, skipTime = 30}
, 
[135] = {id = 135, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201638}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[136] = {id = 136, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200275, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030002, skipTime = 30}
, 
[137] = {id = 137, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201646, 202027}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[138] = {id = 138, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200276, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030003, skipTime = 30}
, 
[139] = {id = 139, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201663}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[140] = {id = 140, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200277, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030004, skipTime = 30}
, 
[141] = {id = 141, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200278, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[142] = {id = 142, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200279, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030005, skipTime = 30}
, 
[143] = {id = 143, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200280, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030016, skipTime = 30}
, 
[144] = {id = 144, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201664}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[145] = {id = 145, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200281, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[146] = {id = 146, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201665}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[147] = {id = 147, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200282, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030017, skipTime = 30}
, 
[148] = {id = 148, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200283, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030019, skipTime = 30}
, 
[149] = {id = 149, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201666}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[150] = {id = 150, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200284, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[151] = {id = 151, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200285, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[152] = {id = 152, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200286, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030020, skipTime = 30}
, 
[153] = {id = 153, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200287, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[154] = {id = 154, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[155] = {id = 155, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200288, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[156] = {id = 156, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200289, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[157] = {id = 157, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200290, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[158] = {id = 158, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201668}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[159] = {id = 159, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200291, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[160] = {id = 160, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201669}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[161] = {id = 161, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200292, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[162] = {id = 162, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201670}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[163] = {id = 163, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200293, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[164] = {id = 164, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {4, 0}
, contentTextID = 200294, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300121, skipTime = 30}
, 
[165] = {id = 165, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {4, 0}
, contentTextID = 200295, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300122, skipTime = 30}
, 
[166] = {id = 166, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200296, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030013, skipTime = 30}
, 
[167] = {id = 167, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201671}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[168] = {id = 168, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200297, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030014, skipTime = 30}
, 
[169] = {id = 169, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200298, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030015, skipTime = 30}
, 
[170] = {id = 170, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200119, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200299, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[171] = {id = 171, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[172] = {id = 172, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200119, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200300, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[173] = {id = 173, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200119, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200301, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[174] = {id = 174, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201672}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[175] = {id = 175, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200119, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200302, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[176] = {id = 176, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200303, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[177] = {id = 177, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200304, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[178] = {id = 178, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[179] = {id = 179, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200305, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[180] = {id = 180, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[181] = {id = 181, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200306, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[182] = {id = 182, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200307, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[183] = {id = 183, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200308, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[184] = {id = 184, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200309, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[185] = {id = 185, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201673}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[186] = {id = 186, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200310, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030010, skipTime = 30}
, 
[187] = {id = 187, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201674}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[188] = {id = 188, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200311, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030011, skipTime = 30}
, 
[189] = {id = 189, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201675}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[190] = {id = 190, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200312, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[191] = {id = 191, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201676}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[192] = {id = 192, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200313, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030021, skipTime = 30}
, 
[193] = {id = 193, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201677}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[194] = {id = 194, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200314, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030023, skipTime = 30}
, 
[195] = {id = 195, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[196] = {id = 196, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200315, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030024, skipTime = 30}
, 
[197] = {id = 197, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200316, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030025, skipTime = 30}
, 
[198] = {id = 198, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201678}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[199] = {id = 199, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200317, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030026, skipTime = 30}
, 
[200] = {id = 200, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201679}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[201] = {id = 201, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200318, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030027, skipTime = 30}
, 
[202] = {id = 202, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[203] = {id = 203, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200319, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300281, skipTime = 30}
, 
[204] = {id = 204, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200320, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300282, skipTime = 30}
, 
[205] = {id = 205, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201680}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[206] = {id = 206, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200321, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[207] = {id = 207, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200121, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200322, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[208] = {id = 208, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201681}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[209] = {id = 209, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200323, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[210] = {id = 210, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200324, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[211] = {id = 211, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200325, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[212] = {id = 212, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200326, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[213] = {id = 213, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200327, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[214] = {id = 214, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200328, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[215] = {id = 215, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200329, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[216] = {id = 216, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200330, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[217] = {id = 217, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201682}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[218] = {id = 218, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200331, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[219] = {id = 219, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200332, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[220] = {id = 220, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200333, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[221] = {id = 221, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200334, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[222] = {id = 222, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200335, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[223] = {id = 223, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200336, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[224] = {id = 224, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200337, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[225] = {id = 225, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201683}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[226] = {id = 226, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200338, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[227] = {id = 227, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200339, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[228] = {id = 228, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200340, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[229] = {id = 229, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201684}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[230] = {id = 230, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200341, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[231] = {id = 231, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200342, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030030, skipTime = 30}
, 
[232] = {id = 232, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201685}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[233] = {id = 233, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200343, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030031, skipTime = 30}
, 
[234] = {id = 234, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200344, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300321, skipTime = 30}
, 
[235] = {id = 235, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200345, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300322, skipTime = 30}
, 
[236] = {id = 236, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200346, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[237] = {id = 237, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200347, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[238] = {id = 238, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200348, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[239] = {id = 239, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201686}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[240] = {id = 240, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200349, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[241] = {id = 241, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200350, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[242] = {id = 242, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200351, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[243] = {id = 243, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201687}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[244] = {id = 244, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200352, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[245] = {id = 245, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200353, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[246] = {id = 246, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200354, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[247] = {id = 247, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200355, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[248] = {id = 248, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200356, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[249] = {id = 249, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200357, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[250] = {id = 250, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200358, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[251] = {id = 251, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201688}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[252] = {id = 252, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200359, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[253] = {id = 253, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201689}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[254] = {id = 254, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200360, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[255] = {id = 255, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10021}
, 
nameTextID = {202064, 200123}
, 
emotionId = {0, 0}
, contentTextID = 200361, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[256] = {id = 256, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200362, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[257] = {id = 257, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200363, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[258] = {id = 258, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200364, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[259] = {id = 259, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200365, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[260] = {id = 260, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201690, 202028}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[261] = {id = 261, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200366, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[262] = {id = 262, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200367, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[263] = {id = 263, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200368, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[264] = {id = 264, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200369, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[265] = {id = 265, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201691}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[266] = {id = 266, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200370, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[267] = {id = 267, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200371, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[268] = {id = 268, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200372, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[269] = {id = 269, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201692, 202029}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[270] = {id = 270, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200373, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[271] = {id = 271, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20029, 0}
, 
nameTextID = {200122, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200374, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[272] = {id = 272, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200375, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[273] = {id = 273, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200376, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[274] = {id = 274, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200377, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030033, skipTime = 30}
, 
[275] = {id = 275, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201693}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[276] = {id = 276, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200378, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030034, skipTime = 30}
, 
[277] = {id = 277, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201694}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[278] = {id = 278, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200379, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[279] = {id = 279, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201695}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[280] = {id = 280, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200380, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[281] = {id = 281, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201696}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[282] = {id = 282, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200381, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030035, skipTime = 30}
, 
[283] = {id = 283, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200382, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030036, skipTime = 30}
, 
[284] = {id = 284, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200383, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030037, skipTime = 30}
, 
[285] = {id = 285, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200384, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030038, skipTime = 30}
, 
[286] = {id = 286, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200385, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[287] = {id = 287, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654, 202030}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[288] = {id = 288, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200386, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030040, skipTime = 30}
, 
[289] = {id = 289, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200387, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[290] = {id = 290, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201697}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[291] = {id = 291, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10041, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200388, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[292] = {id = 292, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200389, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[293] = {id = 293, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201698}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[294] = {id = 294, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200390, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[295] = {id = 295, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200391, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[296] = {id = 296, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200392, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[297] = {id = 297, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200393, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030049, skipTime = 30}
, 
[298] = {id = 298, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200394, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030050, skipTime = 30}
, 
[299] = {id = 299, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200395, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[300] = {id = 300, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200396, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[301] = {id = 301, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200397, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030051, skipTime = 30}
, 
[302] = {id = 302, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200398, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030052, skipTime = 30}
, 
[303] = {id = 303, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200399, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[304] = {id = 304, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200400, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030053, skipTime = 30}
, 
[305] = {id = 305, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200401, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[306] = {id = 306, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200402, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300541, skipTime = 30}
, 
[307] = {id = 307, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 200403, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300542, skipTime = 30}
, 
[308] = {id = 308, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200404, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030055, skipTime = 30}
, 
[309] = {id = 309, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200376, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[310] = {id = 310, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200405, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[311] = {id = 311, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200406, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030056, skipTime = 30}
, 
[312] = {id = 312, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200407, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030057, skipTime = 30}
, 
[313] = {id = 313, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201699}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[314] = {id = 314, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200408, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[315] = {id = 315, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200409, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030058, skipTime = 30}
, 
[316] = {id = 316, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200410, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030059, skipTime = 30}
, 
[317] = {id = 317, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200411, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030060, skipTime = 30}
, 
[318] = {id = 318, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201700}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[319] = {id = 319, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200412, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030061, skipTime = 30}
, 
[320] = {id = 320, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200413, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030062, skipTime = 30}
, 
[321] = {id = 321, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200414, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030063, skipTime = 30}
, 
[322] = {id = 322, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201701}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[323] = {id = 323, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200415, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030064, skipTime = 30}
, 
[324] = {id = 324, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201702}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[325] = {id = 325, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200416, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030065, skipTime = 30}
, 
[326] = {id = 326, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20016, 0}
, 
nameTextID = {200117, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200417, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030066, skipTime = 30}
, 
[327] = {id = 327, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201703}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[328] = {id = 328, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200418, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[329] = {id = 329, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200419, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[330] = {id = 330, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200420, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[331] = {id = 331, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200202, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020006, skipTime = 30}
, 
[332] = {id = 332, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[333] = {id = 333, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200421, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030078, skipTime = 30}
, 
[334] = {id = 334, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201704}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[335] = {id = 335, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200422, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030079, skipTime = 30}
, 
[336] = {id = 336, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200423, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[337] = {id = 337, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200424, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300801, skipTime = 30}
, 
[338] = {id = 338, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200425, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300802, skipTime = 30}
, 
[339] = {id = 339, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200426, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300803, skipTime = 30}
, 
[340] = {id = 340, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201705}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[341] = {id = 341, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200427, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300821, skipTime = 30}
, 
[342] = {id = 342, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200428, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300822, skipTime = 30}
, 
[343] = {id = 343, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201706}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[344] = {id = 344, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200429, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[345] = {id = 345, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[346] = {id = 346, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200430, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[347] = {id = 347, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200431, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[348] = {id = 348, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201707}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[349] = {id = 349, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200432, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[350] = {id = 350, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200433, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[351] = {id = 351, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200434, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[352] = {id = 352, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200435, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[353] = {id = 353, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200436, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[354] = {id = 354, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200437, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[355] = {id = 355, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200438, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[356] = {id = 356, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 8}
, 
[357] = {id = 357, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200440, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[358] = {id = 358, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200441, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[359] = {id = 359, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201708}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[360] = {id = 360, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200442, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[361] = {id = 361, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201709}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[362] = {id = 362, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200443, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[363] = {id = 363, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201710}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[364] = {id = 364, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200444, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[365] = {id = 365, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201711}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[366] = {id = 366, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200445, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[367] = {id = 367, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200446, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[368] = {id = 368, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[369] = {id = 369, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200447, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[370] = {id = 370, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200448, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[371] = {id = 371, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200449, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[372] = {id = 372, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200450, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[373] = {id = 373, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200451, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[374] = {id = 374, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200452, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030067, skipTime = 30}
, 
[375] = {id = 375, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201712}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[376] = {id = 376, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {2, 0}
, contentTextID = 200453, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030068, skipTime = 30}
, 
[377] = {id = 377, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201713}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[378] = {id = 378, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200454, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030069, skipTime = 30}
, 
[379] = {id = 379, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200455, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[380] = {id = 380, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200456, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030070, skipTime = 30}
, 
[381] = {id = 381, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201714}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[382] = {id = 382, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200457, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[383] = {id = 383, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[384] = {id = 384, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200459, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030071, skipTime = 30}
, 
[385] = {id = 385, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200460, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030072, skipTime = 30}
, 
[386] = {id = 386, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {202086}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[387] = {id = 387, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10022, 0}
, 
nameTextID = {200118, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[388] = {id = 388, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[389] = {id = 389, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201715}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[390] = {id = 390, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20031, 0}
, 
nameTextID = {200125, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200464, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[391] = {id = 391, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[392] = {id = 392, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20031, 0}
, 
nameTextID = {200125, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200465, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[393] = {id = 393, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201716}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[394] = {id = 394, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20031, 0}
, 
nameTextID = {200125, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200466, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[395] = {id = 395, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20032}
, 
nameTextID = {202064, 200167}
, 
emotionId = {0, 0}
, contentTextID = 200467, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[396] = {id = 396, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20032}
, 
nameTextID = {202064, 200167}
, 
emotionId = {0, 0}
, contentTextID = 200468, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[397] = {id = 397, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20031, 0}
, 
nameTextID = {200125, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200469, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[398] = {id = 398, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20031, 0}
, 
nameTextID = {200125, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200470, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[399] = {id = 399, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200471, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030041, skipTime = 30}
, 
[400] = {id = 400, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200472, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300831, skipTime = 30}
, 
[401] = {id = 401, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200473, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300832, skipTime = 30}
, 
[402] = {id = 402, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200474, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030074, skipTime = 30}
, 
[403] = {id = 403, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200475, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300761, skipTime = 30}
, 
[404] = {id = 404, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 1}
, contentTextID = 200476, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300762, skipTime = 30}
, 
[405] = {id = 405, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 200477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030077, skipTime = 30}
, 
[406] = {id = 406, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200478, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030084, skipTime = 30}
, 
[407] = {id = 407, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[408] = {id = 408, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200479, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300851, skipTime = 30}
, 
[409] = {id = 409, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200480, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300852, skipTime = 30}
, 
[410] = {id = 410, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201717}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[411] = {id = 411, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {1, 0}
, contentTextID = 200481, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030086, skipTime = 0}
, 
[412] = {id = 412, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201718}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[413] = {id = 413, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200482, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[414] = {id = 414, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200483, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[415] = {id = 415, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200484, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050001, skipTime = 30}
, 
[416] = {id = 416, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200485, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050002, skipTime = 30}
, 
[417] = {id = 417, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201719}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[418] = {id = 418, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200486, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500031, skipTime = 30}
, 
[419] = {id = 419, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200487, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500032, skipTime = 30}
, 
[420] = {id = 420, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200488, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500033, skipTime = 30}
, 
[421] = {id = 421, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201720}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[422] = {id = 422, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200489, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[423] = {id = 423, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200490, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[424] = {id = 424, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200491, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040004, skipTime = 30}
, 
[425] = {id = 425, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201721}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[426] = {id = 426, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200492, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[427] = {id = 427, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201722}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[428] = {id = 428, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200493, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[429] = {id = 429, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201723}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[430] = {id = 430, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200494, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400051, skipTime = 30}
, 
[431] = {id = 431, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200495, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400052, skipTime = 30}
, 
[432] = {id = 432, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201724}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[433] = {id = 433, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200496, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040006, skipTime = 30}
, 
[434] = {id = 434, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200497, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[435] = {id = 435, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200498, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[436] = {id = 436, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200499, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[437] = {id = 437, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200500, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040007, skipTime = 30}
, 
[438] = {id = 438, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200501, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[439] = {id = 439, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201725}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[440] = {id = 440, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200502, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040008, skipTime = 30}
, 
[441] = {id = 441, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200503, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040009, skipTime = 30}
, 
[442] = {id = 442, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201726}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[443] = {id = 443, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200504, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040010, skipTime = 30}
, 
[444] = {id = 444, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200505, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[445] = {id = 445, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200506, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[446] = {id = 446, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201727}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[447] = {id = 447, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200507, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040011, skipTime = 30}
, 
[448] = {id = 448, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200228, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[449] = {id = 449, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200229, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040012, skipTime = 30}
, 
[450] = {id = 450, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200508, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040013, skipTime = 30}
, 
[451] = {id = 451, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201728}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[452] = {id = 452, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[453] = {id = 453, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201729}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[454] = {id = 454, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200509, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[455] = {id = 455, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201730}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[456] = {id = 456, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200510, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040014, skipTime = 30}
, 
[457] = {id = 457, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201731}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[458] = {id = 458, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200511, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040015, skipTime = 30}
, 
[459] = {id = 459, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200512, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040016, skipTime = 30}
, 
[460] = {id = 460, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200513, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040017, skipTime = 30}
, 
[461] = {id = 461, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200514, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040018, skipTime = 30}
, 
[462] = {id = 462, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200515, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[463] = {id = 463, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200516, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040019, skipTime = 30}
, 
[464] = {id = 464, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200517, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040020, skipTime = 30}
, 
[465] = {id = 465, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201732}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[466] = {id = 466, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200518, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040021, skipTime = 30}
, 
[467] = {id = 467, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200519, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040022, skipTime = 30}
, 
[468] = {id = 468, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200520, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040023, skipTime = 30}
, 
[469] = {id = 469, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200521, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040024, skipTime = 30}
, 
[470] = {id = 470, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201733, 202031, 202055, 201735}
, 
chooseValue = {552, 553, 554, 555}
, voiceId = 0, skipTime = 0}
, 
[471] = {id = 471, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200522, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040025, skipTime = 30}
, 
[472] = {id = 472, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200523, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040026, skipTime = 30}
, 
[473] = {id = 473, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200524, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040027, skipTime = 30}
, 
[474] = {id = 474, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200525, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040028, skipTime = 30}
, 
[475] = {id = 475, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200526, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040029, skipTime = 30}
, 
[476] = {id = 476, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201734}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[477] = {id = 477, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200527, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040030, skipTime = 30}
, 
[478] = {id = 478, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201735}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[479] = {id = 479, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 200528, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040031, skipTime = 30}
, 
[480] = {id = 480, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200529, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040032, skipTime = 30}
, 
[481] = {id = 481, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201736}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[482] = {id = 482, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200530, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040033, skipTime = 30}
, 
[483] = {id = 483, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201737}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[484] = {id = 484, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200531, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040034, skipTime = 30}
, 
[485] = {id = 485, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200532, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040036, skipTime = 30}
, 
[486] = {id = 486, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201638, 202032, 202056}
, 
chooseValue = {568, 570, 573}
, voiceId = 0, skipTime = 0}
, 
[487] = {id = 487, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200533, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400371, skipTime = 30}
, 
[488] = {id = 488, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200534, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400372, skipTime = 30}
, 
[489] = {id = 489, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200535, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400381, skipTime = 30}
, 
[490] = {id = 490, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200536, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400382, skipTime = 30}
, 
[491] = {id = 491, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200537, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040039, skipTime = 30}
, 
[492] = {id = 492, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200524, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[493] = {id = 493, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200538, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400401, skipTime = 30}
, 
[494] = {id = 494, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200539, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400402, skipTime = 30}
, 
[495] = {id = 495, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200540, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400403, skipTime = 30}
, 
[496] = {id = 496, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200541, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400411, skipTime = 30}
, 
[497] = {id = 497, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200542, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200400412, skipTime = 30}
, 
[498] = {id = 498, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201738}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[499] = {id = 499, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200543, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040042, skipTime = 30}
, 
[500] = {id = 500, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200544, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040043, skipTime = 30}
, 
[501] = {id = 501, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200545, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040044, skipTime = 30}
, 
[502] = {id = 502, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200546, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040045, skipTime = 30}
, 
[503] = {id = 503, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201739}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[504] = {id = 504, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200547, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040046, skipTime = 30}
, 
[505] = {id = 505, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201740}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[506] = {id = 506, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[507] = {id = 507, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201741}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[508] = {id = 508, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200548, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040047, skipTime = 30}
, 
[509] = {id = 509, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200129, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200549, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[510] = {id = 510, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200129, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200550, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[511] = {id = 511, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201742}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[512] = {id = 512, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200551, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050005, skipTime = 30}
, 
[513] = {id = 513, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201743}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[514] = {id = 514, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200552, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050006, skipTime = 30}
, 
[515] = {id = 515, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201744}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[516] = {id = 516, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200553, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[517] = {id = 517, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200554, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[518] = {id = 518, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200555, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[519] = {id = 519, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201745}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[520] = {id = 520, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200556, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[521] = {id = 521, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200557, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[522] = {id = 522, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200558, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[523] = {id = 523, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201746}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[524] = {id = 524, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200559, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050007, skipTime = 30}
, 
[525] = {id = 525, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200560, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050008, skipTime = 30}
, 
[526] = {id = 526, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201747, 202033}
, 
chooseValue = {606, 609}
, voiceId = 0, skipTime = 0}
, 
[527] = {id = 527, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200561, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050009, skipTime = 30}
, 
[528] = {id = 528, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201748}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[529] = {id = 529, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200562, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[530] = {id = 530, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200563, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[531] = {id = 531, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200564, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050010, skipTime = 30}
, 
[532] = {id = 532, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201749}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[533] = {id = 533, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200565, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[534] = {id = 534, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201750}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[535] = {id = 535, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200566, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[536] = {id = 536, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200567, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050011, skipTime = 30}
, 
[537] = {id = 537, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201751}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[538] = {id = 538, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200568, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[539] = {id = 539, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201752}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[540] = {id = 540, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200569, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[541] = {id = 541, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200570, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[542] = {id = 542, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200571, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[543] = {id = 543, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201753}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[544] = {id = 544, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200572, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[545] = {id = 545, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200573, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[546] = {id = 546, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200574, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[547] = {id = 547, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[548] = {id = 548, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200575, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[549] = {id = 549, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201755}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[550] = {id = 550, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200576, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[551] = {id = 551, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200577, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[552] = {id = 552, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201756}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[553] = {id = 553, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200578, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[554] = {id = 554, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200579, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[555] = {id = 555, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200580, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[556] = {id = 556, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200581, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[557] = {id = 557, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200582, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[558] = {id = 558, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200583, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[559] = {id = 559, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201757}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[560] = {id = 560, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200584, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[561] = {id = 561, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200585, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[562] = {id = 562, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201758}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[563] = {id = 563, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200586, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[564] = {id = 564, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201759}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[565] = {id = 565, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200587, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[566] = {id = 566, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200588, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[567] = {id = 567, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201760}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[568] = {id = 568, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200589, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[569] = {id = 569, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201754}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[570] = {id = 570, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200590, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[571] = {id = 571, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200591, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[572] = {id = 572, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200592, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[573] = {id = 573, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201761}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[574] = {id = 574, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200593, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[575] = {id = 575, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201762}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[576] = {id = 576, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200594, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[577] = {id = 577, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201763}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[578] = {id = 578, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200595, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[579] = {id = 579, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200596, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[580] = {id = 580, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200597, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[581] = {id = 581, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201764, 202816}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[582] = {id = 582, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200598, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[583] = {id = 583, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200599, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[584] = {id = 584, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {200600}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[585] = {id = 585, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200601, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[586] = {id = 586, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201765, 202817}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[587] = {id = 587, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200602, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[588] = {id = 588, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200603, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[589] = {id = 589, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201766}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[590] = {id = 590, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[591] = {id = 591, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201767}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[592] = {id = 592, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[593] = {id = 593, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200605, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[594] = {id = 594, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200606, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[595] = {id = 595, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201768}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[596] = {id = 596, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200607, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[597] = {id = 597, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201769}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[598] = {id = 598, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200608, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[599] = {id = 599, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200609, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[600] = {id = 600, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201770}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[601] = {id = 601, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200610, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[602] = {id = 602, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200611, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[603] = {id = 603, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200612, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[604] = {id = 604, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201771}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[605] = {id = 605, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200613, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[606] = {id = 606, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200614, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[607] = {id = 607, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200615, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[608] = {id = 608, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[609] = {id = 609, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200616, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050017, skipTime = 30}
, 
[610] = {id = 610, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200617, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500181, skipTime = 30}
, 
[611] = {id = 611, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200618, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500182, skipTime = 30}
, 
[612] = {id = 612, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200619, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[613] = {id = 613, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201773}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[614] = {id = 614, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200620, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[615] = {id = 615, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200621, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[616] = {id = 616, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200622, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[617] = {id = 617, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200623, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[618] = {id = 618, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201774}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[619] = {id = 619, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200624, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[620] = {id = 620, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200625, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[621] = {id = 621, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201775}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[622] = {id = 622, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200626, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050020, skipTime = 30}
, 
[623] = {id = 623, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201776}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[624] = {id = 624, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200627, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[625] = {id = 625, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200628, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050021, skipTime = 30}
, 
[626] = {id = 626, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201777}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[627] = {id = 627, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200629, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[628] = {id = 628, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200630, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[629] = {id = 629, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201778}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[630] = {id = 630, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200631, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[631] = {id = 631, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200632, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[632] = {id = 632, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200633, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[633] = {id = 633, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201779}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[634] = {id = 634, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200634, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[635] = {id = 635, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200635, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[636] = {id = 636, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201765}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[637] = {id = 637, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200636, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050023, skipTime = 30}
, 
[638] = {id = 638, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200637, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[639] = {id = 639, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200638, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[640] = {id = 640, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200639, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[641] = {id = 641, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200640, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[642] = {id = 642, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200641, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[643] = {id = 643, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200642, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[644] = {id = 644, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200643, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050049, skipTime = 30}
, 
[645] = {id = 645, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201780}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[646] = {id = 646, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200644, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050061, skipTime = 30}
, 
[647] = {id = 647, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200645, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500631, skipTime = 30}
, 
[648] = {id = 648, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200646, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500632, skipTime = 30}
, 
[649] = {id = 649, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[650] = {id = 650, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200647, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050064, skipTime = 30}
, 
[651] = {id = 651, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200138, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200648, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050065, skipTime = 30}
, 
[652] = {id = 652, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201781}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[653] = {id = 653, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200649, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500681, skipTime = 30}
, 
[654] = {id = 654, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200650, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500682, skipTime = 30}
, 
[655] = {id = 655, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201782}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[656] = {id = 656, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200651, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050069, skipTime = 30}
, 
[657] = {id = 657, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200652, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050070, skipTime = 30}
, 
[658] = {id = 658, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200653, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[659] = {id = 659, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201783}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[660] = {id = 660, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200654, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[661] = {id = 661, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200655, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050071, skipTime = 30}
, 
[662] = {id = 662, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200656, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[663] = {id = 663, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200657, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[664] = {id = 664, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200658, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[665] = {id = 665, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201784}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[666] = {id = 666, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200659, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[667] = {id = 667, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200660, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[668] = {id = 668, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200661, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[669] = {id = 669, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200662, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[670] = {id = 670, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201785}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[671] = {id = 671, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200663, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[672] = {id = 672, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200664, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[673] = {id = 673, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200665, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[674] = {id = 674, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201786}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[675] = {id = 675, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200666, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[676] = {id = 676, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201787}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[677] = {id = 677, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200667, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[678] = {id = 678, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200668, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[679] = {id = 679, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201788}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[680] = {id = 680, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200669, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[681] = {id = 681, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200670, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[682] = {id = 682, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200671, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[683] = {id = 683, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200672, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[684] = {id = 684, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200673, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[685] = {id = 685, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200674, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[686] = {id = 686, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[687] = {id = 687, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200675, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[688] = {id = 688, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200676, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[689] = {id = 689, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[690] = {id = 690, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200677, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[691] = {id = 691, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200678, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[692] = {id = 692, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200679, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[693] = {id = 693, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200143, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200680, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[694] = {id = 694, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201789}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[695] = {id = 695, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200143, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200681, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[696] = {id = 696, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200143, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200682, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[697] = {id = 697, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201790}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[698] = {id = 698, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200143, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200683, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[699] = {id = 699, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200143, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200684, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[700] = {id = 700, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201791}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[701] = {id = 701, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200685, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[702] = {id = 702, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[703] = {id = 703, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200686, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[704] = {id = 704, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200687, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[705] = {id = 705, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201792}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[706] = {id = 706, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200688, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[707] = {id = 707, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200689, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[708] = {id = 708, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200690, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[709] = {id = 709, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200691, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[710] = {id = 710, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201793}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[711] = {id = 711, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200692, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[712] = {id = 712, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200693, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[713] = {id = 713, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200694, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[714] = {id = 714, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200144, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200695, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[715] = {id = 715, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200696, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[716] = {id = 716, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[717] = {id = 717, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200697, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[718] = {id = 718, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201792}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[719] = {id = 719, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200698, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[720] = {id = 720, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200699, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[721] = {id = 721, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200700, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[722] = {id = 722, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200701, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[723] = {id = 723, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200145, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200702, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[724] = {id = 724, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200703, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[725] = {id = 725, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201794}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[726] = {id = 726, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200704, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[727] = {id = 727, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200705, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[728] = {id = 728, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200706, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050025, skipTime = 30}
, 
[729] = {id = 729, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200707, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500261, skipTime = 30}
, 
[730] = {id = 730, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200708, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500262, skipTime = 30}
, 
[731] = {id = 731, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201795}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[732] = {id = 732, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200709, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[733] = {id = 733, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201796}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[734] = {id = 734, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200710, speed = "", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[735] = {id = 735, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200711, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[736] = {id = 736, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200712, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[737] = {id = 737, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200713, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[738] = {id = 738, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200714, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[739] = {id = 739, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200715, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050027, skipTime = 30}
, 
[740] = {id = 740, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[741] = {id = 741, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201797}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[742] = {id = 742, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200716, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[743] = {id = 743, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201798}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[744] = {id = 744, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200717, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[745] = {id = 745, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200718, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[746] = {id = 746, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200719, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[747] = {id = 747, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200720, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[748] = {id = 748, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201799}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[749] = {id = 749, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200721, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[750] = {id = 750, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200722, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500281, skipTime = 30}
, 
[751] = {id = 751, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200723, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500282, skipTime = 30}
, 
[752] = {id = 752, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201800}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[753] = {id = 753, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200724, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[754] = {id = 754, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201801}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[755] = {id = 755, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200725, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[756] = {id = 756, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200726, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[757] = {id = 757, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200727, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[758] = {id = 758, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201802}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[759] = {id = 759, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200728, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[760] = {id = 760, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201803}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[761] = {id = 761, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200729, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[762] = {id = 762, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201804, 202034}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[763] = {id = 763, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200730, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[764] = {id = 764, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[765] = {id = 765, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200731, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[766] = {id = 766, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200732, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[767] = {id = 767, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200733, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[768] = {id = 768, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200734, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[769] = {id = 769, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200735, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[770] = {id = 770, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201805}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[771] = {id = 771, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200736, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[772] = {id = 772, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201806}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[773] = {id = 773, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200737, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[774] = {id = 774, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201807}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[775] = {id = 775, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200738, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[776] = {id = 776, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200739, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[777] = {id = 777, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200740, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[778] = {id = 778, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201808}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[779] = {id = 779, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200741, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[780] = {id = 780, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200146, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200742, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[781] = {id = 781, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200743, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[782] = {id = 782, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200744, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[783] = {id = 783, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200745, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[784] = {id = 784, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200746, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[785] = {id = 785, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200747, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[786] = {id = 786, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200748, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[787] = {id = 787, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201809}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[788] = {id = 788, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200749, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[789] = {id = 789, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200750, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[790] = {id = 790, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200751, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[791] = {id = 791, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200752, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[792] = {id = 792, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200753, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[793] = {id = 793, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200754, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[794] = {id = 794, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200755, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[795] = {id = 795, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200168}
, 
emotionId = {0, 1}
, contentTextID = 200756, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[796] = {id = 796, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200757, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[797] = {id = 797, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200758, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[798] = {id = 798, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200759, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[799] = {id = 799, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201810}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[800] = {id = 800, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200760, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[801] = {id = 801, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201811}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[802] = {id = 802, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200761, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[803] = {id = 803, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200762, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[804] = {id = 804, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200763, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[805] = {id = 805, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200764, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[806] = {id = 806, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200765, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[807] = {id = 807, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[808] = {id = 808, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200766, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[809] = {id = 809, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200767, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[810] = {id = 810, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201812}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[811] = {id = 811, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200768, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[812] = {id = 812, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200769, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050029, skipTime = 30}
, 
[813] = {id = 813, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200770, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050030, skipTime = 30}
, 
[814] = {id = 814, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[815] = {id = 815, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200771, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[816] = {id = 816, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200772, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050031, skipTime = 30}
, 
[817] = {id = 817, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201647}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[818] = {id = 818, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200773, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[819] = {id = 819, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200774, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[820] = {id = 820, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201813}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[821] = {id = 821, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200775, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[822] = {id = 822, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200776, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050032, skipTime = 30}
, 
[823] = {id = 823, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200777, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[824] = {id = 824, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200778, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050033, skipTime = 30}
, 
[825] = {id = 825, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200779, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500341, skipTime = 30}
, 
[826] = {id = 826, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200780, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050035, skipTime = 30}
, 
[827] = {id = 827, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200781, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050036, skipTime = 30}
, 
[828] = {id = 828, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201814, 202035}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[829] = {id = 829, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200782, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500371, skipTime = 30}
, 
[830] = {id = 830, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200783, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500372, skipTime = 30}
, 
[831] = {id = 831, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200784, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050038, skipTime = 30}
, 
[832] = {id = 832, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201806}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[833] = {id = 833, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200785, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050039, skipTime = 30}
, 
[834] = {id = 834, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200786, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050040, skipTime = 30}
, 
[835] = {id = 835, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200787, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[836] = {id = 836, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200788, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050041, skipTime = 30}
, 
[837] = {id = 837, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201815}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[838] = {id = 838, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200789, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050042, skipTime = 30}
, 
[839] = {id = 839, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200790, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500431, skipTime = 30}
, 
[840] = {id = 840, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200791, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500432, skipTime = 30}
, 
[841] = {id = 841, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200792, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[842] = {id = 842, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200793, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050044, skipTime = 30}
, 
[843] = {id = 843, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200794, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[844] = {id = 844, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200795, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[845] = {id = 845, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201816}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[846] = {id = 846, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200796, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[847] = {id = 847, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200797, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[848] = {id = 848, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200798, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[849] = {id = 849, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200799, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050045, skipTime = 30}
, 
[850] = {id = 850, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201817}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[851] = {id = 851, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200800, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[852] = {id = 852, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200801, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[853] = {id = 853, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200802, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[854] = {id = 854, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201818}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[855] = {id = 855, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200803, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050046, skipTime = 30}
, 
[856] = {id = 856, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200804, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[857] = {id = 857, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200805, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050047, skipTime = 30}
, 
[858] = {id = 858, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200806, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[859] = {id = 859, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201819}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[860] = {id = 860, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200807, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[861] = {id = 861, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200808, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[862] = {id = 862, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200809, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[863] = {id = 863, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201820}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[864] = {id = 864, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200810, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[865] = {id = 865, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201821}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[866] = {id = 866, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200811, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[867] = {id = 867, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200812, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[868] = {id = 868, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200813, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050048, skipTime = 30}
, 
[869] = {id = 869, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200814, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[870] = {id = 870, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201822}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[871] = {id = 871, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200815, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[872] = {id = 872, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200816, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500571, skipTime = 30}
, 
[873] = {id = 873, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200817, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500572, skipTime = 30}
, 
[874] = {id = 874, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200818, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500573, skipTime = 30}
, 
[875] = {id = 875, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201823}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[876] = {id = 876, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200819, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[877] = {id = 877, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201824}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[878] = {id = 878, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200820, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050058, skipTime = 30}
, 
[879] = {id = 879, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201825}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[880] = {id = 880, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200821, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050059, skipTime = 30}
, 
[881] = {id = 881, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[882] = {id = 882, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200822, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[883] = {id = 883, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200823, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[884] = {id = 884, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200134, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200824, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[885] = {id = 885, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200825, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060001, skipTime = 30}
, 
[886] = {id = 886, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[887] = {id = 887, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200826, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060002, skipTime = 30}
, 
[888] = {id = 888, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201826}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[889] = {id = 889, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200827, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[890] = {id = 890, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200591, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[891] = {id = 891, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200828, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[892] = {id = 892, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[893] = {id = 893, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200829, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[894] = {id = 894, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200134}
, 
emotionId = {0, 0}
, contentTextID = 200830, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[895] = {id = 895, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200831, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040048, skipTime = 30}
, 
[896] = {id = 896, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200265, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040049, skipTime = 30}
, 
[897] = {id = 897, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200832, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[898] = {id = 898, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200833, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500131, skipTime = 30}
, 
[899] = {id = 899, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200834, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500132, skipTime = 30}
, 
[900] = {id = 900, chatType = 0, isBlack = 0, isClickable = 0, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200835, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 8}
, 
[901] = {id = 901, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200668, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[902] = {id = 902, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {201788}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[903] = {id = 903, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200836, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[904] = {id = 904, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200837, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[905] = {id = 905, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200141, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200670, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[906] = {id = 906, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200838, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[907] = {id = 907, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201827}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[908] = {id = 908, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200839, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[909] = {id = 909, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200840, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[910] = {id = 910, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200841, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[911] = {id = 911, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201828}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[912] = {id = 912, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200148}
, 
emotionId = {0, 1}
, contentTextID = 200842, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050066, skipTime = 30}
, 
[913] = {id = 913, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 1}
, contentTextID = 200843, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050067, skipTime = 30}
, 
[914] = {id = 914, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 1}
, contentTextID = 200844, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[915] = {id = 915, chatType = 0, isBlack = 0, isClickable = 0, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200845, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 8}
, 
[916] = {id = 916, chatType = 0, isBlack = 0, isClickable = 0, 
shapeId = {}
, 
nameTextID = {202064, 202064}
, 
emotionId = {}
, contentTextID = 200846, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 7}
, 
[917] = {id = 917, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201829}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[918] = {id = 918, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[919] = {id = 919, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200847, speed = "0.05", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020055, skipTime = 30}
, 
[920] = {id = 920, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201830}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[921] = {id = 921, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200848, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100181, skipTime = 30}
, 
[922] = {id = 922, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200849, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100182, skipTime = 30}
, 
[923] = {id = 923, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 200850, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200031, skipTime = 30}
, 
[924] = {id = 924, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 200851, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200032, skipTime = 30}
, 
[925] = {id = 925, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201831}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[926] = {id = 926, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 200852, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[927] = {id = 927, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200853, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200041, skipTime = 30}
, 
[928] = {id = 928, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200854, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020005, skipTime = 30}
, 
[929] = {id = 929, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200855, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[930] = {id = 930, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201832}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[931] = {id = 931, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200856, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[932] = {id = 932, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200857, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200191, skipTime = 30}
, 
[933] = {id = 933, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 200858, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200192, skipTime = 30}
, 
[934] = {id = 934, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200859, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020049, skipTime = 30}
, 
[935] = {id = 935, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201833}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[936] = {id = 936, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200860, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[937] = {id = 937, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200861, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[938] = {id = 938, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200862, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[939] = {id = 939, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200863, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[940] = {id = 940, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200864, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[941] = {id = 941, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200865, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[942] = {id = 942, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200866, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[943] = {id = 943, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200867, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[944] = {id = 944, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200868, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[945] = {id = 945, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200869, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[946] = {id = 946, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200870, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[947] = {id = 947, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200871, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[948] = {id = 948, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200872, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[949] = {id = 949, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200873, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[950] = {id = 950, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200874, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[951] = {id = 951, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200875, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[952] = {id = 952, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200876, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 1}
, 
[953] = {id = 953, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200877, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020052, skipTime = 30}
, 
[954] = {id = 954, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201834}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[955] = {id = 955, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200878, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020053, skipTime = 30}
, 
[956] = {id = 956, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201690, 202036}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[957] = {id = 957, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200879, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20020054, skipTime = 30}
, 
[958] = {id = 958, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200880, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030043, skipTime = 30}
, 
[959] = {id = 959, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200881, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[960] = {id = 960, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200151}
, 
emotionId = {0, 0}
, contentTextID = 200882, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[961] = {id = 961, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200151}
, 
emotionId = {0, 0}
, contentTextID = 200883, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[962] = {id = 962, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201835}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[963] = {id = 963, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200151}
, 
emotionId = {0, 0}
, contentTextID = 200884, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[964] = {id = 964, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200885, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[965] = {id = 965, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201836}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[966] = {id = 966, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[967] = {id = 967, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200886, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[968] = {id = 968, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200887, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[969] = {id = 969, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200888, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030045, skipTime = 30}
, 
[970] = {id = 970, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200889, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[971] = {id = 971, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[972] = {id = 972, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200890, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030046, skipTime = 30}
, 
[973] = {id = 973, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[974] = {id = 974, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[975] = {id = 975, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201837}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[976] = {id = 976, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200891, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030047, skipTime = 30}
, 
[977] = {id = 977, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200892, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030048, skipTime = 30}
, 
[978] = {id = 978, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 200893, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[979] = {id = 979, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201838}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[980] = {id = 980, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200894, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[981] = {id = 981, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200895, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[982] = {id = 982, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200896, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[983] = {id = 983, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200897, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[984] = {id = 984, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201840}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[985] = {id = 985, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200898, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[986] = {id = 986, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200899, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[987] = {id = 987, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200900, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[988] = {id = 988, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200901, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[989] = {id = 989, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200902, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[990] = {id = 990, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200903, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030029, skipTime = 30}
, 
[991] = {id = 991, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201841}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[992] = {id = 992, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201842}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[993] = {id = 993, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201843, 202037}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[994] = {id = 994, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200904, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[995] = {id = 995, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200905, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[996] = {id = 996, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200906, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[997] = {id = 997, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201844}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[998] = {id = 998, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200151}
, 
emotionId = {0, 0}
, contentTextID = 200907, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[999] = {id = 999, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 200151}
, 
emotionId = {0, 0}
, contentTextID = 200908, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1000] = {id = 1000, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201643}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1001] = {id = 1001, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200909, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1002] = {id = 1002, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1003] = {id = 1003, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200152, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200910, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1004] = {id = 1004, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200911, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1005] = {id = 1005, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200140, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200912, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1006] = {id = 1006, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200913, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1007] = {id = 1007, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200914, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1008] = {id = 1008, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200142, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200915, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1009] = {id = 1009, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201845}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1010] = {id = 1010, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200916, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1011] = {id = 1011, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200917, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1012] = {id = 1012, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201846}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1013] = {id = 1013, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200918, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050004, skipTime = 30}
, 
[1014] = {id = 1014, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200919, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1015] = {id = 1015, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200920, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1016] = {id = 1016, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200921, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1017] = {id = 1017, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201847}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1018] = {id = 1018, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200922, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1019] = {id = 1019, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200923, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1020] = {id = 1020, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200924, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1021] = {id = 1021, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201848}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1022] = {id = 1022, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200925, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1023] = {id = 1023, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200926, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1024] = {id = 1024, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201849}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1025] = {id = 1025, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200927, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1026] = {id = 1026, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200928, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1027] = {id = 1027, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200929, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1028] = {id = 1028, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200930, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1029] = {id = 1029, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201850}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1030] = {id = 1030, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200931, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1031] = {id = 1031, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200932, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050073, skipTime = 30}
, 
[1032] = {id = 1032, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201851}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1033] = {id = 1033, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200933, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050074, skipTime = 30}
, 
[1034] = {id = 1034, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {200934}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1035] = {id = 1035, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200935, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050075, skipTime = 30}
, 
[1036] = {id = 1036, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201771}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1037] = {id = 1037, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200613, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050076, skipTime = 30}
, 
[1038] = {id = 1038, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200611, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050077, skipTime = 30}
, 
[1039] = {id = 1039, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201852}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1040] = {id = 1040, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200936, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050078, skipTime = 30}
, 
[1041] = {id = 1041, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200937, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050077, skipTime = 30}
, 
[1042] = {id = 1042, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200938, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050019, skipTime = 30}
, 
[1043] = {id = 1043, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200939, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500221, skipTime = 30}
, 
[1044] = {id = 1044, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200136, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200940, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500222, skipTime = 30}
, 
[1045] = {id = 1045, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200941, speed = "0.02", 
chooseTextID = {201853}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1046] = {id = 1046, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200942, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1047] = {id = 1047, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200943, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1048] = {id = 1048, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200944, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1049] = {id = 1049, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200945, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1050] = {id = 1050, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201854}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1051] = {id = 1051, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200946, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050023, skipTime = 30}
, 
[1052] = {id = 1052, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200947, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1053] = {id = 1053, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200137, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200642, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1054] = {id = 1054, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200948, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1055] = {id = 1055, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201855}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1056] = {id = 1056, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200949, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1057] = {id = 1057, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200950, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1058] = {id = 1058, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200951, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1059] = {id = 1059, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200952, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1060] = {id = 1060, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200133, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200953, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1061] = {id = 1061, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200135, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200954, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500342, skipTime = 30}
, 
[1062] = {id = 1062, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200955, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1063] = {id = 1063, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200956, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1064] = {id = 1064, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200633, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1065] = {id = 1065, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200957, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1066] = {id = 1066, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200958, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1067] = {id = 1067, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200959, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050049, skipTime = 30}
, 
[1068] = {id = 1068, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201856}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1069] = {id = 1069, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200960, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050050, skipTime = 30}
, 
[1070] = {id = 1070, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200961, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1071] = {id = 1071, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201857}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1072] = {id = 1072, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200962, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1073] = {id = 1073, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200963, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050051, skipTime = 30}
, 
[1074] = {id = 1074, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200964, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050052, skipTime = 30}
, 
[1075] = {id = 1075, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200965, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050053, skipTime = 30}
, 
[1076] = {id = 1076, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200966, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1077] = {id = 1077, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201858, 202038}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1078] = {id = 1078, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200967, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050054, skipTime = 30}
, 
[1079] = {id = 1079, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200968, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500551, skipTime = 30}
, 
[1080] = {id = 1080, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200969, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500552, skipTime = 30}
, 
[1081] = {id = 1081, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200970, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1082] = {id = 1082, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1083] = {id = 1083, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200971, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1084] = {id = 1084, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201822}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1085] = {id = 1085, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200972, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050056, skipTime = 30}
, 
[1086] = {id = 1086, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200149, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200973, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1087] = {id = 1087, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200974, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1088] = {id = 1088, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200975, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050060, skipTime = 30}
, 
[1089] = {id = 1089, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201859}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1090] = {id = 1090, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200976, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050062, skipTime = 30}
, 
[1091] = {id = 1091, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200977, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030088, skipTime = 30}
, 
[1092] = {id = 1092, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200978, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1093] = {id = 1093, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200979, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1094] = {id = 1094, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200980, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1095] = {id = 1095, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200981, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1096] = {id = 1096, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200982, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060007, skipTime = 30}
, 
[1097] = {id = 1097, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201860}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1098] = {id = 1098, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200983, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060008, skipTime = 30}
, 
[1099] = {id = 1099, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201861}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1100] = {id = 1100, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200984, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1101] = {id = 1101, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200985, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1102] = {id = 1102, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200986, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060009, skipTime = 30}
, 
[1103] = {id = 1103, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200987, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060010, skipTime = 30}
, 
[1104] = {id = 1104, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201862, 202039}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1105] = {id = 1105, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200988, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060011, skipTime = 30}
, 
[1106] = {id = 1106, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200989, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060012, skipTime = 30}
, 
[1107] = {id = 1107, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200990, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600131, skipTime = 30}
, 
[1108] = {id = 1108, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200991, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600132, skipTime = 30}
, 
[1109] = {id = 1109, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200992, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600141, skipTime = 30}
, 
[1110] = {id = 1110, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200993, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600142, skipTime = 30}
, 
[1111] = {id = 1111, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201753}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1112] = {id = 1112, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200994, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600151, skipTime = 30}
, 
[1113] = {id = 1113, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200995, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600152, skipTime = 30}
, 
[1114] = {id = 1114, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200996, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060016, skipTime = 30}
, 
[1115] = {id = 1115, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201863}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1116] = {id = 1116, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200997, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600171, skipTime = 30}
, 
[1117] = {id = 1117, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200998, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600172, skipTime = 30}
, 
[1118] = {id = 1118, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201864}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1119] = {id = 1119, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200999, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1120] = {id = 1120, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201000, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1121] = {id = 1121, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201001, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1122] = {id = 1122, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201002, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060018, skipTime = 30}
, 
[1123] = {id = 1123, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201865}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1124] = {id = 1124, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201003, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1125] = {id = 1125, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201004, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1126] = {id = 1126, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201866}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1127] = {id = 1127, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201005, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1128] = {id = 1128, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201867}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1129] = {id = 1129, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201006, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060019, skipTime = 30}
, 
[1130] = {id = 1130, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201868}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1131] = {id = 1131, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201007, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1132] = {id = 1132, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201869}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1133] = {id = 1133, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201008, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1134] = {id = 1134, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201009, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060020, skipTime = 30}
, 
[1135] = {id = 1135, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1136] = {id = 1136, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201010, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600211, skipTime = 30}
, 
[1137] = {id = 1137, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201011, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600212, skipTime = 30}
, 
[1138] = {id = 1138, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1139] = {id = 1139, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201012, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1140] = {id = 1140, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201870, 202040}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1141] = {id = 1141, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 200709, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1142] = {id = 1142, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201871}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1143] = {id = 1143, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201013, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1144] = {id = 1144, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201872}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1145] = {id = 1145, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201014, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060022, skipTime = 30}
, 
[1146] = {id = 1146, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201015, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060023, skipTime = 30}
, 
[1147] = {id = 1147, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201873}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1148] = {id = 1148, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201874}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1149] = {id = 1149, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 200877, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060024, skipTime = 30}
, 
[1150] = {id = 1150, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201875, 202041}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1151] = {id = 1151, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201016, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1152] = {id = 1152, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201017, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060025, skipTime = 30}
, 
[1153] = {id = 1153, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201018, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060026, skipTime = 30}
, 
[1154] = {id = 1154, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201876}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1155] = {id = 1155, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201019, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060027, skipTime = 30}
, 
[1156] = {id = 1156, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201020, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060028, skipTime = 30}
, 
[1157] = {id = 1157, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201021, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060029, skipTime = 30}
, 
[1158] = {id = 1158, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201877}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1159] = {id = 1159, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201022, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1160] = {id = 1160, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201023, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1161] = {id = 1161, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201024, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1162] = {id = 1162, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201025, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1163] = {id = 1163, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201026, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1164] = {id = 1164, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201027, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060030, skipTime = 30}
, 
[1165] = {id = 1165, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201878}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1166] = {id = 1166, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201028, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060031, skipTime = 30}
, 
[1167] = {id = 1167, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201879}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1168] = {id = 1168, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201029, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1169] = {id = 1169, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201030, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1170] = {id = 1170, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201031, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1171] = {id = 1171, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201032, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060032, skipTime = 30}
, 
[1172] = {id = 1172, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201880}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1173] = {id = 1173, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201033, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060033, skipTime = 30}
, 
[1174] = {id = 1174, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201034, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060034, skipTime = 30}
, 
[1175] = {id = 1175, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201035, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600351, skipTime = 30}
, 
[1176] = {id = 1176, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201036, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600352, skipTime = 30}
, 
[1177] = {id = 1177, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201037, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060036, skipTime = 30}
, 
[1178] = {id = 1178, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201038, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060037, skipTime = 30}
, 
[1179] = {id = 1179, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201039, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060043, skipTime = 30}
, 
[1180] = {id = 1180, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201040, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060044, skipTime = 30}
, 
[1181] = {id = 1181, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201041, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060045, skipTime = 30}
, 
[1182] = {id = 1182, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201881}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1183] = {id = 1183, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201042, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600501, skipTime = 30}
, 
[1184] = {id = 1184, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201043, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600502, skipTime = 30}
, 
[1185] = {id = 1185, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201882, 202042}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1186] = {id = 1186, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201044, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060051, skipTime = 30}
, 
[1187] = {id = 1187, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201045, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1188] = {id = 1188, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201883}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1189] = {id = 1189, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201046, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060052, skipTime = 30}
, 
[1190] = {id = 1190, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201884, 202043}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1191] = {id = 1191, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201047, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600531, skipTime = 30}
, 
[1192] = {id = 1192, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201048, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600532, skipTime = 30}
, 
[1193] = {id = 1193, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201049, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060054, skipTime = 30}
, 
[1194] = {id = 1194, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201050, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600551, skipTime = 30}
, 
[1195] = {id = 1195, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201051, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600552, skipTime = 30}
, 
[1196] = {id = 1196, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201885}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1197] = {id = 1197, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200155, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201052, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1198] = {id = 1198, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200998, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1199] = {id = 1199, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201053, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1200] = {id = 1200, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201631}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1201] = {id = 1201, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201054, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1202] = {id = 1202, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201886}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1203] = {id = 1203, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201055, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1204] = {id = 1204, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201056, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1205] = {id = 1205, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201057, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1206] = {id = 1206, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201887}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1207] = {id = 1207, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201058, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1208] = {id = 1208, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201059, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1209] = {id = 1209, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201060, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1210] = {id = 1210, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201061, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060056, skipTime = 30}
, 
[1211] = {id = 1211, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201888}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1212] = {id = 1212, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201062, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060057, skipTime = 30}
, 
[1213] = {id = 1213, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201063, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1214] = {id = 1214, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201889}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1215] = {id = 1215, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201064, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1216] = {id = 1216, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201065, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1217] = {id = 1217, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201066, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600581, skipTime = 30}
, 
[1218] = {id = 1218, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201067, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600582, skipTime = 30}
, 
[1219] = {id = 1219, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201890}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1220] = {id = 1220, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201068, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600591, skipTime = 30}
, 
[1221] = {id = 1221, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201069, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600592, skipTime = 30}
, 
[1222] = {id = 1222, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201070, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600593, skipTime = 30}
, 
[1223] = {id = 1223, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200170}
, 
emotionId = {0, 0}
, contentTextID = 201071, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060060, skipTime = 30}
, 
[1224] = {id = 1224, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200170}
, 
emotionId = {0, 0}
, contentTextID = 201072, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060061, skipTime = 30}
, 
[1225] = {id = 1225, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201073, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060062, skipTime = 30}
, 
[1226] = {id = 1226, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201673}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1227] = {id = 1227, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201074, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600631, skipTime = 30}
, 
[1228] = {id = 1228, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201075, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600632, skipTime = 30}
, 
[1229] = {id = 1229, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201076, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600633, skipTime = 30}
, 
[1230] = {id = 1230, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201891}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1231] = {id = 1231, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201077, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600641, skipTime = 30}
, 
[1232] = {id = 1232, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201078, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1233] = {id = 1233, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201079, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600642, skipTime = 30}
, 
[1234] = {id = 1234, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201080, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060065, skipTime = 30}
, 
[1235] = {id = 1235, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1236] = {id = 1236, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201081, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060066, skipTime = 30}
, 
[1237] = {id = 1237, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201082, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1238] = {id = 1238, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201083, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600671, skipTime = 30}
, 
[1239] = {id = 1239, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201084, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600672, skipTime = 30}
, 
[1240] = {id = 1240, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201892}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1241] = {id = 1241, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201085, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600681, skipTime = 30}
, 
[1242] = {id = 1242, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 201086, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600682, skipTime = 30}
, 
[1243] = {id = 1243, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201087, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060069, skipTime = 30}
, 
[1244] = {id = 1244, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201893}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1245] = {id = 1245, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201088, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060070, skipTime = 30}
, 
[1246] = {id = 1246, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201894, 202044}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1247] = {id = 1247, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201089, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060071, skipTime = 30}
, 
[1248] = {id = 1248, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201090, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1249] = {id = 1249, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201091, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1250] = {id = 1250, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201895}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1251] = {id = 1251, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201092, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060072, skipTime = 30}
, 
[1252] = {id = 1252, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201896}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1253] = {id = 1253, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201093, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600731, skipTime = 30}
, 
[1254] = {id = 1254, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201094, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600732, skipTime = 30}
, 
[1255] = {id = 1255, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201095, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600733, skipTime = 30}
, 
[1256] = {id = 1256, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201096, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1257] = {id = 1257, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201097, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1258] = {id = 1258, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5016, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201098, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600741, skipTime = 30}
, 
[1259] = {id = 1259, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5016, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201099, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600742, skipTime = 30}
, 
[1260] = {id = 1260, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201100, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060075, skipTime = 30}
, 
[1261] = {id = 1261, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5016, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201101, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060076, skipTime = 30}
, 
[1262] = {id = 1262, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201102, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060077, skipTime = 30}
, 
[1263] = {id = 1263, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5016, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201103, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060078, skipTime = 30}
, 
[1264] = {id = 1264, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202087}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1265] = {id = 1265, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201104, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060079, skipTime = 30}
, 
[1266] = {id = 1266, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201897}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1267] = {id = 1267, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201105, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060080, skipTime = 30}
, 
[1268] = {id = 1268, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201898}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1269] = {id = 1269, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201106, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060081, skipTime = 30}
, 
[1270] = {id = 1270, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 200782, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600821, skipTime = 30}
, 
[1271] = {id = 1271, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201107, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600822, skipTime = 30}
, 
[1272] = {id = 1272, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201108, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060083, skipTime = 30}
, 
[1273] = {id = 1273, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201109, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060087, skipTime = 30}
, 
[1274] = {id = 1274, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201110, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060088, skipTime = 30}
, 
[1275] = {id = 1275, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201111, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060089, skipTime = 30}
, 
[1276] = {id = 1276, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201112, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060090, skipTime = 30}
, 
[1277] = {id = 1277, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201113, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060091, skipTime = 30}
, 
[1278] = {id = 1278, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 0}
, contentTextID = 201114, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060092, skipTime = 30}
, 
[1279] = {id = 1279, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201115, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060093, skipTime = 30}
, 
[1280] = {id = 1280, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201899}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1281] = {id = 1281, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201116, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600941, skipTime = 30}
, 
[1282] = {id = 1282, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201117, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600942, skipTime = 30}
, 
[1283] = {id = 1283, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200157, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201118, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600943, skipTime = 30}
, 
[1284] = {id = 1284, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1285] = {id = 1285, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201900}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1286] = {id = 1286, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201119, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060095, skipTime = 30}
, 
[1287] = {id = 1287, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201901}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1288] = {id = 1288, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201120, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060096, skipTime = 30}
, 
[1289] = {id = 1289, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201902}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1290] = {id = 1290, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201121, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060097, skipTime = 30}
, 
[1291] = {id = 1291, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201122, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600981, skipTime = 30}
, 
[1292] = {id = 1292, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201123, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600982, skipTime = 30}
, 
[1293] = {id = 1293, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201903}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1294] = {id = 1294, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201124, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060099, skipTime = 30}
, 
[1295] = {id = 1295, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201904}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1296] = {id = 1296, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201125, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200601001, skipTime = 30}
, 
[1297] = {id = 1297, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201126, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200601002, skipTime = 30}
, 
[1298] = {id = 1298, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201905}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1299] = {id = 1299, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 200265, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200601021, skipTime = 30}
, 
[1300] = {id = 1300, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201127, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200601022, skipTime = 30}
, 
[1301] = {id = 1301, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201128, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1302] = {id = 1302, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201129, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1303] = {id = 1303, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201906}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1304] = {id = 1304, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201130, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010014, skipTime = 30}
, 
[1305] = {id = 1305, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201131, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1306] = {id = 1306, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201132, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1307] = {id = 1307, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201133, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060003, skipTime = 30}
, 
[1308] = {id = 1308, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1309] = {id = 1309, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201134, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060004, skipTime = 30}
, 
[1310] = {id = 1310, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201135, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060005, skipTime = 30}
, 
[1311] = {id = 1311, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201136, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060006, skipTime = 30}
, 
[1312] = {id = 1312, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201907}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1313] = {id = 1313, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200825, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060001, skipTime = 30}
, 
[1314] = {id = 1314, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649, 202045}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1315] = {id = 1315, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 200826, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060002, skipTime = 30}
, 
[1316] = {id = 1316, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201134, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060004, skipTime = 30}
, 
[1317] = {id = 1317, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201135, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060005, skipTime = 30}
, 
[1318] = {id = 1318, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201137, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060006, skipTime = 30}
, 
[1319] = {id = 1319, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0", 
chooseTextID = {201908}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1320] = {id = 1320, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201138, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060038, skipTime = 30}
, 
[1321] = {id = 1321, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201139, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060107, skipTime = 30}
, 
[1322] = {id = 1322, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201140, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060039, skipTime = 30}
, 
[1323] = {id = 1323, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201141, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060040, skipTime = 30}
, 
[1324] = {id = 1324, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201142, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060041, skipTime = 30}
, 
[1325] = {id = 1325, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201909}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1326] = {id = 1326, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201143, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1327] = {id = 1327, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201144, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060042, skipTime = 30}
, 
[1328] = {id = 1328, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201145, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060046, skipTime = 30}
, 
[1329] = {id = 1329, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201146, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060047, skipTime = 30}
, 
[1330] = {id = 1330, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201147, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060048, skipTime = 30}
, 
[1331] = {id = 1331, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 201148, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060049, skipTime = 30}
, 
[1332] = {id = 1332, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201910}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1333] = {id = 1333, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201149, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070001, skipTime = 30}
, 
[1334] = {id = 1334, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201911}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1335] = {id = 1335, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201150, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1336] = {id = 1336, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201151, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1337] = {id = 1337, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201152, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070002, skipTime = 30}
, 
[1338] = {id = 1338, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1339] = {id = 1339, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201153, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700031, skipTime = 30}
, 
[1340] = {id = 1340, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201154, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700032, skipTime = 30}
, 
[1341] = {id = 1341, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201155, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700033, skipTime = 30}
, 
[1342] = {id = 1342, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201156, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070004, skipTime = 30}
, 
[1343] = {id = 1343, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201157, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1344] = {id = 1344, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1345] = {id = 1345, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201912}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1346] = {id = 1346, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201158, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070005, skipTime = 30}
, 
[1347] = {id = 1347, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201159, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1348] = {id = 1348, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201913}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1349] = {id = 1349, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201160, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070006, skipTime = 30}
, 
[1350] = {id = 1350, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201161, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1351] = {id = 1351, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201162, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070007, skipTime = 30}
, 
[1352] = {id = 1352, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201163, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1353] = {id = 1353, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201164, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070008, skipTime = 30}
, 
[1354] = {id = 1354, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 201165, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070009, skipTime = 30}
, 
[1355] = {id = 1355, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201166, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070010, skipTime = 30}
, 
[1356] = {id = 1356, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201167, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1357] = {id = 1357, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 201168, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070011, skipTime = 30}
, 
[1358] = {id = 1358, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201169, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700121, skipTime = 30}
, 
[1359] = {id = 1359, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201170, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700122, skipTime = 30}
, 
[1360] = {id = 1360, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 201171, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700131, skipTime = 30}
, 
[1361] = {id = 1361, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 201172, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700132, skipTime = 30}
, 
[1362] = {id = 1362, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 201173, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1363] = {id = 1363, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201174, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070014, skipTime = 30}
, 
[1364] = {id = 1364, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200148, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201175, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1365] = {id = 1365, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20061}
, 
nameTextID = {202064, 200139}
, 
emotionId = {0, 0}
, contentTextID = 200606, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070015, skipTime = 30}
, 
[1366] = {id = 1366, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201914}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1367] = {id = 1367, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200482, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1368] = {id = 1368, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200483, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700161, skipTime = 30}
, 
[1369] = {id = 1369, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200484, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700162, skipTime = 30}
, 
[1370] = {id = 1370, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201915}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1371] = {id = 1371, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201176, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700171, skipTime = 30}
, 
[1372] = {id = 1372, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201177, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700172, skipTime = 30}
, 
[1373] = {id = 1373, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1374] = {id = 1374, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201178, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1375] = {id = 1375, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201179, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070018, skipTime = 30}
, 
[1376] = {id = 1376, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201916}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1377] = {id = 1377, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201180, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1378] = {id = 1378, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201917}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1379] = {id = 1379, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201181, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1380] = {id = 1380, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201182, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1381] = {id = 1381, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201183, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1382] = {id = 1382, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1383] = {id = 1383, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201184, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070019, skipTime = 30}
, 
[1384] = {id = 1384, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201185, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070020, skipTime = 30}
, 
[1385] = {id = 1385, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201186, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070021, skipTime = 30}
, 
[1386] = {id = 1386, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201187, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1387] = {id = 1387, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201188, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1388] = {id = 1388, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201189, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1389] = {id = 1389, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201190, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1390] = {id = 1390, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201191, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070022, skipTime = 30}
, 
[1391] = {id = 1391, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201918}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1392] = {id = 1392, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201192, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1393] = {id = 1393, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201193, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700231, skipTime = 30}
, 
[1394] = {id = 1394, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201194, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700232, skipTime = 30}
, 
[1395] = {id = 1395, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201195, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070024, skipTime = 30}
, 
[1396] = {id = 1396, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201919}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1397] = {id = 1397, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201196, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1398] = {id = 1398, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201197, speed = "0", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1399] = {id = 1399, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201920}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1400] = {id = 1400, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201198, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1401] = {id = 1401, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201199, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1402] = {id = 1402, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201200, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070025, skipTime = 30}
, 
[1403] = {id = 1403, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201201, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1404] = {id = 1404, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201202, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1405] = {id = 1405, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201203, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700261, skipTime = 30}
, 
[1406] = {id = 1406, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201204, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700262, skipTime = 30}
, 
[1407] = {id = 1407, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201205, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1408] = {id = 1408, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201206, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1409] = {id = 1409, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201207, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1410] = {id = 1410, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201208, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070027, skipTime = 30}
, 
[1411] = {id = 1411, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201209, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700281, skipTime = 30}
, 
[1412] = {id = 1412, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201210, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700282, skipTime = 30}
, 
[1413] = {id = 1413, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201921}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1414] = {id = 1414, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201211, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1415] = {id = 1415, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201212, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070029, skipTime = 30}
, 
[1416] = {id = 1416, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1417] = {id = 1417, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201213, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070030, skipTime = 30}
, 
[1418] = {id = 1418, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201214, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070032, skipTime = 30}
, 
[1419] = {id = 1419, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201922}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1420] = {id = 1420, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201215, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070033, skipTime = 30}
, 
[1421] = {id = 1421, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201923}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1422] = {id = 1422, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201216, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070034, skipTime = 30}
, 
[1423] = {id = 1423, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201924}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1424] = {id = 1424, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201217, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070035, skipTime = 30}
, 
[1425] = {id = 1425, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201925}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1426] = {id = 1426, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201218, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1427] = {id = 1427, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201219, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1428] = {id = 1428, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201220, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700361, skipTime = 30}
, 
[1429] = {id = 1429, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201221, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700362, skipTime = 30}
, 
[1430] = {id = 1430, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201926}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1431] = {id = 1431, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201222, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1432] = {id = 1432, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201223, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1433] = {id = 1433, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201224, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1434] = {id = 1434, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200158, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201225, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070037, skipTime = 30}
, 
[1435] = {id = 1435, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 202070}
, 
emotionId = {0, 0}
, contentTextID = 201226, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070038, skipTime = 30}
, 
[1436] = {id = 1436, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201927}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1437] = {id = 1437, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201227, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1438] = {id = 1438, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201228, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1439] = {id = 1439, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201229, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1440] = {id = 1440, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201230, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1441] = {id = 1441, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201231, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1442] = {id = 1442, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201232, speed = "0.02", 
chooseTextID = {201928}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1443] = {id = 1443, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201233, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1444] = {id = 1444, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201234, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1445] = {id = 1445, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201235, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1446] = {id = 1446, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201236, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700391, skipTime = 30}
, 
[1447] = {id = 1447, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201237, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700392, skipTime = 30}
, 
[1448] = {id = 1448, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201238, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1449] = {id = 1449, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201929, 202046}
, 
chooseValue = {1110, 1111}
, voiceId = 0, skipTime = 30}
, 
[1450] = {id = 1450, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201239, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070040, skipTime = 30}
, 
[1451] = {id = 1451, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1452] = {id = 1452, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201240, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070041, skipTime = 30}
, 
[1453] = {id = 1453, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201930}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1454] = {id = 1454, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070042, skipTime = 30}
, 
[1455] = {id = 1455, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201931}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1456] = {id = 1456, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201242, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700431, skipTime = 30}
, 
[1457] = {id = 1457, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201243, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700432, skipTime = 30}
, 
[1458] = {id = 1458, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201244, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1459] = {id = 1459, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201930}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1460] = {id = 1460, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1461] = {id = 1461, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201931}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1462] = {id = 1462, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201242, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1463] = {id = 1463, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201243, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1464] = {id = 1464, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201245, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1465] = {id = 1465, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201246, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1466] = {id = 1466, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201247, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1467] = {id = 1467, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201248, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1468] = {id = 1468, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201249, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1469] = {id = 1469, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1470] = {id = 1470, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201250, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070044, skipTime = 30}
, 
[1471] = {id = 1471, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201932}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1472] = {id = 1472, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201251, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070045, skipTime = 30}
, 
[1473] = {id = 1473, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201252, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1474] = {id = 1474, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1475] = {id = 1475, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201253, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1476] = {id = 1476, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201254, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1477] = {id = 1477, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201255, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070046, skipTime = 30}
, 
[1478] = {id = 1478, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201933}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1479] = {id = 1479, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201934, 202047}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1480] = {id = 1480, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201256, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070047, skipTime = 30}
, 
[1481] = {id = 1481, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201257, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070048, skipTime = 30}
, 
[1482] = {id = 1482, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201935}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1483] = {id = 1483, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201258, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1484] = {id = 1484, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201259, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700491, skipTime = 30}
, 
[1485] = {id = 1485, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201260, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700492, skipTime = 30}
, 
[1486] = {id = 1486, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201936}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1487] = {id = 1487, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201261, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1488] = {id = 1488, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1489] = {id = 1489, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201262, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700501, skipTime = 30}
, 
[1490] = {id = 1490, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201263, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700502, skipTime = 30}
, 
[1491] = {id = 1491, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201937}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1492] = {id = 1492, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201264, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1493] = {id = 1493, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201265, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1494] = {id = 1494, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1495] = {id = 1495, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201266, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1496] = {id = 1496, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201267, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070051, skipTime = 30}
, 
[1497] = {id = 1497, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201268, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1498] = {id = 1498, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201269, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070052, skipTime = 30}
, 
[1499] = {id = 1499, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201938}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1500] = {id = 1500, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201270, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1501] = {id = 1501, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1035}
, 
nameTextID = {202064, 200159}
, 
emotionId = {0, 0}
, contentTextID = 201271, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070053, skipTime = 30}
, 
[1502] = {id = 1502, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1503] = {id = 1503, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201272, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1504] = {id = 1504, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1505] = {id = 1505, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201274, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1506] = {id = 1506, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1507] = {id = 1507, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201275, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1508] = {id = 1508, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201939}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1509] = {id = 1509, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201276, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1510] = {id = 1510, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201940}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1511] = {id = 1511, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201277, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1512] = {id = 1512, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 201278, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1513] = {id = 1513, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200172}
, 
emotionId = {0, 0}
, contentTextID = 200755, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1514] = {id = 1514, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200824, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1515] = {id = 1515, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201279, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1516] = {id = 1516, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201941}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1517] = {id = 1517, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1518] = {id = 1518, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201942}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1519] = {id = 1519, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1520] = {id = 1520, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201768}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1521] = {id = 1521, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200607, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1522] = {id = 1522, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201943}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1523] = {id = 1523, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200160, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201280, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1524] = {id = 1524, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200161, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200615, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1525] = {id = 1525, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1526] = {id = 1526, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200158}
, 
emotionId = {0, 0}
, contentTextID = 201281, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070054, skipTime = 30}
, 
[1527] = {id = 1527, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201944}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1528] = {id = 1528, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200158}
, 
emotionId = {0, 0}
, contentTextID = 201282, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070055, skipTime = 30}
, 
[1529] = {id = 1529, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200158}
, 
emotionId = {0, 0}
, contentTextID = 201283, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070056, skipTime = 30}
, 
[1530] = {id = 1530, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201284, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1531] = {id = 1531, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201945}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1532] = {id = 1532, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201285, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1533] = {id = 1533, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201286, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1534] = {id = 1534, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200621, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1535] = {id = 1535, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200622, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1536] = {id = 1536, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201287, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1537] = {id = 1537, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201288, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1538] = {id = 1538, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1539] = {id = 1539, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201289, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1540] = {id = 1540, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201290, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070057, skipTime = 30}
, 
[1541] = {id = 1541, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201946}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1542] = {id = 1542, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201291, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1543] = {id = 1543, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201292, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070058, skipTime = 30}
, 
[1544] = {id = 1544, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201947}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1545] = {id = 1545, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201293, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1546] = {id = 1546, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201294, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070059, skipTime = 30}
, 
[1547] = {id = 1547, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 200625, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1548] = {id = 1548, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201295, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1549] = {id = 1549, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201296, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1550] = {id = 1550, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201296, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1551] = {id = 1551, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201948}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1552] = {id = 1552, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201297, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070060, skipTime = 30}
, 
[1553] = {id = 1553, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201949}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1554] = {id = 1554, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201298, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1555] = {id = 1555, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201299, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1556] = {id = 1556, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201300, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1557] = {id = 1557, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201950}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1558] = {id = 1558, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201301, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700611, skipTime = 30}
, 
[1559] = {id = 1559, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200137}
, 
emotionId = {0, 0}
, contentTextID = 201302, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700612, skipTime = 30}
, 
[1560] = {id = 1560, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201951}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1561] = {id = 1561, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201952}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1562] = {id = 1562, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201953}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1563] = {id = 1563, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201303, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070062, skipTime = 30}
, 
[1564] = {id = 1564, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201954}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1565] = {id = 1565, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201304, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070063, skipTime = 30}
, 
[1566] = {id = 1566, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201955}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1567] = {id = 1567, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201305, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1568] = {id = 1568, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201306, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070064, skipTime = 30}
, 
[1569] = {id = 1569, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201956}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1570] = {id = 1570, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201307, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1571] = {id = 1571, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201308, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070065, skipTime = 30}
, 
[1572] = {id = 1572, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201957}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1573] = {id = 1573, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201309, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1574] = {id = 1574, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201310, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1575] = {id = 1575, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201958}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1576] = {id = 1576, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201959}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1577] = {id = 1577, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201311, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700661, skipTime = 30}
, 
[1578] = {id = 1578, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201312, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700662, skipTime = 30}
, 
[1579] = {id = 1579, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200130}
, 
emotionId = {0, 0}
, contentTextID = 201313, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1580] = {id = 1580, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201960}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1581] = {id = 1581, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201314, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070067, skipTime = 30}
, 
[1582] = {id = 1582, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201315, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1583] = {id = 1583, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201316, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1584] = {id = 1584, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200645, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500631, skipTime = 30}
, 
[1585] = {id = 1585, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200646, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500632, skipTime = 30}
, 
[1586] = {id = 1586, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201961}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1587] = {id = 1587, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200647, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050064, skipTime = 30}
, 
[1588] = {id = 1588, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200648, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050065, skipTime = 30}
, 
[1589] = {id = 1589, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201317, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1590] = {id = 1590, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201318, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070068, skipTime = 30}
, 
[1591] = {id = 1591, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201961}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1592] = {id = 1592, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201319, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070069, skipTime = 30}
, 
[1593] = {id = 1593, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201320, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070070, skipTime = 30}
, 
[1594] = {id = 1594, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1595] = {id = 1595, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1596] = {id = 1596, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201962}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1597] = {id = 1597, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201321, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070071, skipTime = 30}
, 
[1598] = {id = 1598, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201322, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1599] = {id = 1599, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201323, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070072, skipTime = 30}
, 
[1600] = {id = 1600, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201324, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070073, skipTime = 30}
, 
[1601] = {id = 1601, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201325, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070074, skipTime = 30}
, 
[1602] = {id = 1602, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201326, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070075, skipTime = 30}
, 
[1603] = {id = 1603, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201327, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070076, skipTime = 30}
, 
[1604] = {id = 1604, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201963}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1605] = {id = 1605, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201328, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070077, skipTime = 30}
, 
[1606] = {id = 1606, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201964}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1607] = {id = 1607, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201329, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070078, skipTime = 30}
, 
[1608] = {id = 1608, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1609] = {id = 1609, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201330, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070079, skipTime = 30}
, 
[1610] = {id = 1610, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201965}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1611] = {id = 1611, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201331, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1612] = {id = 1612, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201332, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700801, skipTime = 30}
, 
[1613] = {id = 1613, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201333, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700802, skipTime = 30}
, 
[1614] = {id = 1614, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201966}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1615] = {id = 1615, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201334, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700811, skipTime = 30}
, 
[1616] = {id = 1616, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201335, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700812, skipTime = 30}
, 
[1617] = {id = 1617, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201967}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1618] = {id = 1618, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201336, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1619] = {id = 1619, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201337, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070082, skipTime = 30}
, 
[1620] = {id = 1620, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201968}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1621] = {id = 1621, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1622] = {id = 1622, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201338, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070083, skipTime = 30}
, 
[1623] = {id = 1623, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201969}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1624] = {id = 1624, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1625] = {id = 1625, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201339, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1626] = {id = 1626, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201970}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1627] = {id = 1627, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201340, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700841, skipTime = 30}
, 
[1628] = {id = 1628, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201341, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700842, skipTime = 30}
, 
[1629] = {id = 1629, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201342, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070085, skipTime = 30}
, 
[1630] = {id = 1630, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1631] = {id = 1631, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201343, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1632] = {id = 1632, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 200732, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1633] = {id = 1633, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 200716, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1634] = {id = 1634, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201798}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1635] = {id = 1635, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201344, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1636] = {id = 1636, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200718, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1637] = {id = 1637, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200719, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1638] = {id = 1638, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200720, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1639] = {id = 1639, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201799}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1640] = {id = 1640, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200721, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1641] = {id = 1641, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201345, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070086, skipTime = 30}
, 
[1642] = {id = 1642, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201346, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070087, skipTime = 30}
, 
[1643] = {id = 1643, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201347, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070088, skipTime = 30}
, 
[1644] = {id = 1644, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201348, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1645] = {id = 1645, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201349, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1646] = {id = 1646, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201350, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1647] = {id = 1647, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201351, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1648] = {id = 1648, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201352, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070089, skipTime = 30}
, 
[1649] = {id = 1649, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201353, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070090, skipTime = 30}
, 
[1650] = {id = 1650, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201354, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1651] = {id = 1651, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201971}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1652] = {id = 1652, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201355, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070091, skipTime = 30}
, 
[1653] = {id = 1653, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201356, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070092, skipTime = 30}
, 
[1654] = {id = 1654, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1655] = {id = 1655, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201357, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1656] = {id = 1656, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201972}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1657] = {id = 1657, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201358, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070093, skipTime = 30}
, 
[1658] = {id = 1658, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201359, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070094, skipTime = 30}
, 
[1659] = {id = 1659, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1660] = {id = 1660, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201360, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1661] = {id = 1661, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201973}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1662] = {id = 1662, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201361, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700951, skipTime = 30}
, 
[1663] = {id = 1663, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201362, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700952, skipTime = 30}
, 
[1664] = {id = 1664, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1665] = {id = 1665, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201363, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070096, skipTime = 30}
, 
[1666] = {id = 1666, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201364, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1667] = {id = 1667, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201365, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1668] = {id = 1668, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201366, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1669] = {id = 1669, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201974}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1670] = {id = 1670, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201367, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1671] = {id = 1671, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201368, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070097, skipTime = 30}
, 
[1672] = {id = 1672, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201369, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070098, skipTime = 30}
, 
[1673] = {id = 1673, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201370, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700991, skipTime = 30}
, 
[1674] = {id = 1674, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201371, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700992, skipTime = 30}
, 
[1675] = {id = 1675, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201372, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070100, skipTime = 30}
, 
[1676] = {id = 1676, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201753}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1677] = {id = 1677, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201373, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070101, skipTime = 30}
, 
[1678] = {id = 1678, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201374, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1679] = {id = 1679, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201375, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1680] = {id = 1680, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201376, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1681] = {id = 1681, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201377, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1682] = {id = 1682, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201378, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1683] = {id = 1683, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201379, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1684] = {id = 1684, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201380, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1685] = {id = 1685, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201381, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1686] = {id = 1686, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201382, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1687] = {id = 1687, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1688] = {id = 1688, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201383, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1689] = {id = 1689, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201304, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1690] = {id = 1690, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201975}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1691] = {id = 1691, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201384, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1692] = {id = 1692, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201385, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1693] = {id = 1693, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1694] = {id = 1694, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201386, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1695] = {id = 1695, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201387, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1696] = {id = 1696, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201388, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1697] = {id = 1697, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201976}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1698] = {id = 1698, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201389, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1699] = {id = 1699, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201977}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1700] = {id = 1700, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201390, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1701] = {id = 1701, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201391, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1702] = {id = 1702, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201392, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1703] = {id = 1703, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201978}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1704] = {id = 1704, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201393, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1705] = {id = 1705, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201394, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1706] = {id = 1706, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201395, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1707] = {id = 1707, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 200716, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1708] = {id = 1708, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201396, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1709] = {id = 1709, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201397, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1710] = {id = 1710, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201398, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1711] = {id = 1711, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200162, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201399, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1712] = {id = 1712, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201400, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1713] = {id = 1713, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201401, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1714] = {id = 1714, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201402, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1715] = {id = 1715, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201403, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1716] = {id = 1716, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201404, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1717] = {id = 1717, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200162}
, 
emotionId = {0, 0}
, contentTextID = 201405, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1718] = {id = 1718, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201406, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1719] = {id = 1719, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201407, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1720] = {id = 1720, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201979}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1721] = {id = 1721, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200163, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201408, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1722] = {id = 1722, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201980}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1723] = {id = 1723, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200163, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201408, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1724] = {id = 1724, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201981}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1725] = {id = 1725, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201409, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1726] = {id = 1726, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201410, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1727] = {id = 1727, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201411, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1728] = {id = 1728, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201412, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1729] = {id = 1729, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201413, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070102, skipTime = 30}
, 
[1730] = {id = 1730, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201982}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1731] = {id = 1731, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201414, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070103, skipTime = 30}
, 
[1732] = {id = 1732, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201983}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1733] = {id = 1733, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1734] = {id = 1734, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201984}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1735] = {id = 1735, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1736] = {id = 1736, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201985}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1737] = {id = 1737, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201415, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1738] = {id = 1738, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201416, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701041, skipTime = 30}
, 
[1739] = {id = 1739, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201417, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701042, skipTime = 30}
, 
[1740] = {id = 1740, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201986}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1741] = {id = 1741, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201418, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070105, skipTime = 30}
, 
[1742] = {id = 1742, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201419, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1743] = {id = 1743, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201420, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1744] = {id = 1744, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201421, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070106, skipTime = 30}
, 
[1745] = {id = 1745, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201422, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1746] = {id = 1746, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201423, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1747] = {id = 1747, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201424, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070107, skipTime = 30}
, 
[1748] = {id = 1748, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201987}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1749] = {id = 1749, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201425, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1750] = {id = 1750, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201426, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1751] = {id = 1751, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201988}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1752] = {id = 1752, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201427, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1753] = {id = 1753, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201428, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070108, skipTime = 30}
, 
[1754] = {id = 1754, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201429, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701091, skipTime = 30}
, 
[1755] = {id = 1755, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201430, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701092, skipTime = 30}
, 
[1756] = {id = 1756, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201431, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1757] = {id = 1757, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201432, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1758] = {id = 1758, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201433, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1759] = {id = 1759, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201989, 202048}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1760] = {id = 1760, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201434, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1761] = {id = 1761, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201990, 202049}
, 
chooseValue = {1161, 1162}
, voiceId = 0, skipTime = 30}
, 
[1762] = {id = 1762, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201435, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1763] = {id = 1763, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201991, 202050, 202057}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1764] = {id = 1764, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201436, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1765] = {id = 1765, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201437, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1766] = {id = 1766, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201438, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1767] = {id = 1767, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201435, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1768] = {id = 1768, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201991, 202050, 202057}
, 
chooseValue = {1163, 1163, 1164}
, voiceId = 0, skipTime = 30}
, 
[1769] = {id = 1769, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1770] = {id = 1770, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201438, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1771] = {id = 1771, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201440, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1772] = {id = 1772, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201441, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1773] = {id = 1773, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201992}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1774] = {id = 1774, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201442, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1775] = {id = 1775, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201443, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1776] = {id = 1776, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201444, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1777] = {id = 1777, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201993}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1778] = {id = 1778, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201445, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1779] = {id = 1779, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201446, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1780] = {id = 1780, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201994}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1781] = {id = 1781, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201447, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1782] = {id = 1782, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201448, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1783] = {id = 1783, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1784] = {id = 1784, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201449, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1785] = {id = 1785, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201450, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1786] = {id = 1786, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201995}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1787] = {id = 1787, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 200439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1788] = {id = 1788, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201451, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1789] = {id = 1789, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1790] = {id = 1790, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201452, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1791] = {id = 1791, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201453, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1792] = {id = 1792, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201454, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1793] = {id = 1793, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201455, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1794] = {id = 1794, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201996}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1795] = {id = 1795, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201456, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1796] = {id = 1796, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201997}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1797] = {id = 1797, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201457, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1798] = {id = 1798, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1799] = {id = 1799, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201998}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1800] = {id = 1800, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201459, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1801] = {id = 1801, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201460, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1802] = {id = 1802, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201461, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1803] = {id = 1803, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1804] = {id = 1804, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200131, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1805] = {id = 1805, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201464, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1806] = {id = 1806, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201999}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1807] = {id = 1807, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201465, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1808] = {id = 1808, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201466, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1809] = {id = 1809, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202000}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1810] = {id = 1810, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201467, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1811] = {id = 1811, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202001}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1812] = {id = 1812, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201468, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070110, skipTime = 30}
, 
[1813] = {id = 1813, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202002}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1814] = {id = 1814, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201469, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1815] = {id = 1815, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201470, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070111, skipTime = 30}
, 
[1816] = {id = 1816, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1817] = {id = 1817, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201471, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1818] = {id = 1818, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202003}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1819] = {id = 1819, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201472, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070112, skipTime = 30}
, 
[1820] = {id = 1820, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201473, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070113, skipTime = 30}
, 
[1821] = {id = 1821, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201474, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1822] = {id = 1822, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201475, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1823] = {id = 1823, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202004}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1824] = {id = 1824, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201476, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1825] = {id = 1825, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070114, skipTime = 30}
, 
[1826] = {id = 1826, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201478, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1827] = {id = 1827, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 201479, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070115, skipTime = 30}
, 
[1828] = {id = 1828, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1035, 0}
, 
nameTextID = {200159, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201480, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070116, skipTime = 30}
, 
[1829] = {id = 1829, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200126}
, 
emotionId = {0, 0}
, contentTextID = 201481, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070117, skipTime = 30}
, 
[1830] = {id = 1830, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200173}
, 
emotionId = {0, 0}
, contentTextID = 201482, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070118, skipTime = 30}
, 
[1831] = {id = 1831, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200173}
, 
emotionId = {0, 0}
, contentTextID = 201483, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070119, skipTime = 30}
, 
[1832] = {id = 1832, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201484, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1833] = {id = 1833, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201485, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1834] = {id = 1834, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201486, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1835] = {id = 1835, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201487, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070120, skipTime = 30}
, 
[1836] = {id = 1836, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201488, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701211, skipTime = 30}
, 
[1837] = {id = 1837, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201489, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701212, skipTime = 30}
, 
[1838] = {id = 1838, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201490, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070122, skipTime = 30}
, 
[1839] = {id = 1839, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202005}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1840] = {id = 1840, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201491, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1841] = {id = 1841, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201492, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070123, skipTime = 30}
, 
[1842] = {id = 1842, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201493, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070124, skipTime = 30}
, 
[1843] = {id = 1843, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201494, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070125, skipTime = 30}
, 
[1844] = {id = 1844, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201411, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070126, skipTime = 30}
, 
[1845] = {id = 1845, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201495, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070127, skipTime = 30}
, 
[1846] = {id = 1846, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201496, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070128, skipTime = 30}
, 
[1847] = {id = 1847, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201497, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701291, skipTime = 30}
, 
[1848] = {id = 1848, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1032}
, 
nameTextID = {202064, 200174}
, 
emotionId = {0, 0}
, contentTextID = 201498, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701292, skipTime = 30}
, 
[1849] = {id = 1849, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201499, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701301, skipTime = 30}
, 
[1850] = {id = 1850, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201500, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701302, skipTime = 30}
, 
[1851] = {id = 1851, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201501, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070131, skipTime = 30}
, 
[1852] = {id = 1852, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201502, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1853] = {id = 1853, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201503, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701321, skipTime = 30}
, 
[1854] = {id = 1854, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201504, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701322, skipTime = 30}
, 
[1855] = {id = 1855, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1856] = {id = 1856, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201505, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070133, skipTime = 30}
, 
[1857] = {id = 1857, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201905}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1858] = {id = 1858, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201506, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1859] = {id = 1859, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201507, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070134, skipTime = 30}
, 
[1860] = {id = 1860, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202006}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1861] = {id = 1861, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201508, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070135, skipTime = 30}
, 
[1862] = {id = 1862, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200110}
, 
emotionId = {0, 0}
, contentTextID = 201509, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070136, skipTime = 30}
, 
[1863] = {id = 1863, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200110}
, 
emotionId = {0, 0}
, contentTextID = 201510, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070137, skipTime = 30}
, 
[1864] = {id = 1864, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201511, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070138, skipTime = 30}
, 
[1865] = {id = 1865, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201512, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701391, skipTime = 30}
, 
[1866] = {id = 1866, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201513, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701392, skipTime = 30}
, 
[1867] = {id = 1867, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201514, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070140, skipTime = 30}
, 
[1868] = {id = 1868, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201515, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070141, skipTime = 30}
, 
[1869] = {id = 1869, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201516, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070142, skipTime = 30}
, 
[1870] = {id = 1870, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201517, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1871] = {id = 1871, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201518, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1872] = {id = 1872, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201519, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1873] = {id = 1873, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201520, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701431, skipTime = 30}
, 
[1874] = {id = 1874, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201521, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701432, skipTime = 30}
, 
[1875] = {id = 1875, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201522, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1876] = {id = 1876, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201523, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701441, skipTime = 30}
, 
[1877] = {id = 1877, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201524, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701442, skipTime = 30}
, 
[1878] = {id = 1878, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201525, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070145, skipTime = 30}
, 
[1879] = {id = 1879, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201526, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070146, skipTime = 30}
, 
[1880] = {id = 1880, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201527, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070147, skipTime = 30}
, 
[1881] = {id = 1881, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201528, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070148, skipTime = 30}
, 
[1882] = {id = 1882, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201529, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070149, skipTime = 30}
, 
[1883] = {id = 1883, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1884] = {id = 1884, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201530, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701501, skipTime = 30}
, 
[1885] = {id = 1885, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201531, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701502, skipTime = 30}
, 
[1886] = {id = 1886, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201532, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701503, skipTime = 30}
, 
[1887] = {id = 1887, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201533, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070151, skipTime = 30}
, 
[1888] = {id = 1888, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202007}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1889] = {id = 1889, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201534, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070152, skipTime = 30}
, 
[1890] = {id = 1890, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201535, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701531, skipTime = 30}
, 
[1891] = {id = 1891, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201536, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701532, skipTime = 30}
, 
[1892] = {id = 1892, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201537, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070154, skipTime = 30}
, 
[1893] = {id = 1893, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201538, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070155, skipTime = 30}
, 
[1894] = {id = 1894, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201539, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070156, skipTime = 30}
, 
[1895] = {id = 1895, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201540, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1896] = {id = 1896, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201541, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1897] = {id = 1897, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201542, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070157, skipTime = 30}
, 
[1898] = {id = 1898, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201543, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070158, skipTime = 30}
, 
[1899] = {id = 1899, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201544, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070159, skipTime = 30}
, 
[1900] = {id = 1900, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201545, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070160, skipTime = 30}
, 
[1901] = {id = 1901, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201546, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701611, skipTime = 30}
, 
[1902] = {id = 1902, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201492, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701612, skipTime = 30}
, 
[1903] = {id = 1903, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201547, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070162, skipTime = 30}
, 
[1904] = {id = 1904, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 201548, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1905] = {id = 1905, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202008}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1906] = {id = 1906, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201549, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070163, skipTime = 30}
, 
[1907] = {id = 1907, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202009}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1908] = {id = 1908, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201550, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1909] = {id = 1909, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201551, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070164, skipTime = 30}
, 
[1910] = {id = 1910, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202010}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1911] = {id = 1911, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 200709, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1912] = {id = 1912, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202011}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1913] = {id = 1913, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201552, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070165, skipTime = 30}
, 
[1914] = {id = 1914, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202012}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1915] = {id = 1915, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201553, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070166, skipTime = 30}
, 
[1916] = {id = 1916, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201554, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1917] = {id = 1917, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 201161, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1918] = {id = 1918, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202013}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1919] = {id = 1919, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201555, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1920] = {id = 1920, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201556, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1921] = {id = 1921, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201557, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1922] = {id = 1922, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201558, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1923] = {id = 1923, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201559, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1924] = {id = 1924, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201560, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1925] = {id = 1925, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201561, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1926] = {id = 1926, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201562, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1927] = {id = 1927, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201563, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1928] = {id = 1928, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202014}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1929] = {id = 1929, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201564, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070167, skipTime = 30}
, 
[1930] = {id = 1930, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201565, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070168, skipTime = 30}
, 
[1931] = {id = 1931, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201566, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070169, skipTime = 30}
, 
[1932] = {id = 1932, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202015}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1933] = {id = 1933, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201567, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070170, skipTime = 30}
, 
[1934] = {id = 1934, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1935] = {id = 1935, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201568, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701711, skipTime = 30}
, 
[1936] = {id = 1936, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201569, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701712, skipTime = 30}
, 
[1937] = {id = 1937, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202016, 202051}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1938] = {id = 1938, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201564, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070167, skipTime = 30}
, 
[1939] = {id = 1939, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201570, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1940] = {id = 1940, chatType = 1, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201571, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1941] = {id = 1941, chatType = 1, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201572, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1942] = {id = 1942, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1036, 0}
, 
nameTextID = {200166, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201573, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200501, skipTime = 30}
, 
[1943] = {id = 1943, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1036, 0}
, 
nameTextID = {200166, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201574, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200502, skipTime = 30}
, 
[1944] = {id = 1944, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1036, 0}
, 
nameTextID = {200166, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201575, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200511, skipTime = 30}
, 
[1945] = {id = 1945, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1036, 0}
, 
nameTextID = {200166, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201576, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200512, skipTime = 30}
, 
[1946] = {id = 1946, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201577, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1947] = {id = 1947, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201578, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030039, skipTime = 30}
, 
[1948] = {id = 1948, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201579, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1949] = {id = 1949, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202017}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1950] = {id = 1950, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 201580, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1951] = {id = 1951, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202018}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1952] = {id = 1952, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 201581, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1953] = {id = 1953, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 201582, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1954] = {id = 1954, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 201583, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1955] = {id = 1955, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 0}
, contentTextID = 201584, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300871, skipTime = 30}
, 
[1956] = {id = 1956, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 0}
, contentTextID = 200436, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300872, skipTime = 30}
, 
[1957] = {id = 1957, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 0}
, contentTextID = 201585, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200300873, skipTime = 30}
, 
[1958] = {id = 1958, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202019, 202053}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1959] = {id = 1959, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201586, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1960] = {id = 1960, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1961] = {id = 1961, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201587, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1962] = {id = 1962, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1963] = {id = 1963, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201588, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1964] = {id = 1964, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201589, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1965] = {id = 1965, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200176}
, 
emotionId = {0, 0}
, contentTextID = 201590, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1966] = {id = 1966, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 200176}
, 
emotionId = {0, 0}
, contentTextID = 201591, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1967] = {id = 1967, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201592, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040001, skipTime = 30}
, 
[1968] = {id = 1968, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201887}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1969] = {id = 1969, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201593, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1970] = {id = 1970, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201594, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040002, skipTime = 30}
, 
[1971] = {id = 1971, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1010, 0}
, 
nameTextID = {200109, 202064}
, 
emotionId = {1, 0}
, contentTextID = 201595, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20040003, skipTime = 30}
, 
[1972] = {id = 1972, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1973] = {id = 1973, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201529, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1974] = {id = 1974, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201596, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701831, skipTime = 30}
, 
[1975] = {id = 1975, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201597, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701832, skipTime = 30}
, 
[1976] = {id = 1976, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201598, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701833, skipTime = 30}
, 
[1977] = {id = 1977, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201599, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701834, skipTime = 30}
, 
[1978] = {id = 1978, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10047}
, 
nameTextID = {202064, 200175}
, 
emotionId = {0, 0}
, contentTextID = 201600, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701835, skipTime = 30}
, 
[1979] = {id = 1979, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201601, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070184, skipTime = 30}
, 
[1980] = {id = 1980, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202020}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1981] = {id = 1981, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201602, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701851, skipTime = 30}
, 
[1982] = {id = 1982, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201603, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701852, skipTime = 30}
, 
[1983] = {id = 1983, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070186, skipTime = 30}
, 
[1984] = {id = 1984, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1985] = {id = 1985, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201605, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070187, skipTime = 30}
, 
[1986] = {id = 1986, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201606, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070188, skipTime = 30}
, 
[1987] = {id = 1987, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201607, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701891, skipTime = 30}
, 
[1988] = {id = 1988, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201608, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701892, skipTime = 30}
, 
[1989] = {id = 1989, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20061, 0}
, 
nameTextID = {200139, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201609, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070190, skipTime = 30}
, 
[1990] = {id = 1990, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202021}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1991] = {id = 1991, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201610, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701721, skipTime = 30}
, 
[1992] = {id = 1992, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201611, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701722, skipTime = 30}
, 
[1993] = {id = 1993, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201612, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070173, skipTime = 30}
, 
[1994] = {id = 1994, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202022}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[1995] = {id = 1995, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201613, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701741, skipTime = 30}
, 
[1996] = {id = 1996, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201614, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701742, skipTime = 30}
, 
[1997] = {id = 1997, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201615, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070175, skipTime = 30}
, 
[1998] = {id = 1998, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201616, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701761, skipTime = 30}
, 
[1999] = {id = 1999, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201617, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701762, skipTime = 30}
, 
[2000] = {id = 2000, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201618, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701763, skipTime = 30}
, 
[2001] = {id = 2001, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201654}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2002] = {id = 2002, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201619, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070177, skipTime = 30}
, 
[2003] = {id = 2003, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201620, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070178, skipTime = 30}
, 
[2004] = {id = 2004, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201564, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20070179, skipTime = 30}
, 
[2005] = {id = 2005, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201621, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701801, skipTime = 30}
, 
[2006] = {id = 2006, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201622, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701802, skipTime = 30}
, 
[2007] = {id = 2007, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201623, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701811, skipTime = 30}
, 
[2008] = {id = 2008, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1073, 0}
, 
nameTextID = {200165, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201624, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200701812, skipTime = 30}
, 
[2009] = {id = 2009, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201649}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2010] = {id = 2010, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201635}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2011] = {id = 2011, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201625, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010009, skipTime = 30}
, 
[2012] = {id = 2012, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {201636}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2013] = {id = 2013, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201626, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20010010, skipTime = 30}
, 
[2014] = {id = 2014, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202023}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2015] = {id = 2015, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201627, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100111, skipTime = 30}
, 
[2016] = {id = 2016, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 201628, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200100112, skipTime = 30}
, 
[2017] = {id = 2017, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202024}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2018] = {id = 2018, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 201629, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200200042, skipTime = 30}
, 
[2019] = {id = 2019, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202065, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2020] = {id = 2020, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202066, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500721, skipTime = 30}
, 
[2021] = {id = 2021, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200153, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202067, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200500722, skipTime = 30}
, 
[2022] = {id = 2022, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202068, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700661, skipTime = 30}
, 
[2023] = {id = 2023, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202069, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200700662, skipTime = 30}
, 
[2024] = {id = 2024, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 200106}
, 
emotionId = {0, 0}
, contentTextID = 202071, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060101, skipTime = 30}
, 
[2025] = {id = 2025, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20002}
, 
nameTextID = {202064, 200124}
, 
emotionId = {0, 0}
, contentTextID = 202073, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030081, skipTime = 30}
, 
[2026] = {id = 2026, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200130, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202074, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2027] = {id = 2027, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202082, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2028] = {id = 2028, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202083, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2029] = {id = 2029, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202084, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2030] = {id = 2030, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202085, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030073, skipTime = 30}
, 
[2031] = {id = 2031, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202088}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2032] = {id = 2032, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202089}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2033] = {id = 2033, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202090, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 2}
, 
[2034] = {id = 2034, chatType = 0, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202091, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 2}
, 
[2035] = {id = 2035, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202092, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2036] = {id = 2036, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202093, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2037] = {id = 2037, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202094}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2038] = {id = 2038, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202145, speed = "", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2051] = {id = 2051, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 202107, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2052] = {id = 2052, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202108}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2053] = {id = 2053, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 202109, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2054] = {id = 2054, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202110}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2055] = {id = 2055, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 200164}
, 
emotionId = {0, 0}
, contentTextID = 202111, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2056] = {id = 2056, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202112, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2057] = {id = 2057, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202113, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2058] = {id = 2058, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202114, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2059] = {id = 2059, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202115}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2060] = {id = 2060, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202116, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2061] = {id = 2061, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202117, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2062] = {id = 2062, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202118}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2063] = {id = 2063, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202119, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2064] = {id = 2064, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202120, 202121}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2065] = {id = 2065, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202122, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2066] = {id = 2066, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202123, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2067] = {id = 2067, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202124, 202125}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2068] = {id = 2068, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202126, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2069] = {id = 2069, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202127, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2070] = {id = 2070, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202128, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2071] = {id = 2071, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202129, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2072] = {id = 2072, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202130}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2073] = {id = 2073, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202131, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2074] = {id = 2074, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1038}
, 
nameTextID = {202064, 202150}
, 
emotionId = {0, 0}
, contentTextID = 202132, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2075] = {id = 2075, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202133}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2076] = {id = 2076, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202134, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2077] = {id = 2077, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202135, 202136}
, 
chooseValue = {1244, 1243}
, voiceId = 0, skipTime = 30}
, 
[2078] = {id = 2078, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202137, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2079] = {id = 2079, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202138, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2080] = {id = 2080, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202139}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2081] = {id = 2081, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {200164, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202140, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2082] = {id = 2082, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202141, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2083] = {id = 2083, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202142, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2084] = {id = 2084, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202143, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2085] = {id = 2085, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202144, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2086] = {id = 2086, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202145, 202146}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2087] = {id = 2087, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202147, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2088] = {id = 2088, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1004, 0}
, 
nameTextID = {202151, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202148, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2089] = {id = 2089, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202149}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2090] = {id = 2090, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200107}
, 
emotionId = {0, 0}
, contentTextID = 202153, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2091] = {id = 2091, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 202154, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2092] = {id = 2092, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202155, 202156}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2093] = {id = 2093, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 202157, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800011, skipTime = 30}
, 
[2094] = {id = 2094, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 202158, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800012, skipTime = 30}
, 
[2095] = {id = 2095, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202159, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080002, skipTime = 30}
, 
[2096] = {id = 2096, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202160, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800031, skipTime = 30}
, 
[2097] = {id = 2097, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202161, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800032, skipTime = 30}
, 
[2098] = {id = 2098, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202162}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2099] = {id = 2099, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202163, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800041, skipTime = 30}
, 
[2100] = {id = 2100, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202164, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800042, skipTime = 30}
, 
[2101] = {id = 2101, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202165, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080005, skipTime = 30}
, 
[2102] = {id = 2102, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202166}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2103] = {id = 2103, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202167, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800061, skipTime = 30}
, 
[2104] = {id = 2104, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202168, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800062, skipTime = 30}
, 
[2105] = {id = 2105, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202169, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800063, skipTime = 30}
, 
[2106] = {id = 2106, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202170, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080007, skipTime = 30}
, 
[2107] = {id = 2107, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202171, 202172}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2108] = {id = 2108, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202173, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080008, skipTime = 30}
, 
[2109] = {id = 2109, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202174, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080009, skipTime = 30}
, 
[2110] = {id = 2110, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202175, 202176}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2111] = {id = 2111, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202177, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080010, skipTime = 30}
, 
[2112] = {id = 2112, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202178, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080011, skipTime = 30}
, 
[2113] = {id = 2113, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202179, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080012, skipTime = 30}
, 
[2114] = {id = 2114, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202180, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080013, skipTime = 30}
, 
[2115] = {id = 2115, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202181, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080014, skipTime = 30}
, 
[2116] = {id = 2116, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202182, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800151, skipTime = 30}
, 
[2117] = {id = 2117, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202183, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800152, skipTime = 30}
, 
[2118] = {id = 2118, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202184, 202185}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2119] = {id = 2119, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202186, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080016, skipTime = 30}
, 
[2120] = {id = 2120, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202187}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2121] = {id = 2121, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202188, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800171, skipTime = 30}
, 
[2122] = {id = 2122, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202189, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800172, skipTime = 30}
, 
[2123] = {id = 2123, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202190}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2124] = {id = 2124, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202191, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080018, skipTime = 30}
, 
[2125] = {id = 2125, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202192}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2126] = {id = 2126, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202193, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800191, skipTime = 30}
, 
[2127] = {id = 2127, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202194, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800192, skipTime = 30}
, 
[2128] = {id = 2128, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202195, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800201, skipTime = 30}
, 
[2129] = {id = 2129, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202196, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800202, skipTime = 30}
, 
[2130] = {id = 2130, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202197, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080021, skipTime = 30}
, 
[2131] = {id = 2131, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202198, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080022, skipTime = 30}
, 
[2132] = {id = 2132, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202199, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080023, skipTime = 30}
, 
[2133] = {id = 2133, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202200, 202201}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2134] = {id = 2134, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202202, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080024, skipTime = 30}
, 
[2135] = {id = 2135, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202203}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2136] = {id = 2136, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202204, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080025, skipTime = 30}
, 
[2137] = {id = 2137, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202205, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080026, skipTime = 30}
, 
[2138] = {id = 2138, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202206, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080027, skipTime = 30}
, 
[2139] = {id = 2139, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202207, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080028, skipTime = 30}
, 
[2140] = {id = 2140, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202208}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2141] = {id = 2141, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202209, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080029, skipTime = 30}
, 
[2142] = {id = 2142, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202210, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080030, skipTime = 30}
, 
[2143] = {id = 2143, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202211, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080031, skipTime = 30}
, 
[2144] = {id = 2144, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202212, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080032, skipTime = 30}
, 
[2145] = {id = 2145, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202213, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080033, skipTime = 30}
, 
[2146] = {id = 2146, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202214, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080034, skipTime = 30}
, 
[2147] = {id = 2147, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202215, 202216}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2148] = {id = 2148, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202217, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080035, skipTime = 30}
, 
[2149] = {id = 2149, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202218, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080036, skipTime = 30}
, 
[2150] = {id = 2150, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202219, 202220}
, 
chooseValue = {1253, 1254}
, voiceId = 0, skipTime = 30}
, 
[2151] = {id = 2151, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202221, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800371, skipTime = 30}
, 
[2152] = {id = 2152, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202220}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2153] = {id = 2153, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202222, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800372, skipTime = 30}
, 
[2154] = {id = 2154, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1013}
, 
nameTextID = {202064, 200113}
, 
emotionId = {0, 1}
, contentTextID = 202223, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080038, skipTime = 30}
, 
[2155] = {id = 2155, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202224, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080039, skipTime = 30}
, 
[2156] = {id = 2156, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202225}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2157] = {id = 2157, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202226, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080040, skipTime = 30}
, 
[2158] = {id = 2158, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202227, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080041, skipTime = 30}
, 
[2159] = {id = 2159, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202228, 202229}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2160] = {id = 2160, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202230, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080042, skipTime = 30}
, 
[2161] = {id = 2161, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202231, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080043, skipTime = 30}
, 
[2162] = {id = 2162, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202232, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080044, skipTime = 30}
, 
[2163] = {id = 2163, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202233, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080045, skipTime = 30}
, 
[2164] = {id = 2164, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202234, 202235}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2165] = {id = 2165, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202236, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080046, skipTime = 30}
, 
[2166] = {id = 2166, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202237, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080047, skipTime = 30}
, 
[2167] = {id = 2167, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 203255}
, 
emotionId = {0, 1}
, contentTextID = 202238, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080048, skipTime = 30}
, 
[2168] = {id = 2168, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202239, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080049, skipTime = 30}
, 
[2169] = {id = 2169, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202240, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080050, skipTime = 30}
, 
[2170] = {id = 2170, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080051, skipTime = 30}
, 
[2171] = {id = 2171, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202242, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080065, skipTime = 30}
, 
[2172] = {id = 2172, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202243, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080066, skipTime = 30}
, 
[2173] = {id = 2173, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202244, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080067, skipTime = 30}
, 
[2174] = {id = 2174, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202245, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080068, skipTime = 30}
, 
[2175] = {id = 2175, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202246, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080069, skipTime = 30}
, 
[2176] = {id = 2176, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202247, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080070, skipTime = 30}
, 
[2177] = {id = 2177, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202248, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080071, skipTime = 30}
, 
[2178] = {id = 2178, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202249, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080072, skipTime = 30}
, 
[2179] = {id = 2179, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202250, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080073, skipTime = 30}
, 
[2180] = {id = 2180, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202251, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080074, skipTime = 30}
, 
[2181] = {id = 2181, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202252, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080075, skipTime = 30}
, 
[2182] = {id = 2182, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202253, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080076, skipTime = 30}
, 
[2183] = {id = 2183, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202254, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080077, skipTime = 30}
, 
[2184] = {id = 2184, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202255, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080078, skipTime = 30}
, 
[2185] = {id = 2185, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202256, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080079, skipTime = 30}
, 
[2186] = {id = 2186, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202257, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080080, skipTime = 30}
, 
[2187] = {id = 2187, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202258, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080081, skipTime = 30}
, 
[2188] = {id = 2188, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202259, 202260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2189] = {id = 2189, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202261, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080083, skipTime = 30}
, 
[2190] = {id = 2190, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202262, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080084, skipTime = 30}
, 
[2191] = {id = 2191, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202263, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080085, skipTime = 30}
, 
[2192] = {id = 2192, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202264, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080086, skipTime = 30}
, 
[2193] = {id = 2193, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202265, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080087, skipTime = 30}
, 
[2194] = {id = 2194, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202266, 202267}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2195] = {id = 2195, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202268, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080088, skipTime = 30}
, 
[2196] = {id = 2196, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202269, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080089, skipTime = 30}
, 
[2197] = {id = 2197, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202270, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080090, skipTime = 30}
, 
[2198] = {id = 2198, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202271, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080102, skipTime = 30}
, 
[2199] = {id = 2199, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202272, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080103, skipTime = 30}
, 
[2200] = {id = 2200, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202273, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080104, skipTime = 30}
, 
[2201] = {id = 2201, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202274, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080105, skipTime = 30}
, 
[2202] = {id = 2202, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202275, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080106, skipTime = 30}
, 
[2203] = {id = 2203, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202276, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080107, skipTime = 30}
, 
[2204] = {id = 2204, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202277, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080108, skipTime = 30}
, 
[2205] = {id = 2205, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202278, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080109, skipTime = 30}
, 
[2206] = {id = 2206, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202279, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080110, skipTime = 30}
, 
[2207] = {id = 2207, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202280, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2208] = {id = 2208, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202281, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080111, skipTime = 30}
, 
[2209] = {id = 2209, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202282, 202283}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2210] = {id = 2210, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202284, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080112, skipTime = 30}
, 
[2211] = {id = 2211, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202285, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080113, skipTime = 30}
, 
[2212] = {id = 2212, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202286, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080118, skipTime = 30}
, 
[2213] = {id = 2213, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202287, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080119, skipTime = 30}
, 
[2214] = {id = 2214, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202288, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080120, skipTime = 30}
, 
[2215] = {id = 2215, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202289, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080121, skipTime = 30}
, 
[2216] = {id = 2216, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202290, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080122, skipTime = 30}
, 
[2217] = {id = 2217, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202291, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080123, skipTime = 30}
, 
[2218] = {id = 2218, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202292, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080124, skipTime = 30}
, 
[2219] = {id = 2219, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202293, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080125, skipTime = 30}
, 
[2220] = {id = 2220, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202294, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080126, skipTime = 30}
, 
[2221] = {id = 2221, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202295, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080127, skipTime = 30}
, 
[2222] = {id = 2222, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202296, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080129, skipTime = 30}
, 
[2223] = {id = 2223, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202297, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080130, skipTime = 30}
, 
[2224] = {id = 2224, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202298, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080131, skipTime = 30}
, 
[2225] = {id = 2225, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202299, 202300}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2226] = {id = 2226, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202301, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080132, skipTime = 30}
, 
[2227] = {id = 2227, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202302, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080133, skipTime = 30}
, 
[2228] = {id = 2228, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202303, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080134, skipTime = 30}
, 
[2229] = {id = 2229, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202304, 202305}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2230] = {id = 2230, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202306, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080135, skipTime = 30}
, 
[2231] = {id = 2231, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202307, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080136, skipTime = 30}
, 
[2232] = {id = 2232, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202308, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080137, skipTime = 30}
, 
[2233] = {id = 2233, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202309, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080138, skipTime = 30}
, 
[2234] = {id = 2234, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202310, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080139, skipTime = 30}
, 
[2235] = {id = 2235, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202311, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080140, skipTime = 30}
, 
[2236] = {id = 2236, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202312, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080141, skipTime = 30}
, 
[2237] = {id = 2237, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202313, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080142, skipTime = 30}
, 
[2238] = {id = 2238, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202314, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080143, skipTime = 30}
, 
[2239] = {id = 2239, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202315, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080144, skipTime = 30}
, 
[2240] = {id = 2240, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202316, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080145, skipTime = 30}
, 
[2241] = {id = 2241, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202317, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080147, skipTime = 30}
, 
[2242] = {id = 2242, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202318, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2243] = {id = 2243, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202319, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080146, skipTime = 30}
, 
[2244] = {id = 2244, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202320, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080148, skipTime = 30}
, 
[2245] = {id = 2245, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202321}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2246] = {id = 2246, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202322, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080149, skipTime = 30}
, 
[2247] = {id = 2247, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202323, 202324}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2248] = {id = 2248, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202325, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080150, skipTime = 30}
, 
[2249] = {id = 2249, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202326, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080151, skipTime = 30}
, 
[2250] = {id = 2250, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202327, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080152, skipTime = 30}
, 
[2251] = {id = 2251, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202328, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080153, skipTime = 30}
, 
[2252] = {id = 2252, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202329, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080154, skipTime = 30}
, 
[2253] = {id = 2253, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202330, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080155, skipTime = 30}
, 
[2254] = {id = 2254, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1017}
, 
nameTextID = {202064, 200154}
, 
emotionId = {0, 1}
, contentTextID = 202331, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080156, skipTime = 30}
, 
[2255] = {id = 2255, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202332, 202333}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2256] = {id = 2256, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202334, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080157, skipTime = 30}
, 
[2257] = {id = 2257, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202336}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2258] = {id = 2258, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202338, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2259] = {id = 2259, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202339, 202340}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2260] = {id = 2260, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202341, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2261] = {id = 2261, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202342, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2262] = {id = 2262, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202343}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2263] = {id = 2263, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202345, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2264] = {id = 2264, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202346, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2265] = {id = 2265, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202347, 202348}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2266] = {id = 2266, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202337, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202349, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2267] = {id = 2267, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202350}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2268] = {id = 2268, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202352, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2269] = {id = 2269, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202353}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2270] = {id = 2270, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202354, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2271] = {id = 2271, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202355, 202356}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2272] = {id = 2272, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202357, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2273] = {id = 2273, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202358, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2274] = {id = 2274, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202360, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2275] = {id = 2275, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202361, 202362}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2276] = {id = 2276, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202363, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2277] = {id = 2277, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202364}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2278] = {id = 2278, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202365, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2279] = {id = 2279, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202366}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2280] = {id = 2280, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202367, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2281] = {id = 2281, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202369, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2282] = {id = 2282, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202370, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2283] = {id = 2283, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202371, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2284] = {id = 2284, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202372, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2285] = {id = 2285, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202373, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2286] = {id = 2286, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202374, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2287] = {id = 2287, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202375, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2288] = {id = 2288, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202376, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2289] = {id = 2289, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202377, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2290] = {id = 2290, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202378, 202379}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2291] = {id = 2291, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202380, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2292] = {id = 2292, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202381, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2293] = {id = 2293, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202351, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202382, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2294] = {id = 2294, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202384, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2295] = {id = 2295, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202385, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2296] = {id = 2296, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202386, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2297] = {id = 2297, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202387, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2298] = {id = 2298, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202389, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2299] = {id = 2299, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202390, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2300] = {id = 2300, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202391, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2301] = {id = 2301, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202392, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2302] = {id = 2302, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202393, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2303] = {id = 2303, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202394}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2304] = {id = 2304, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202395, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2305] = {id = 2305, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202396, 202397}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2306] = {id = 2306, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202398, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2307] = {id = 2307, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202399, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2308] = {id = 2308, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202400, 202401}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2309] = {id = 2309, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202402, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2310] = {id = 2310, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202403, 202404}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2311] = {id = 2311, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202405, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2312] = {id = 2312, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202406, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2313] = {id = 2313, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202408, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2314] = {id = 2314, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202409, 202410}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2315] = {id = 2315, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202411, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2316] = {id = 2316, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202412, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2317] = {id = 2317, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202413, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2318] = {id = 2318, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202414, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2319] = {id = 2319, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202415, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2320] = {id = 2320, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202416}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2321] = {id = 2321, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202417}
, 
emotionId = {0, 0}
, contentTextID = 202419, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2322] = {id = 2322, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202417}
, 
emotionId = {0, 0}
, contentTextID = 202420, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2323] = {id = 2323, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202421, 202422}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2324] = {id = 2324, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202417}
, 
emotionId = {0, 0}
, contentTextID = 202423, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2325] = {id = 2325, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202424, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2326] = {id = 2326, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202425, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2327] = {id = 2327, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202426, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2328] = {id = 2328, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202427, 202428}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2329] = {id = 2329, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202429, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2330] = {id = 2330, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202430, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2331] = {id = 2331, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202432, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2332] = {id = 2332, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202433}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2333] = {id = 2333, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202434, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2334] = {id = 2334, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202435, 202436}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2335] = {id = 2335, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202437, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2336] = {id = 2336, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202438, 202439}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2337] = {id = 2337, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202440, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2338] = {id = 2338, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202441, 202442}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2339] = {id = 2339, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202443, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2340] = {id = 2340, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202444, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2341] = {id = 2341, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202445, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2342] = {id = 2342, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202446, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2343] = {id = 2343, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202447, 202448}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2344] = {id = 2344, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202449, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2345] = {id = 2345, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202450, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2346] = {id = 2346, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202431, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202451, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2347] = {id = 2347, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202452}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2348] = {id = 2348, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202453, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2349] = {id = 2349, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202454, 202455}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2350] = {id = 2350, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202456, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2351] = {id = 2351, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202457}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2352] = {id = 2352, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2353] = {id = 2353, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202459, 202460}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2354] = {id = 2354, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202461, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2355] = {id = 2355, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2356] = {id = 2356, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2357] = {id = 2357, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202464, 202465}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2358] = {id = 2358, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202466, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2359] = {id = 2359, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202467, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2360] = {id = 2360, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202468, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2361] = {id = 2361, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202469, 202470}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2362] = {id = 2362, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202471, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2363] = {id = 2363, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202473, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2364] = {id = 2364, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202474, 202475}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2365] = {id = 2365, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202476, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2366] = {id = 2366, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2367] = {id = 2367, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202478, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2368] = {id = 2368, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202479, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2369] = {id = 2369, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202480, 202481}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2370] = {id = 2370, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202482, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2371] = {id = 2371, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202484, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2372] = {id = 2372, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202485}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2373] = {id = 2373, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202486, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2374] = {id = 2374, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202487, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2375] = {id = 2375, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202383, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202488, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2376] = {id = 2376, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202489, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2377] = {id = 2377, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202490, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2378] = {id = 2378, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202491, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2379] = {id = 2379, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202492, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2380] = {id = 2380, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202493, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2381] = {id = 2381, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202494, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2382] = {id = 2382, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202495, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2383] = {id = 2383, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202496, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2384] = {id = 2384, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202497, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2385] = {id = 2385, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202498, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2386] = {id = 2386, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202499, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2387] = {id = 2387, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202500, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2388] = {id = 2388, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202502, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2389] = {id = 2389, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202503, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2390] = {id = 2390, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202504, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2391] = {id = 2391, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202505, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2392] = {id = 2392, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202506, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2393] = {id = 2393, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202507, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2394] = {id = 2394, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202508, 202509}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2395] = {id = 2395, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202510, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2396] = {id = 2396, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202511}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2397] = {id = 2397, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202512, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2398] = {id = 2398, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202513, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2399] = {id = 2399, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202514, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2400] = {id = 2400, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202515, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2401] = {id = 2401, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202516, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2402] = {id = 2402, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202472}
, 
emotionId = {0, 0}
, contentTextID = 202517, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2403] = {id = 2403, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202483}
, 
emotionId = {0, 0}
, contentTextID = 202518, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2404] = {id = 2404, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202519, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2405] = {id = 2405, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202520, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2406] = {id = 2406, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202521, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2407] = {id = 2407, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202522, 202523}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2408] = {id = 2408, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202524, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2409] = {id = 2409, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202525, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2410] = {id = 2410, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202526, 202527}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2411] = {id = 2411, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202528, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2412] = {id = 2412, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202529, 202530}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2413] = {id = 2413, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202532, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2414] = {id = 2414, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202533, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2415] = {id = 2415, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202533, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2416] = {id = 2416, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202534, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2417] = {id = 2417, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202535, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2418] = {id = 2418, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202536, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2419] = {id = 2419, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202537, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2420] = {id = 2420, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202538, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2421] = {id = 2421, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202539, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2422] = {id = 2422, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202540}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2423] = {id = 2423, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202541, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2424] = {id = 2424, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202542, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2425] = {id = 2425, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202543}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2426] = {id = 2426, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202544, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2427] = {id = 2427, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202545, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2428] = {id = 2428, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202546, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2429] = {id = 2429, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202547}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2430] = {id = 2430, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202548, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2431] = {id = 2431, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202549, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2432] = {id = 2432, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202550, 202551}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2433] = {id = 2433, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202552, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2434] = {id = 2434, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202553, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2435] = {id = 2435, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202554, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2436] = {id = 2436, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202483, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202555, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2437] = {id = 2437, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202557, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2438] = {id = 2438, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202558}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2439] = {id = 2439, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202559, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2440] = {id = 2440, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202560}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2441] = {id = 2441, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202561, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2442] = {id = 2442, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202562}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2443] = {id = 2443, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202563, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2444] = {id = 2444, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202564}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2445] = {id = 2445, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202407, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202565, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2446] = {id = 2446, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202566, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2447] = {id = 2447, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202567, 202568}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2448] = {id = 2448, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202569, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2449] = {id = 2449, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202570}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2450] = {id = 2450, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202571, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2451] = {id = 2451, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202572}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2452] = {id = 2452, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202573, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2453] = {id = 2453, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202573, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2454] = {id = 2454, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202575, 202576}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2455] = {id = 2455, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {202359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202577, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2456] = {id = 2456, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202578, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2457] = {id = 2457, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202579}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2458] = {id = 2458, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202580, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2459] = {id = 2459, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202581, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2460] = {id = 2460, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202582}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2461] = {id = 2461, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202583, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2462] = {id = 2462, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202584}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2463] = {id = 2463, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202585, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2464] = {id = 2464, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200127, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202586, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2465] = {id = 2465, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202587, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2466] = {id = 2466, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202588, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2467] = {id = 2467, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202589, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2468] = {id = 2468, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202590, 202591}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2469] = {id = 2469, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202592, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2470] = {id = 2470, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202593, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2471] = {id = 2471, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202594, 202595}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2472] = {id = 2472, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202596, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2473] = {id = 2473, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202597, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2474] = {id = 2474, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202598}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2475] = {id = 2475, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202599, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2476] = {id = 2476, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202600, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2477] = {id = 2477, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202602, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2478] = {id = 2478, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202603, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2479] = {id = 2479, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2480] = {id = 2480, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202605, 202606}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2481] = {id = 2481, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202607, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2482] = {id = 2482, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202608, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2483] = {id = 2483, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202609, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2484] = {id = 2484, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202610, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2485] = {id = 2485, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202611, 202612}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2486] = {id = 2486, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202613, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2487] = {id = 2487, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202614, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2488] = {id = 2488, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202615}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2489] = {id = 2489, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202616, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2490] = {id = 2490, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202617, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2491] = {id = 2491, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202618, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2492] = {id = 2492, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202619, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2493] = {id = 2493, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202620, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2494] = {id = 2494, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202621, 202622}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2495] = {id = 2495, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202623, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2496] = {id = 2496, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202624, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2497] = {id = 2497, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202625, 202626}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2498] = {id = 2498, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202627, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2499] = {id = 2499, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202628, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2500] = {id = 2500, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202629, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2501] = {id = 2501, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202630, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2502] = {id = 2502, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202631, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2503] = {id = 2503, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202632, 202633}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2504] = {id = 2504, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202634, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2505] = {id = 2505, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202635, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2506] = {id = 2506, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202636, 202637}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2507] = {id = 2507, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202638, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2508] = {id = 2508, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202639}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2509] = {id = 2509, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202640, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2510] = {id = 2510, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202641, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2511] = {id = 2511, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202642, 202643}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2512] = {id = 2512, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202644, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2513] = {id = 2513, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202645, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2514] = {id = 2514, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202646, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2515] = {id = 2515, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202647, 202648}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2516] = {id = 2516, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202649, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2517] = {id = 2517, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202650, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2518] = {id = 2518, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202651, 202652}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2519] = {id = 2519, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202653, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2520] = {id = 2520, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202501}
, 
emotionId = {0, 0}
, contentTextID = 202654, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2521] = {id = 2521, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202655, 202656}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2522] = {id = 2522, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202657, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2523] = {id = 2523, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202658, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2524] = {id = 2524, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202659, 202660}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2525] = {id = 2525, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202661, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2526] = {id = 2526, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202662}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2527] = {id = 2527, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202663, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2528] = {id = 2528, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202664, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2529] = {id = 2529, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202665, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2530] = {id = 2530, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202666, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2531] = {id = 2531, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202667, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2532] = {id = 2532, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202668, 202669}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2533] = {id = 2533, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 202670, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2534] = {id = 2534, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202671}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2535] = {id = 2535, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202672, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2536] = {id = 2536, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202673, 202674}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2537] = {id = 2537, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202675, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2538] = {id = 2538, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 0}
, contentTextID = 202676, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2539] = {id = 2539, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202677}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2540] = {id = 2540, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202678, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2541] = {id = 2541, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202679, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2542] = {id = 2542, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202680, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2543] = {id = 2543, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 200115}
, 
emotionId = {0, 0}
, contentTextID = 202681, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2544] = {id = 2544, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202682, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2545] = {id = 2545, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202683, 202684}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2546] = {id = 2546, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202685, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2547] = {id = 2547, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202686}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2548] = {id = 2548, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202687, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2549] = {id = 2549, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202688, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2550] = {id = 2550, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202689, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2551] = {id = 2551, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202690}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2552] = {id = 2552, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202691, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2553] = {id = 2553, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202692}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2554] = {id = 2554, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202693, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2555] = {id = 2555, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202694}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2556] = {id = 2556, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202695, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2557] = {id = 2557, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202697}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2558] = {id = 2558, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202696, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202698, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2559] = {id = 2559, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202699, 202700}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2560] = {id = 2560, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202696, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202701, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2561] = {id = 2561, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202698}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2562] = {id = 2562, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202696, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202703, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2563] = {id = 2563, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202696, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202704, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2564] = {id = 2564, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202705, 202706}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2565] = {id = 2565, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202696, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202707, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2566] = {id = 2566, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202708}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2567] = {id = 2567, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202709, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2568] = {id = 2568, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202711, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2569] = {id = 2569, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202712, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2570] = {id = 2570, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202713, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2571] = {id = 2571, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202714, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2572] = {id = 2572, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202715, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2573] = {id = 2573, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202716, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2574] = {id = 2574, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202717, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2575] = {id = 2575, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202718, 202719}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2576] = {id = 2576, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202720, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2577] = {id = 2577, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202721, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2578] = {id = 2578, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202722}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2579] = {id = 2579, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202723, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2580] = {id = 2580, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202724, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2581] = {id = 2581, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202725}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2582] = {id = 2582, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202726, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2583] = {id = 2583, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {202710, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202727, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2584] = {id = 2584, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202728, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2585] = {id = 2585, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202729, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2586] = {id = 2586, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202730, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2587] = {id = 2587, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202731, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2588] = {id = 2588, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202718, 202719}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2589] = {id = 2589, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202734, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2590] = {id = 2590, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202735, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2591] = {id = 2591, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 202418}
, 
emotionId = {0, 0}
, contentTextID = 202736, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2592] = {id = 2592, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202737, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2593] = {id = 2593, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 202738}
, 
emotionId = {0, 0}
, contentTextID = 202739, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2594] = {id = 2594, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202740, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2595] = {id = 2595, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202741}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2596] = {id = 2596, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202742, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2597] = {id = 2597, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 202738}
, 
emotionId = {0, 0}
, contentTextID = 202743, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2598] = {id = 2598, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 202738}
, 
emotionId = {0, 0}
, contentTextID = 202744, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2599] = {id = 2599, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202745, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2600] = {id = 2600, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202746, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2601] = {id = 2601, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202747}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2602] = {id = 2602, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202748, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2603] = {id = 2603, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202749, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2604] = {id = 2604, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202750, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2605] = {id = 2605, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202751, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2606] = {id = 2606, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202752, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2607] = {id = 2607, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202753, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2608] = {id = 2608, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202754, 202755}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2609] = {id = 2609, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {202556, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202756, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2610] = {id = 2610, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202757, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2611] = {id = 2611, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202758, 202759}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2612] = {id = 2612, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202760, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2613] = {id = 2613, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202761, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2614] = {id = 2614, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202762}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2615] = {id = 2615, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202763, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2616] = {id = 2616, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 202388}
, 
emotionId = {0, 0}
, contentTextID = 202764, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2617] = {id = 2617, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 202789}
, 
emotionId = {0, 0}
, contentTextID = 202765, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2618] = {id = 2618, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 202789}
, 
emotionId = {0, 0}
, contentTextID = 202766, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2619] = {id = 2619, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202767}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2620] = {id = 2620, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 202789}
, 
emotionId = {0, 0}
, contentTextID = 202768, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2621] = {id = 2621, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202769, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2622] = {id = 2622, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202770}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2623] = {id = 2623, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202771, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2624] = {id = 2624, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202772, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2625] = {id = 2625, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202773, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2626] = {id = 2626, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202774}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2627] = {id = 2627, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202775, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2628] = {id = 2628, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202776, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2629] = {id = 2629, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202777, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2630] = {id = 2630, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202778, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2631] = {id = 2631, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202779, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2632] = {id = 2632, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202780, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2633] = {id = 2633, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202781, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2634] = {id = 2634, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202782, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2635] = {id = 2635, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202783, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2636] = {id = 2636, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202784, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2637] = {id = 2637, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202472, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202785, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2638] = {id = 2638, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202786, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2639] = {id = 2639, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {202789, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202787, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2640] = {id = 2640, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 202556}
, 
emotionId = {0, 0}
, contentTextID = 202788, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2641] = {id = 2641, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202806, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030089, skipTime = 30}
, 
[2642] = {id = 2642, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202807, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030090, skipTime = 30}
, 
[2643] = {id = 2643, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202808, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050086, skipTime = 30}
, 
[2644] = {id = 2644, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202809, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050087, skipTime = 30}
, 
[2645] = {id = 2645, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202810, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050088, skipTime = 30}
, 
[2646] = {id = 2646, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202811, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050089, skipTime = 30}
, 
[2647] = {id = 2647, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202812, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050090, skipTime = 30}
, 
[2648] = {id = 2648, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {200106, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202813, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2649] = {id = 2649, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202814, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050091, skipTime = 30}
, 
[2650] = {id = 2650, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202830, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600593, skipTime = 30}
, 
[2651] = {id = 2651, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202831, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200600594, skipTime = 30}
, 
[2652] = {id = 2652, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200132, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202815, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2653] = {id = 2653, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202818, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050079, skipTime = 30}
, 
[2654] = {id = 2654, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202819, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2655] = {id = 2655, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202820, 202821}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2656] = {id = 2656, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202822, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050080, skipTime = 30}
, 
[2657] = {id = 2657, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202823, 202824}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2658] = {id = 2658, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202825, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050081, skipTime = 30}
, 
[2659] = {id = 2659, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202826, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050084, skipTime = 30}
, 
[2660] = {id = 2660, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202827, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20050085, skipTime = 30}
, 
[2661] = {id = 2661, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "", 
chooseTextID = {202828}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2662] = {id = 2662, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200126, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202829, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2663] = {id = 2663, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202832, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2664] = {id = 2664, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202833, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2665] = {id = 2665, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202834, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2666] = {id = 2666, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202835, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2667] = {id = 2667, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202837, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2668] = {id = 2668, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202838, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2669] = {id = 2669, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {0, 1}
, contentTextID = 202839, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2670] = {id = 2670, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202840, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2671] = {id = 2671, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202841, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2672] = {id = 2672, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202843, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2673] = {id = 2673, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202844, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2674] = {id = 2674, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202845, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2675] = {id = 2675, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202846, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2676] = {id = 2676, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202847, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2677] = {id = 2677, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202848, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2678] = {id = 2678, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202849, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2679] = {id = 2679, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202850, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2680] = {id = 2680, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202851, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2681] = {id = 2681, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202852, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2682] = {id = 2682, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202853, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2683] = {id = 2683, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202854, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2684] = {id = 2684, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202842}
, 
emotionId = {0, 1}
, contentTextID = 202855, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2685] = {id = 2685, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202856, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2686] = {id = 2686, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202858, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2687] = {id = 2687, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202859, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2688] = {id = 2688, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202860, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2689] = {id = 2689, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202861, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2690] = {id = 2690, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202862, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2691] = {id = 2691, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202863, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2692] = {id = 2692, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202864, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2693] = {id = 2693, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202865, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2694] = {id = 2694, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202866, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2695] = {id = 2695, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202867, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2696] = {id = 2696, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202868, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2697] = {id = 2697, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202869, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2698] = {id = 2698, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1086, 0}
, 
nameTextID = {202836, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202870, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2699] = {id = 2699, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1053}
, 
nameTextID = {202064, 202857}
, 
emotionId = {0, 1}
, contentTextID = 202871, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2700] = {id = 2700, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202873, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2701] = {id = 2701, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202874, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2702] = {id = 2702, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202875, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2703] = {id = 2703, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202926, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2704] = {id = 2704, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202876, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2705] = {id = 2705, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202877, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2706] = {id = 2706, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202878, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2707] = {id = 2707, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202879, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2708] = {id = 2708, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202880, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2709] = {id = 2709, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202881, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2710] = {id = 2710, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202882, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2711] = {id = 2711, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202883, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2712] = {id = 2712, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202884, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2713] = {id = 2713, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202885}
, 
emotionId = {1, 0}
, contentTextID = 202886, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2714] = {id = 2714, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202887, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2715] = {id = 2715, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202885}
, 
emotionId = {1, 0}
, contentTextID = 202888, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2716] = {id = 2716, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202889, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2717] = {id = 2717, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202885}
, 
emotionId = {1, 0}
, contentTextID = 202890, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2718] = {id = 2718, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202891, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2719] = {id = 2719, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202892, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2720] = {id = 2720, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202893, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2721] = {id = 2721, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202894, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2722] = {id = 2722, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202895, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2723] = {id = 2723, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202896, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2724] = {id = 2724, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202897, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2725] = {id = 2725, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202898, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2726] = {id = 2726, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202899, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2727] = {id = 2727, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 206334, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2728] = {id = 2728, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202900, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202901, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2729] = {id = 2729, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202902, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2730] = {id = 2730, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202904, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2731] = {id = 2731, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1006}
, 
nameTextID = {202064, 202872}
, 
emotionId = {0, 1}
, contentTextID = 202905, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2732] = {id = 2732, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202906, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2733] = {id = 2733, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202907, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2734] = {id = 2734, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202908, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2735] = {id = 2735, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1006}
, 
nameTextID = {202064, 202872}
, 
emotionId = {0, 1}
, contentTextID = 202909, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2736] = {id = 2736, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202910, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2737] = {id = 2737, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202911, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2738] = {id = 2738, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202912, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2739] = {id = 2739, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202913, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2740] = {id = 2740, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202914, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2741] = {id = 2741, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202915, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2742] = {id = 2742, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202916, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2743] = {id = 2743, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202917, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2744] = {id = 2744, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202918, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2745] = {id = 2745, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202919, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2746] = {id = 2746, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202920, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2747] = {id = 2747, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202921, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2748] = {id = 2748, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202922, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2749] = {id = 2749, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1053, 0}
, 
nameTextID = {202857, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202923, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2750] = {id = 2750, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1006, 0}
, 
nameTextID = {202872, 202064}
, 
emotionId = {1, 0}
, contentTextID = 202924, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2751] = {id = 2751, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1086}
, 
nameTextID = {202064, 202836}
, 
emotionId = {1, 0}
, contentTextID = 202925, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2752] = {id = 2752, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202927, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080159, skipTime = 30}
, 
[2753] = {id = 2753, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202928, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080160, skipTime = 30}
, 
[2754] = {id = 2754, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202929, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080161, skipTime = 30}
, 
[2755] = {id = 2755, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202930, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080162, skipTime = 30}
, 
[2756] = {id = 2756, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202937, 202938}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2757] = {id = 2757, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202931, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080163, skipTime = 30}
, 
[2758] = {id = 2758, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202932, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080164, skipTime = 30}
, 
[2759] = {id = 2759, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202933, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080165, skipTime = 30}
, 
[2760] = {id = 2760, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202934, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080166, skipTime = 30}
, 
[2761] = {id = 2761, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202935, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080167, skipTime = 30}
, 
[2762] = {id = 2762, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 202936, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080168, skipTime = 30}
, 
[2763] = {id = 2763, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202943, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2764] = {id = 2764, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 202944, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080053, skipTime = 30}
, 
[2765] = {id = 2765, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202945}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2766] = {id = 2766, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 202946, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080054, skipTime = 30}
, 
[2767] = {id = 2767, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 202947, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080055, skipTime = 30}
, 
[2768] = {id = 2768, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202948}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2769] = {id = 2769, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1027}
, 
nameTextID = {202064, 200169}
, 
emotionId = {0, 0}
, contentTextID = 202949, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080056, skipTime = 30}
, 
[2770] = {id = 2770, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202950, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080091, skipTime = 30}
, 
[2771] = {id = 2771, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202951, 202952}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2772] = {id = 2772, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202953, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080092, skipTime = 30}
, 
[2773] = {id = 2773, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202954}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2774] = {id = 2774, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202955, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080093, skipTime = 30}
, 
[2775] = {id = 2775, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {202956}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2776] = {id = 2776, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202957, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080094, skipTime = 30}
, 
[2777] = {id = 2777, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202958, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080099, skipTime = 30}
, 
[2778] = {id = 2778, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202959, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080100, skipTime = 30}
, 
[2779] = {id = 2779, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {202790, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202960, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080101, skipTime = 30}
, 
[2780] = {id = 2780, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202961, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2781] = {id = 2781, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202962, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[2782] = {id = 2782, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202965, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2783] = {id = 2783, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202966, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2784] = {id = 2784, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202967, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2785] = {id = 2785, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202968, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2786] = {id = 2786, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202969, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2787] = {id = 2787, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202970, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2788] = {id = 2788, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202971, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2789] = {id = 2789, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202972, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2790] = {id = 2790, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202973, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2791] = {id = 2791, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202974, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2792] = {id = 2792, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202975, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2793] = {id = 2793, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202976, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2794] = {id = 2794, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203197, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2795] = {id = 2795, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203198, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2796] = {id = 2796, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202977, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2797] = {id = 2797, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202978, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2798] = {id = 2798, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202979, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2799] = {id = 2799, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202980, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2800] = {id = 2800, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202981, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2801] = {id = 2801, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202982, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2802] = {id = 2802, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202983, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2803] = {id = 2803, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202984, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2804] = {id = 2804, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202985, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2805] = {id = 2805, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202986, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2806] = {id = 2806, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202987, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2807] = {id = 2807, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202988, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2808] = {id = 2808, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 202989, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2809] = {id = 2809, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202990, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2810] = {id = 2810, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202991, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2811] = {id = 2811, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202992, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2812] = {id = 2812, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202993, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2813] = {id = 2813, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202994, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2814] = {id = 2814, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202995, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2815] = {id = 2815, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202996, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2816] = {id = 2816, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202997, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2817] = {id = 2817, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 202998, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2818] = {id = 2818, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 202999, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2819] = {id = 2819, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203000, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2820] = {id = 2820, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203001, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2821] = {id = 2821, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203002, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2822] = {id = 2822, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203003, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2823] = {id = 2823, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203004, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2824] = {id = 2824, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203005, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2825] = {id = 2825, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203006, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2826] = {id = 2826, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203007, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2827] = {id = 2827, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203008, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2828] = {id = 2828, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203009, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2829] = {id = 2829, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203010, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2830] = {id = 2830, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203011, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2831] = {id = 2831, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203012, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2832] = {id = 2832, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203013, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2833] = {id = 2833, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203014, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2834] = {id = 2834, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203015, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2835] = {id = 2835, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203016, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2836] = {id = 2836, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203017, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2837] = {id = 2837, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203018, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2838] = {id = 2838, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203019, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2839] = {id = 2839, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203020, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2840] = {id = 2840, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203021, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2841] = {id = 2841, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203022, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2842] = {id = 2842, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203023, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2843] = {id = 2843, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203024, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2844] = {id = 2844, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203025, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2845] = {id = 2845, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203026, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2846] = {id = 2846, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203027, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2847] = {id = 2847, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203028, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2848] = {id = 2848, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203029, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2849] = {id = 2849, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203030, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2850] = {id = 2850, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203031, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2851] = {id = 2851, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203032, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2852] = {id = 2852, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203033, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2853] = {id = 2853, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203034, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2854] = {id = 2854, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203035, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2855] = {id = 2855, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203036, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2856] = {id = 2856, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203037, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2857] = {id = 2857, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203038, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2858] = {id = 2858, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203039, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2859] = {id = 2859, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203040, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2860] = {id = 2860, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203041, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2861] = {id = 2861, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203042, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2862] = {id = 2862, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203043, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2863] = {id = 2863, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203044, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2864] = {id = 2864, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203045, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2865] = {id = 2865, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203046, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2866] = {id = 2866, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203047, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2867] = {id = 2867, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203048, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2868] = {id = 2868, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203049, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2869] = {id = 2869, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203050, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2870] = {id = 2870, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203051, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2871] = {id = 2871, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203052, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2872] = {id = 2872, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203053, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2873] = {id = 2873, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203054, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2874] = {id = 2874, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203055, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2875] = {id = 2875, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203056, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2876] = {id = 2876, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203057, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2877] = {id = 2877, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203058, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2878] = {id = 2878, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203059, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2879] = {id = 2879, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203060, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2880] = {id = 2880, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203061, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2881] = {id = 2881, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203062, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2882] = {id = 2882, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203063, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2883] = {id = 2883, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203064, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2884] = {id = 2884, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203065, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2885] = {id = 2885, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203066, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2886] = {id = 2886, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203067, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2887] = {id = 2887, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203068, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2888] = {id = 2888, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203069, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2889] = {id = 2889, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203070, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2890] = {id = 2890, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203071, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2891] = {id = 2891, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203072, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2892] = {id = 2892, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203073, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2893] = {id = 2893, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203074, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2894] = {id = 2894, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203075, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2895] = {id = 2895, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203076, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2896] = {id = 2896, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203077, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2897] = {id = 2897, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203078, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2898] = {id = 2898, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203079, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2899] = {id = 2899, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203080, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2900] = {id = 2900, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203081, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2901] = {id = 2901, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203082, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2902] = {id = 2902, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203083, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2903] = {id = 2903, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203084, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2904] = {id = 2904, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203085, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2905] = {id = 2905, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203199, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2906] = {id = 2906, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203086, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2907] = {id = 2907, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203087, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2908] = {id = 2908, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203088, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2909] = {id = 2909, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203089, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2910] = {id = 2910, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203090, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2911] = {id = 2911, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203091, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2912] = {id = 2912, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203092, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2913] = {id = 2913, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203093, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2914] = {id = 2914, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203094, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2915] = {id = 2915, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203095, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2916] = {id = 2916, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203096, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2917] = {id = 2917, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203097, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2918] = {id = 2918, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203098, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2919] = {id = 2919, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203099, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2920] = {id = 2920, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203100, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2921] = {id = 2921, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203101, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2922] = {id = 2922, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203102, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2923] = {id = 2923, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203103, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2924] = {id = 2924, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203104, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2925] = {id = 2925, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203105, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2926] = {id = 2926, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203106, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2927] = {id = 2927, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203107, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2928] = {id = 2928, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203108, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2929] = {id = 2929, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203109, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2930] = {id = 2930, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203110, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2931] = {id = 2931, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203111, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2932] = {id = 2932, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203112, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2933] = {id = 2933, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203113, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2934] = {id = 2934, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203114, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2935] = {id = 2935, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203115, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2936] = {id = 2936, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203116, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2937] = {id = 2937, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203117, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2938] = {id = 2938, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203118, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2939] = {id = 2939, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203119, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2940] = {id = 2940, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203120, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2941] = {id = 2941, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203121, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2942] = {id = 2942, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203122, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2943] = {id = 2943, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203123, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2944] = {id = 2944, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203124, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2945] = {id = 2945, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203125, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2946] = {id = 2946, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203126, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2947] = {id = 2947, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203127, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2948] = {id = 2948, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203128, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2949] = {id = 2949, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203129, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2950] = {id = 2950, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203130, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2951] = {id = 2951, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203131, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2952] = {id = 2952, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203132, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2953] = {id = 2953, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203133, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2954] = {id = 2954, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203200, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2955] = {id = 2955, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203134, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2956] = {id = 2956, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1025, 0}
, 
nameTextID = {202963, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203135, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2957] = {id = 2957, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203136, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2958] = {id = 2958, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203137, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2959] = {id = 2959, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203138, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2960] = {id = 2960, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203139, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2961] = {id = 2961, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203140, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2962] = {id = 2962, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203141, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2963] = {id = 2963, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203142, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2964] = {id = 2964, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203143, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2965] = {id = 2965, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203144, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2966] = {id = 2966, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203145, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2967] = {id = 2967, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203146, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2968] = {id = 2968, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203147, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2969] = {id = 2969, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203148, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2970] = {id = 2970, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203149, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2971] = {id = 2971, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203150, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2972] = {id = 2972, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203151, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2973] = {id = 2973, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203152, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2974] = {id = 2974, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203153, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2975] = {id = 2975, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203154, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2976] = {id = 2976, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203155, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2977] = {id = 2977, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203156, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2978] = {id = 2978, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203157, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2979] = {id = 2979, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203158, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2980] = {id = 2980, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203159, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2981] = {id = 2981, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203160, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2982] = {id = 2982, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203161, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2983] = {id = 2983, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203162, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2984] = {id = 2984, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5015, 0}
, 
nameTextID = {200156, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203163, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2985] = {id = 2985, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203164, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2986] = {id = 2986, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203165, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2987] = {id = 2987, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203166, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2988] = {id = 2988, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203167, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2989] = {id = 2989, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203168, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2990] = {id = 2990, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203169, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2991] = {id = 2991, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203170, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2992] = {id = 2992, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203171, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2993] = {id = 2993, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203172, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2994] = {id = 2994, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203173, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2995] = {id = 2995, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203174, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2996] = {id = 2996, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203175, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2997] = {id = 2997, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5016}
, 
nameTextID = {202064, 200157}
, 
emotionId = {0, 0}
, contentTextID = 203176, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2998] = {id = 2998, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203177, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[2999] = {id = 2999, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203178, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3000] = {id = 3000, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203179, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3001] = {id = 3001, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203180, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3002] = {id = 3002, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203181, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3003] = {id = 3003, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203182, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3004] = {id = 3004, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203183, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3005] = {id = 3005, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203184, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3006] = {id = 3006, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203185, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3007] = {id = 3007, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203186, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3008] = {id = 3008, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203187, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3009] = {id = 3009, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203188, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3010] = {id = 3010, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203189, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3011] = {id = 3011, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203190, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3012] = {id = 3012, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203191, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3013] = {id = 3013, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1044, 0}
, 
nameTextID = {202964, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203192, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3014] = {id = 3014, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203193, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3015] = {id = 3015, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203194, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3016] = {id = 3016, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203195, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3017] = {id = 3017, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5015}
, 
nameTextID = {202064, 200156}
, 
emotionId = {0, 0}
, contentTextID = 203196, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3018] = {id = 3018, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1017, 0}
, 
nameTextID = {200154, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203201, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080128, skipTime = 0}
, 
[3019] = {id = 3019, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203203, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800571, skipTime = 0}
, 
[3020] = {id = 3020, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203204, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800572, skipTime = 0}
, 
[3021] = {id = 3021, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203205}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3022] = {id = 3022, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203206, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800581, skipTime = 0}
, 
[3023] = {id = 3023, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203207, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800582, skipTime = 0}
, 
[3024] = {id = 3024, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203208, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800583, skipTime = 0}
, 
[3025] = {id = 3025, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203209}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3026] = {id = 3026, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203210, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080059, skipTime = 0}
, 
[3027] = {id = 3027, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203211}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3028] = {id = 3028, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203212, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800601, skipTime = 0}
, 
[3029] = {id = 3029, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203213, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800602, skipTime = 0}
, 
[3030] = {id = 3030, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203214, 203215}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3031] = {id = 3031, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203216, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800611, skipTime = 0}
, 
[3032] = {id = 3032, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203217, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800612, skipTime = 0}
, 
[3033] = {id = 3033, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203218, 203219}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3034] = {id = 3034, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203220, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080062, skipTime = 0}
, 
[3035] = {id = 3035, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203221, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800631, skipTime = 0}
, 
[3036] = {id = 3036, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203222, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 200800632, skipTime = 0}
, 
[3037] = {id = 3037, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1055, 0}
, 
nameTextID = {202335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203223, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20080064, skipTime = 0}
, 
[3038] = {id = 3038, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1025}
, 
nameTextID = {202064, 202963}
, 
emotionId = {0, 0}
, contentTextID = 203235, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3039] = {id = 3039, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3040] = {id = 3040, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203242, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3041] = {id = 3041, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203243, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3042] = {id = 3042, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203244, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3043] = {id = 3043, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203245}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3044] = {id = 3044, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203246, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3045] = {id = 3045, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1055}
, 
nameTextID = {202064, 202335}
, 
emotionId = {0, 0}
, contentTextID = 203247, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3046] = {id = 3046, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203248, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3047] = {id = 3047, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1055}
, 
nameTextID = {202064, 202335}
, 
emotionId = {0, 0}
, contentTextID = 203249, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3048] = {id = 3048, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203250, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3049] = {id = 3049, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203251, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3050] = {id = 3050, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1055}
, 
nameTextID = {202064, 202335}
, 
emotionId = {0, 0}
, contentTextID = 203252, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3051] = {id = 3051, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1027, 0}
, 
nameTextID = {202903, 202064}
, 
emotionId = {1, 0}
, contentTextID = 203253, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3052] = {id = 3052, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1055}
, 
nameTextID = {202064, 202335}
, 
emotionId = {0, 0}
, contentTextID = 203254, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3053] = {id = 3053, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {8, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203256, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3054] = {id = 3054, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {8, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203257, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3055] = {id = 3055, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {8, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203258, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3056] = {id = 3056, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {8, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203259, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3057] = {id = 3057, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203299, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203302, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3058] = {id = 3058, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203300, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203303, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3059] = {id = 3059, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203301, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203304, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3060] = {id = 3060, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203299, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203305, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3061] = {id = 3061, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203306, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3062] = {id = 3062, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203307, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3063] = {id = 3063, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203308, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3064] = {id = 3064, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203309, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3065] = {id = 3065, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203310, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3066] = {id = 3066, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203311, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3067] = {id = 3067, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203312, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3068] = {id = 3068, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203313, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3069] = {id = 3069, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203320, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3070] = {id = 3070, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203321, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3071] = {id = 3071, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203322, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3072] = {id = 3072, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203323, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3073] = {id = 3073, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203324}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3074] = {id = 3074, chatType = 0, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203325, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3075] = {id = 3075, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203326, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3076] = {id = 3076, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203327, 203328}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3077] = {id = 3077, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203329, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3078] = {id = 3078, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203330, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3079] = {id = 3079, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203331, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3080] = {id = 3080, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203332, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3081] = {id = 3081, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203333}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3082] = {id = 3082, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203334, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3083] = {id = 3083, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203335, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3084] = {id = 3084, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203336}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3085] = {id = 3085, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203337, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3086] = {id = 3086, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203338, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3087] = {id = 3087, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203343, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3088] = {id = 3088, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203344, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3089] = {id = 3089, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {202368, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203345, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3090] = {id = 3090, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 203346, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3091] = {id = 3091, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203347, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3092] = {id = 3092, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203348, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3093] = {id = 3093, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 203349, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3094] = {id = 3094, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203350, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3095] = {id = 3095, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 203351, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3096] = {id = 3096, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203352, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3097] = {id = 3097, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203353, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3098] = {id = 3098, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 203354, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3099] = {id = 3099, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203355, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3100] = {id = 3100, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203356, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3101] = {id = 3101, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 203357, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3102] = {id = 3102, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203358, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3103] = {id = 3103, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203359, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3104] = {id = 3104, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203367, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3105] = {id = 3105, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203368, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3106] = {id = 3106, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203369, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3107] = {id = 3107, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203370, 203371}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3108] = {id = 3108, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203372, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3109] = {id = 3109, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203373, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3110] = {id = 3110, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203374, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3111] = {id = 3111, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203375, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3112] = {id = 3112, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203376, 203377}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3113] = {id = 3113, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1069}
, 
nameTextID = {202064, 203360}
, 
emotionId = {0, 0}
, contentTextID = 203378, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3114] = {id = 3114, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203386, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3115] = {id = 3115, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203380, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3116] = {id = 3116, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203387}
, 
emotionId = {0, 0}
, contentTextID = 203381, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3117] = {id = 3117, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203382, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3118] = {id = 3118, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203383, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3119] = {id = 3119, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203384, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3120] = {id = 3120, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203385, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3121] = {id = 3121, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203389, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3122] = {id = 3122, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203390, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3123] = {id = 3123, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203391, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3124] = {id = 3124, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203395, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3125] = {id = 3125, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203396, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3126] = {id = 3126, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203397, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3127] = {id = 3127, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1060}
, 
nameTextID = {202064, 203388}
, 
emotionId = {0, 0}
, contentTextID = 203398, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3128] = {id = 3128, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203399, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3129] = {id = 3129, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203400, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3130] = {id = 3130, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203401, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3131] = {id = 3131, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203402, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3132] = {id = 3132, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1069, 0}
, 
nameTextID = {203360, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203403, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3133] = {id = 3133, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203404, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3134] = {id = 3134, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203405}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3135] = {id = 3135, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203406, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3136] = {id = 3136, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203407, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3137] = {id = 3137, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203408, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3138] = {id = 3138, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203409, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3139] = {id = 3139, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203419, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3140] = {id = 3140, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203420, 203421}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3141] = {id = 3141, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203422, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3142] = {id = 3142, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203423, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3143] = {id = 3143, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203424, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3144] = {id = 3144, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1049}
, 
nameTextID = {202064, 203394}
, 
emotionId = {0, 0}
, contentTextID = 203425, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3145] = {id = 3145, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203426, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3146] = {id = 3146, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203427, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3147] = {id = 3147, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203428, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3148] = {id = 3148, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203429, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3149] = {id = 3149, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203430, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3150] = {id = 3150, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203431, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3151] = {id = 3151, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203432, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3152] = {id = 3152, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1004}
, 
nameTextID = {202064, 202151}
, 
emotionId = {0, 0}
, contentTextID = 203433, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3153] = {id = 3153, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203434, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3154] = {id = 3154, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203435, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3155] = {id = 3155, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203436, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3156] = {id = 3156, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203437, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3157] = {id = 3157, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203444, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3158] = {id = 3158, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203445, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3159] = {id = 3159, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203446, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3160] = {id = 3160, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203457, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3161] = {id = 3161, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3162] = {id = 3162, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203459, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3163] = {id = 3163, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203460, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3164] = {id = 3164, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203461, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3165] = {id = 3165, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3166] = {id = 3166, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3167] = {id = 3167, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203464, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3168] = {id = 3168, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1020, 0}
, 
nameTextID = {200128, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203465, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3169] = {id = 3169, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203466, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3170] = {id = 3170, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203467, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3171] = {id = 3171, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203469, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3172] = {id = 3172, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203470, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3173] = {id = 3173, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203471, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3174] = {id = 3174, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203472, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3175] = {id = 3175, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203473}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3176] = {id = 3176, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203474, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3177] = {id = 3177, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203475, 203476}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3178] = {id = 3178, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1083}
, 
nameTextID = {202064, 203468}
, 
emotionId = {0, 0}
, contentTextID = 203477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3179] = {id = 3179, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203492, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203485, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3180] = {id = 3180, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203486, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3181] = {id = 3181, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203492, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203487, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3182] = {id = 3182, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {203492, 202064}
, 
emotionId = {0, 0}
, contentTextID = 203488, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3183] = {id = 3183, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203489, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3184] = {id = 3184, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203490, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3185] = {id = 3185, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203491, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3186] = {id = 3186, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203497, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3187] = {id = 3187, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203498, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3188] = {id = 3188, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {203499, 203500}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3189] = {id = 3189, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 203501, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3190] = {id = 3190, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 203502, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3191] = {id = 3191, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 203503, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3192] = {id = 3192, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 203504, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3193] = {id = 3193, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204199, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3194] = {id = 3194, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204200, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3195] = {id = 3195, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204201, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3196] = {id = 3196, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204202, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3197] = {id = 3197, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204203, 204204}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3198] = {id = 3198, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204205, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3199] = {id = 3199, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204206}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3200] = {id = 3200, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204207, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3201] = {id = 3201, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204208, 204209}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3202] = {id = 3202, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204210, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3203] = {id = 3203, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204211, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3204] = {id = 3204, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204212, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3205] = {id = 3205, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1022}
, 
nameTextID = {202064, 204493}
, 
emotionId = {0, 0}
, contentTextID = 204213, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3206] = {id = 3206, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 204238, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3207] = {id = 3207, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 202368}
, 
emotionId = {0, 0}
, contentTextID = 204239, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3208] = {id = 3208, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204240, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3209] = {id = 3209, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204241, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3210] = {id = 3210, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204242, 204243}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3211] = {id = 3211, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204245, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3212] = {id = 3212, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204246, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3213] = {id = 3213, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204247, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3214] = {id = 3214, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204248, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3215] = {id = 3215, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204249, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3216] = {id = 3216, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204250, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3217] = {id = 3217, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204252, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3218] = {id = 3218, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204253, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3219] = {id = 3219, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204254, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3220] = {id = 3220, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204255}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3221] = {id = 3221, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204256, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3222] = {id = 3222, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1022, 0}
, 
nameTextID = {204493, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204257, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3223] = {id = 3223, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204258, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3224] = {id = 3224, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204259, 204260}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3225] = {id = 3225, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204261, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3226] = {id = 3226, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204262, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3227] = {id = 3227, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204263, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3228] = {id = 3228, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204266}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3229] = {id = 3229, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204267, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3230] = {id = 3230, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204268}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3231] = {id = 3231, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204269, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3232] = {id = 3232, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1041}
, 
nameTextID = {202064, 204251}
, 
emotionId = {0, 0}
, contentTextID = 204270, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3233] = {id = 3233, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, -1}
, 
nameTextID = {202064, -1}
, 
emotionId = {0, 0}
, contentTextID = 204271, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3234] = {id = 3234, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {-2, 0}
, 
nameTextID = {-2, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204272, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3235] = {id = 3235, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204300, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3236] = {id = 3236, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1073}
, 
nameTextID = {202064, 200165}
, 
emotionId = {0, 0}
, contentTextID = 204301, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3237] = {id = 3237, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204302}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3238] = {id = 3238, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204303, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3239] = {id = 3239, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204304, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3240] = {id = 3240, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200150, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204305, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3241] = {id = 3241, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204306, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3242] = {id = 3242, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204307}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3243] = {id = 3243, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204308, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3244] = {id = 3244, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204309, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3245] = {id = 3245, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {200147, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204310, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3246] = {id = 3246, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204311, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3247] = {id = 3247, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204312}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3248] = {id = 3248, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204313}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3249] = {id = 3249, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1021, 0}
, 
nameTextID = {204316, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204314, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3250] = {id = 3250, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1021, 0}
, 
nameTextID = {204316, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204315, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3251] = {id = 3251, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10046, 0}
, 
nameTextID = {200120, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204439, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3252] = {id = 3252, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204440, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3253] = {id = 3253, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {0, 0}
, contentTextID = 204441, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3254] = {id = 3254, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204442, 204443}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3255] = {id = 3255, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20071}
, 
nameTextID = {202064, 200111}
, 
emotionId = {0, 0}
, contentTextID = 204444, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3256] = {id = 3256, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {10, 0}
, 
nameTextID = {200107, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204445, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20030010, skipTime = 30}
, 
[3257] = {id = 3257, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 204446, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060010, skipTime = 30}
, 
[3258] = {id = 3258, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {204447}
, 
chooseValue = {}
, voiceId = 0, skipTime = 30}
, 
[3259] = {id = 3259, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 10}
, 
nameTextID = {202064, 200127}
, 
emotionId = {0, 0}
, contentTextID = 204448, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20060011, skipTime = 30}
, 
[3260] = {id = 3260, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204453, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3261] = {id = 3261, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204454, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3262] = {id = 3262, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204455, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3263] = {id = 3263, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204456, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3264] = {id = 3264, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204457, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3265] = {id = 3265, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3266] = {id = 3266, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204459, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3267] = {id = 3267, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204460, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3268] = {id = 3268, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204461, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3269] = {id = 3269, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3270] = {id = 3270, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3271] = {id = 3271, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {200115, 202064}
, 
emotionId = {1, 0}
, contentTextID = 204464, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3272] = {id = 3272, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20016}
, 
nameTextID = {202064, 200117}
, 
emotionId = {0, 0}
, contentTextID = 204465, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3273] = {id = 3273, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 204476}
, 
emotionId = {0, 0}
, contentTextID = 204477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3274] = {id = 3274, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206336, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100001, skipTime = 0}
, 
[3275] = {id = 3275, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206337, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100002, skipTime = 0}
, 
[3276] = {id = 3276, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206338, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100003, skipTime = 0}
, 
[3277] = {id = 3277, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 206339}
, 
emotionId = {0, 0}
, contentTextID = 206340, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100004, skipTime = 0}
, 
[3278] = {id = 3278, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 206339}
, 
emotionId = {0, 0}
, contentTextID = 206341, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100005, skipTime = 0}
, 
[3279] = {id = 3279, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206343, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100006, skipTime = 0}
, 
[3280] = {id = 3280, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1059}
, 
nameTextID = {202064, 206339}
, 
emotionId = {0, 0}
, contentTextID = 206344, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100007, skipTime = 0}
, 
[3281] = {id = 3281, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206345, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100008, skipTime = 0}
, 
[3282] = {id = 3282, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206346, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100009, skipTime = 0}
, 
[3283] = {id = 3283, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206348, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100010, skipTime = 0}
, 
[3284] = {id = 3284, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206349, 206350}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3285] = {id = 3285, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206351, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100011, skipTime = 0}
, 
[3286] = {id = 3286, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206352, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3287] = {id = 3287, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206353, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100012, skipTime = 0}
, 
[3288] = {id = 3288, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206354, 206355}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3289] = {id = 3289, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206356, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100013, skipTime = 0}
, 
[3290] = {id = 3290, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206357, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100014, skipTime = 0}
, 
[3291] = {id = 3291, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206358, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100015, skipTime = 0}
, 
[3292] = {id = 3292, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206360, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100016, skipTime = 0}
, 
[3293] = {id = 3293, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206361, 206362}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3294] = {id = 3294, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206363, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100017, skipTime = 0}
, 
[3295] = {id = 3295, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206364, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100018, skipTime = 0}
, 
[3296] = {id = 3296, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206365, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100019, skipTime = 0}
, 
[3297] = {id = 3297, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206366, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100020, skipTime = 0}
, 
[3298] = {id = 3298, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206367, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100021, skipTime = 0}
, 
[3299] = {id = 3299, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206368, 206369}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3300] = {id = 3300, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206370, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100022, skipTime = 0}
, 
[3301] = {id = 3301, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206371, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100023, skipTime = 0}
, 
[3302] = {id = 3302, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206372, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100024, skipTime = 0}
, 
[3303] = {id = 3303, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206373}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3304] = {id = 3304, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1059, 0}
, 
nameTextID = {206339, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206374, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100025, skipTime = 0}
, 
[3305] = {id = 3305, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1059, 0}
, 
nameTextID = {206339, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206375, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100026, skipTime = 0}
, 
[3306] = {id = 3306, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1059, 0}
, 
nameTextID = {206339, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206376, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3307] = {id = 3307, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206377, 206378}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3308] = {id = 3308, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1059, 0}
, 
nameTextID = {206339, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206379, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100027, skipTime = 0}
, 
[3309] = {id = 3309, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1059, 0}
, 
nameTextID = {206339, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206380, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100028, skipTime = 0}
, 
[3310] = {id = 3310, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206381, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100029, skipTime = 0}
, 
[3311] = {id = 3311, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206382, 206383}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3312] = {id = 3312, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206384, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100030, skipTime = 0}
, 
[3313] = {id = 3313, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206385, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100031, skipTime = 0}
, 
[3314] = {id = 3314, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206386, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100032, skipTime = 0}
, 
[3315] = {id = 3315, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206447, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100033, skipTime = 0}
, 
[3316] = {id = 3316, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206448, 206449}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3317] = {id = 3317, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206450, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100034, skipTime = 0}
, 
[3318] = {id = 3318, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206451, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100035, skipTime = 0}
, 
[3319] = {id = 3319, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206452, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100036, skipTime = 0}
, 
[3320] = {id = 3320, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206453, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100037, skipTime = 0}
, 
[3321] = {id = 3321, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206454, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100038, skipTime = 0}
, 
[3322] = {id = 3322, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206455, 206456}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3323] = {id = 3323, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206457, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100039, skipTime = 0}
, 
[3324] = {id = 3324, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206458, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100040, skipTime = 0}
, 
[3325] = {id = 3325, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206459}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3326] = {id = 3326, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206460, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100041, skipTime = 0}
, 
[3327] = {id = 3327, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206461, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100042, skipTime = 0}
, 
[3328] = {id = 3328, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206462, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100043, skipTime = 0}
, 
[3329] = {id = 3329, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206446}
, 
emotionId = {0, 0}
, contentTextID = 206463, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100044, skipTime = 0}
, 
[3330] = {id = 3330, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206465, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100045, skipTime = 0}
, 
[3331] = {id = 3331, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206466, 206467}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3332] = {id = 3332, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206468, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100046, skipTime = 0}
, 
[3333] = {id = 3333, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206469, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100047, skipTime = 0}
, 
[3334] = {id = 3334, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206470, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100048, skipTime = 0}
, 
[3335] = {id = 3335, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206471, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100049, skipTime = 0}
, 
[3336] = {id = 3336, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206464}
, 
emotionId = {0, 0}
, contentTextID = 206472, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100050, skipTime = 0}
, 
[3337] = {id = 3337, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206473, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100051, skipTime = 0}
, 
[3338] = {id = 3338, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206474, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100052, skipTime = 0}
, 
[3339] = {id = 3339, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206475, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100053, skipTime = 0}
, 
[3340] = {id = 3340, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206476, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100054, skipTime = 0}
, 
[3341] = {id = 3341, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206477, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100055, skipTime = 0}
, 
[3342] = {id = 3342, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206478, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100056, skipTime = 0}
, 
[3343] = {id = 3343, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206479, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100057, skipTime = 0}
, 
[3344] = {id = 3344, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206480, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100058, skipTime = 0}
, 
[3345] = {id = 3345, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206481, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100059, skipTime = 0}
, 
[3346] = {id = 3346, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206482, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100060, skipTime = 0}
, 
[3347] = {id = 3347, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206483, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100061, skipTime = 0}
, 
[3348] = {id = 3348, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206484}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3349] = {id = 3349, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206485, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100062, skipTime = 0}
, 
[3350] = {id = 3350, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206486, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100063, skipTime = 0}
, 
[3351] = {id = 3351, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {20140, 0}
, 
nameTextID = {206487, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206488, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100064, skipTime = 0}
, 
[3352] = {id = 3352, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206490, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100065, skipTime = 0}
, 
[3353] = {id = 3353, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206491, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100066, skipTime = 0}
, 
[3354] = {id = 3354, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206492, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100067, skipTime = 0}
, 
[3355] = {id = 3355, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206493, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100068, skipTime = 0}
, 
[3356] = {id = 3356, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206494, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100069, skipTime = 0}
, 
[3357] = {id = 3357, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206495, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3358] = {id = 3358, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206496, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100071, skipTime = 0}
, 
[3359] = {id = 3359, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206497, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100072, skipTime = 0}
, 
[3360] = {id = 3360, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206498, 206499}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3361] = {id = 3361, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206500, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100073, skipTime = 0}
, 
[3362] = {id = 3362, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206501, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100074, skipTime = 0}
, 
[3363] = {id = 3363, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206502, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3364] = {id = 3364, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206503, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100076, skipTime = 0}
, 
[3365] = {id = 3365, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206504, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100077, skipTime = 0}
, 
[3366] = {id = 3366, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206505}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3367] = {id = 3367, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206506, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100078, skipTime = 0}
, 
[3368] = {id = 3368, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206507, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100079, skipTime = 0}
, 
[3369] = {id = 3369, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206508, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100080, skipTime = 0}
, 
[3370] = {id = 3370, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206509, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100081, skipTime = 0}
, 
[3371] = {id = 3371, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206510, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100082, skipTime = 0}
, 
[3372] = {id = 3372, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206511, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100083, skipTime = 0}
, 
[3373] = {id = 3373, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1011, 0}
, 
nameTextID = {206335, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206512, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100084, skipTime = 0}
, 
[3374] = {id = 3374, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206513, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100085, skipTime = 0}
, 
[3375] = {id = 3375, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206514, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100086, skipTime = 0}
, 
[3376] = {id = 3376, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206515, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3377] = {id = 3377, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1011}
, 
nameTextID = {202064, 206335}
, 
emotionId = {0, 0}
, contentTextID = 206516, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100087, skipTime = 0}
, 
[3378] = {id = 3378, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 206487}
, 
emotionId = {0, 0}
, contentTextID = 206517, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100088, skipTime = 0}
, 
[3379] = {id = 3379, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 206487}
, 
emotionId = {0, 0}
, contentTextID = 206518, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100089, skipTime = 0}
, 
[3380] = {id = 3380, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206520, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100090, skipTime = 0}
, 
[3381] = {id = 3381, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206521, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100091, skipTime = 0}
, 
[3382] = {id = 3382, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206522, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100092, skipTime = 0}
, 
[3383] = {id = 3383, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206523, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100093, skipTime = 0}
, 
[3384] = {id = 3384, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206524, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100094, skipTime = 0}
, 
[3385] = {id = 3385, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206525, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100095, skipTime = 0}
, 
[3386] = {id = 3386, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206526, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100096, skipTime = 0}
, 
[3387] = {id = 3387, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206527, 206528}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3388] = {id = 3388, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206529, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100097, skipTime = 0}
, 
[3389] = {id = 3389, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206530, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100098, skipTime = 0}
, 
[3390] = {id = 3390, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206531, 206532}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3391] = {id = 3391, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206533, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100099, skipTime = 0}
, 
[3392] = {id = 3392, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206534}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3393] = {id = 3393, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206535, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100100, skipTime = 0}
, 
[3394] = {id = 3394, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206536, 206537}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3395] = {id = 3395, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206538, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100101, skipTime = 0}
, 
[3396] = {id = 3396, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206539, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100102, skipTime = 0}
, 
[3397] = {id = 3397, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206540, 206541}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3398] = {id = 3398, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206542, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100103, skipTime = 0}
, 
[3399] = {id = 3399, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206543, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100104, skipTime = 0}
, 
[3400] = {id = 3400, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206545, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100105, skipTime = 0}
, 
[3401] = {id = 3401, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206546}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3402] = {id = 3402, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206547, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100106, skipTime = 0}
, 
[3403] = {id = 3403, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206548, 206549}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3404] = {id = 3404, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206550, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100107, skipTime = 0}
, 
[3405] = {id = 3405, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206551}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3406] = {id = 3406, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206552, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100108, skipTime = 0}
, 
[3407] = {id = 3407, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206553, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100109, skipTime = 0}
, 
[3408] = {id = 3408, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206544}
, 
emotionId = {0, 0}
, contentTextID = 206554, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100110, skipTime = 0}
, 
[3409] = {id = 3409, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206556, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100111, skipTime = 0}
, 
[3410] = {id = 3410, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206557, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100112, skipTime = 0}
, 
[3411] = {id = 3411, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206558, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100113, skipTime = 0}
, 
[3412] = {id = 3412, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206559, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100114, skipTime = 0}
, 
[3413] = {id = 3413, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206560, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100115, skipTime = 0}
, 
[3414] = {id = 3414, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206561, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100116, skipTime = 0}
, 
[3415] = {id = 3415, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206562, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100117, skipTime = 0}
, 
[3416] = {id = 3416, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206563}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3417] = {id = 3417, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206564, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100118, skipTime = 0}
, 
[3418] = {id = 3418, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206565, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100119, skipTime = 0}
, 
[3419] = {id = 3419, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206566, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100120, skipTime = 0}
, 
[3420] = {id = 3420, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206567, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100121, skipTime = 0}
, 
[3421] = {id = 3421, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206568, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100122, skipTime = 0}
, 
[3422] = {id = 3422, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206569}
, 
emotionId = {0, 0}
, contentTextID = 206570, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3423] = {id = 3423, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206571, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100123, skipTime = 0}
, 
[3424] = {id = 3424, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206572, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100124, skipTime = 0}
, 
[3425] = {id = 3425, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206573}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3426] = {id = 3426, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206574, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100125, skipTime = 0}
, 
[3427] = {id = 3427, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 206575}
, 
emotionId = {0, 0}
, contentTextID = 206576, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100126, skipTime = 0}
, 
[3428] = {id = 3428, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 206577}
, 
emotionId = {0, 0}
, contentTextID = 206578, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100127, skipTime = 0}
, 
[3429] = {id = 3429, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 206575}
, 
emotionId = {0, 0}
, contentTextID = 206579, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100128, skipTime = 0}
, 
[3430] = {id = 3430, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206580, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100129, skipTime = 0}
, 
[3431] = {id = 3431, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206581, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3432] = {id = 3432, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206582, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100130, skipTime = 0}
, 
[3433] = {id = 3433, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206583, 206584}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3434] = {id = 3434, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206585, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100131, skipTime = 0}
, 
[3435] = {id = 3435, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206586, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100132, skipTime = 0}
, 
[3436] = {id = 3436, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206587, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100133, skipTime = 0}
, 
[3437] = {id = 3437, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206588, 206589}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3438] = {id = 3438, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 206590}
, 
emotionId = {0, 0}
, contentTextID = 206591, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100134, skipTime = 0}
, 
[3439] = {id = 3439, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206592, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100135, skipTime = 0}
, 
[3440] = {id = 3440, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206593, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100136, skipTime = 0}
, 
[3441] = {id = 3441, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1014}
, 
nameTextID = {202064, 206342}
, 
emotionId = {0, 0}
, contentTextID = 206594, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100137, skipTime = 0}
, 
[3442] = {id = 3442, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206595, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100138, skipTime = 0}
, 
[3443] = {id = 3443, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206596, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100139, skipTime = 0}
, 
[3444] = {id = 3444, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206597, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100140, skipTime = 0}
, 
[3445] = {id = 3445, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206598, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100141, skipTime = 0}
, 
[3446] = {id = 3446, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206599, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100142, skipTime = 0}
, 
[3447] = {id = 3447, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206600, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100143, skipTime = 0}
, 
[3448] = {id = 3448, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206601, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100144, skipTime = 0}
, 
[3449] = {id = 3449, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206602, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100145, skipTime = 0}
, 
[3450] = {id = 3450, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206603, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100146, skipTime = 0}
, 
[3451] = {id = 3451, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206604, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100147, skipTime = 0}
, 
[3452] = {id = 3452, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1063}
, 
nameTextID = {202064, 206590}
, 
emotionId = {0, 0}
, contentTextID = 206605, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100148, skipTime = 0}
, 
[3453] = {id = 3453, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206606, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100149, skipTime = 0}
, 
[3454] = {id = 3454, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206607, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100150, skipTime = 0}
, 
[3455] = {id = 3455, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206609, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100151, skipTime = 0}
, 
[3456] = {id = 3456, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206610, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100152, skipTime = 0}
, 
[3457] = {id = 3457, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206489, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206611, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100153, skipTime = 0}
, 
[3458] = {id = 3458, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206612, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100154, skipTime = 0}
, 
[3459] = {id = 3459, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206613, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100155, skipTime = 0}
, 
[3460] = {id = 3460, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206614, 206615}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3461] = {id = 3461, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206616, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100156, skipTime = 0}
, 
[3462] = {id = 3462, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206617, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100157, skipTime = 0}
, 
[3463] = {id = 3463, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206519}
, 
emotionId = {0, 0}
, contentTextID = 206618, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100158, skipTime = 0}
, 
[3464] = {id = 3464, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206619}
, 
emotionId = {0, 0}
, contentTextID = 206620, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3465] = {id = 3465, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206621, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206622, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3466] = {id = 3466, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206621, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206623, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3467] = {id = 3467, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206619}
, 
emotionId = {0, 0}
, contentTextID = 206624, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3468] = {id = 3468, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206619}
, 
emotionId = {0, 0}
, contentTextID = 206625, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3469] = {id = 3469, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206619}
, 
emotionId = {0, 0}
, contentTextID = 206626, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3470] = {id = 3470, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {206621, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206627, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3471] = {id = 3471, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206629, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100159, skipTime = 0}
, 
[3472] = {id = 3472, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206630}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3473] = {id = 3473, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206631, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100160, skipTime = 0}
, 
[3474] = {id = 3474, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206632}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3475] = {id = 3475, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206633, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100161, skipTime = 0}
, 
[3476] = {id = 3476, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206634, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100162, skipTime = 0}
, 
[3477] = {id = 3477, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206635, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100163, skipTime = 0}
, 
[3478] = {id = 3478, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206636, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100164, skipTime = 0}
, 
[3479] = {id = 3479, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206637, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100165, skipTime = 0}
, 
[3480] = {id = 3480, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206638, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100166, skipTime = 0}
, 
[3481] = {id = 3481, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206639, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100167, skipTime = 0}
, 
[3482] = {id = 3482, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206640, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100168, skipTime = 0}
, 
[3483] = {id = 3483, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206641, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100169, skipTime = 0}
, 
[3484] = {id = 3484, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206642, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100170, skipTime = 0}
, 
[3485] = {id = 3485, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206643, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100171, skipTime = 0}
, 
[3486] = {id = 3486, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206644, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100172, skipTime = 0}
, 
[3487] = {id = 3487, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206645, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100173, skipTime = 0}
, 
[3488] = {id = 3488, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206646, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100174, skipTime = 0}
, 
[3489] = {id = 3489, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206647, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100175, skipTime = 0}
, 
[3490] = {id = 3490, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206648, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100176, skipTime = 0}
, 
[3491] = {id = 3491, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206649, 206650}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3492] = {id = 3492, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206651, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100177, skipTime = 0}
, 
[3493] = {id = 3493, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206652, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100178, skipTime = 0}
, 
[3494] = {id = 3494, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206653, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100179, skipTime = 0}
, 
[3495] = {id = 3495, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206654, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100180, skipTime = 0}
, 
[3496] = {id = 3496, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206655, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100181, skipTime = 0}
, 
[3497] = {id = 3497, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206656, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100182, skipTime = 0}
, 
[3498] = {id = 3498, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1030}
, 
nameTextID = {202064, 206628}
, 
emotionId = {0, 0}
, contentTextID = 206657, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100183, skipTime = 0}
, 
[3499] = {id = 3499, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1016, 0}
, 
nameTextID = {206658, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206659, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100184, skipTime = 0}
, 
[3500] = {id = 3500, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206660, 206661}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3501] = {id = 3501, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1016, 0}
, 
nameTextID = {206658, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206662, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100185, skipTime = 0}
, 
[3502] = {id = 3502, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1016, 0}
, 
nameTextID = {206658, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206663, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100186, skipTime = 0}
, 
[3503] = {id = 3503, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206665, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100187, skipTime = 0}
, 
[3504] = {id = 3504, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206666, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100188, skipTime = 0}
, 
[3505] = {id = 3505, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206667}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3506] = {id = 3506, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206669, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100189, skipTime = 0}
, 
[3507] = {id = 3507, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206670, 206671}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3508] = {id = 3508, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206672, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100190, skipTime = 0}
, 
[3509] = {id = 3509, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206673, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100191, skipTime = 0}
, 
[3510] = {id = 3510, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206674, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100192, skipTime = 0}
, 
[3511] = {id = 3511, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206675}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3512] = {id = 3512, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206676, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100193, skipTime = 0}
, 
[3513] = {id = 3513, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206677, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100194, skipTime = 0}
, 
[3514] = {id = 3514, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206678, 206679}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3515] = {id = 3515, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206680, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100195, skipTime = 0}
, 
[3516] = {id = 3516, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206681, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100196, skipTime = 0}
, 
[3517] = {id = 3517, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206682, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100197, skipTime = 0}
, 
[3518] = {id = 3518, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206683, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100198, skipTime = 0}
, 
[3519] = {id = 3519, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206684, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100199, skipTime = 0}
, 
[3520] = {id = 3520, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206685, 206686}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3521] = {id = 3521, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206687, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100200, skipTime = 0}
, 
[3522] = {id = 3522, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206688, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100201, skipTime = 0}
, 
[3523] = {id = 3523, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206689, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100202, skipTime = 0}
, 
[3524] = {id = 3524, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206690, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100203, skipTime = 0}
, 
[3525] = {id = 3525, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206691, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100204, skipTime = 0}
, 
[3526] = {id = 3526, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206692, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100205, skipTime = 0}
, 
[3527] = {id = 3527, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206693, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100206, skipTime = 0}
, 
[3528] = {id = 3528, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206694, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100207, skipTime = 0}
, 
[3529] = {id = 3529, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206695, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100208, skipTime = 0}
, 
[3530] = {id = 3530, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206696, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100209, skipTime = 0}
, 
[3531] = {id = 3531, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206697, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100210, skipTime = 0}
, 
[3532] = {id = 3532, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206698, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100211, skipTime = 0}
, 
[3533] = {id = 3533, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206699, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100212, skipTime = 0}
, 
[3534] = {id = 3534, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206700, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100213, skipTime = 0}
, 
[3535] = {id = 3535, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206701, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100214, skipTime = 0}
, 
[3536] = {id = 3536, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206702, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100215, skipTime = 0}
, 
[3537] = {id = 3537, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206658}
, 
emotionId = {0, 0}
, contentTextID = 206703, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100216, skipTime = 0}
, 
[3538] = {id = 3538, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206704, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100217, skipTime = 0}
, 
[3539] = {id = 3539, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206708}
, 
emotionId = {0, 0}
, contentTextID = 206705, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100218, skipTime = 0}
, 
[3540] = {id = 3540, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206706, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100219, skipTime = 0}
, 
[3541] = {id = 3541, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206707, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100220, skipTime = 0}
, 
[3542] = {id = 3542, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206708}
, 
emotionId = {0, 0}
, contentTextID = 206709, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100221, skipTime = 0}
, 
[3543] = {id = 3543, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1078}
, 
nameTextID = {202064, 206710}
, 
emotionId = {0, 0}
, contentTextID = 206711, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100222, skipTime = 0}
, 
[3544] = {id = 3544, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1078}
, 
nameTextID = {202064, 206710}
, 
emotionId = {0, 0}
, contentTextID = 206712, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100223, skipTime = 0}
, 
[3545] = {id = 3545, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206713, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100224, skipTime = 0}
, 
[3546] = {id = 3546, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206714, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100225, skipTime = 0}
, 
[3547] = {id = 3547, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206715, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100226, skipTime = 0}
, 
[3548] = {id = 3548, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206716, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100227, skipTime = 0}
, 
[3549] = {id = 3549, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206717, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100228, skipTime = 0}
, 
[3550] = {id = 3550, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206718, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100229, skipTime = 0}
, 
[3551] = {id = 3551, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206719, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100230, skipTime = 0}
, 
[3552] = {id = 3552, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1016}
, 
nameTextID = {202064, 206708}
, 
emotionId = {0, 0}
, contentTextID = 206720, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100231, skipTime = 0}
, 
[3553] = {id = 3553, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206721, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100232, skipTime = 0}
, 
[3554] = {id = 3554, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206722, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100233, skipTime = 0}
, 
[3555] = {id = 3555, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206723, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100234, skipTime = 0}
, 
[3556] = {id = 3556, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206724, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100235, skipTime = 0}
, 
[3557] = {id = 3557, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206725, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100236, skipTime = 0}
, 
[3558] = {id = 3558, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1077}
, 
nameTextID = {202064, 206664}
, 
emotionId = {0, 0}
, contentTextID = 206726, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100237, skipTime = 0}
, 
[3559] = {id = 3559, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206727, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100238, skipTime = 0}
, 
[3560] = {id = 3560, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206728, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100239, skipTime = 0}
, 
[3561] = {id = 3561, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1078}
, 
nameTextID = {202064, 206710}
, 
emotionId = {0, 0}
, contentTextID = 206729, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100240, skipTime = 0}
, 
[3562] = {id = 3562, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1078}
, 
nameTextID = {202064, 206710}
, 
emotionId = {0, 0}
, contentTextID = 206730, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100241, skipTime = 0}
, 
[3563] = {id = 3563, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1078}
, 
nameTextID = {202064, 206710}
, 
emotionId = {0, 0}
, contentTextID = 206731, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100242, skipTime = 0}
, 
[3564] = {id = 3564, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206732, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100243, skipTime = 0}
, 
[3565] = {id = 3565, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206733, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100244, skipTime = 0}
, 
[3566] = {id = 3566, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206735, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100245, skipTime = 0}
, 
[3567] = {id = 3567, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206736, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100246, skipTime = 0}
, 
[3568] = {id = 3568, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206737, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100247, skipTime = 0}
, 
[3569] = {id = 3569, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206738, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100248, skipTime = 0}
, 
[3570] = {id = 3570, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206739, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100249, skipTime = 0}
, 
[3571] = {id = 3571, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206740, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100250, skipTime = 0}
, 
[3572] = {id = 3572, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206741, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100251, skipTime = 0}
, 
[3573] = {id = 3573, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206742, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100252, skipTime = 0}
, 
[3574] = {id = 3574, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206743, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100253, skipTime = 0}
, 
[3575] = {id = 3575, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206744, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100254, skipTime = 0}
, 
[3576] = {id = 3576, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206745, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100255, skipTime = 0}
, 
[3577] = {id = 3577, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1018, 0}
, 
nameTextID = {206734, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206746, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100256, skipTime = 0}
, 
[3578] = {id = 3578, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206747}
, 
emotionId = {0, 0}
, contentTextID = 206748, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100257, skipTime = 0}
, 
[3579] = {id = 3579, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206749, 206750}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3580] = {id = 3580, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206747}
, 
emotionId = {0, 0}
, contentTextID = 206751, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100258, skipTime = 0}
, 
[3581] = {id = 3581, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206747}
, 
emotionId = {0, 0}
, contentTextID = 206752, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100259, skipTime = 0}
, 
[3582] = {id = 3582, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206753}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3583] = {id = 3583, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206747}
, 
emotionId = {0, 0}
, contentTextID = 206754, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100260, skipTime = 0}
, 
[3584] = {id = 3584, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206747}
, 
emotionId = {0, 0}
, contentTextID = 206755, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100261, skipTime = 0}
, 
[3585] = {id = 3585, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206756, 206757}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3586] = {id = 3586, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206759, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100262, skipTime = 0}
, 
[3587] = {id = 3587, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206760, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100263, skipTime = 0}
, 
[3588] = {id = 3588, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206761, 206762}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3589] = {id = 3589, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206763, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100264, skipTime = 0}
, 
[3590] = {id = 3590, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206764, 206765}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3591] = {id = 3591, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206766, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100265, skipTime = 0}
, 
[3592] = {id = 3592, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206767, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100266, skipTime = 0}
, 
[3593] = {id = 3593, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206768, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100267, skipTime = 0}
, 
[3594] = {id = 3594, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206769, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100268, skipTime = 0}
, 
[3595] = {id = 3595, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206765}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3596] = {id = 3596, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206771, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3597] = {id = 3597, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206772}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3598] = {id = 3598, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206773, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100269, skipTime = 0}
, 
[3599] = {id = 3599, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206774, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100270, skipTime = 0}
, 
[3600] = {id = 3600, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1012}
, 
nameTextID = {202064, 206758}
, 
emotionId = {0, 0}
, contentTextID = 206775, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100271, skipTime = 0}
, 
[3601] = {id = 3601, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206784}
, 
emotionId = {0, 0}
, contentTextID = 206776, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100272, skipTime = 0}
, 
[3602] = {id = 3602, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206784}
, 
emotionId = {0, 0}
, contentTextID = 206777, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100273, skipTime = 0}
, 
[3603] = {id = 3603, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206778}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3604] = {id = 3604, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 9}
, 
nameTextID = {202064, 206784}
, 
emotionId = {0, 0}
, contentTextID = 206779, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100274, skipTime = 0}
, 
[3605] = {id = 3605, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 206487}
, 
emotionId = {0, 0}
, contentTextID = 206780, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100275, skipTime = 0}
, 
[3606] = {id = 3606, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {206544, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206781, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100276, skipTime = 0}
, 
[3607] = {id = 3607, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 20140}
, 
nameTextID = {202064, 206487}
, 
emotionId = {0, 0}
, contentTextID = 206782, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100277, skipTime = 0}
, 
[3608] = {id = 3608, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {9, 0}
, 
nameTextID = {206544, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206783, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100278, skipTime = 0}
, 
[3609] = {id = 3609, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206785, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100279, skipTime = 0}
, 
[3610] = {id = 3610, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206786, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100280, skipTime = 0}
, 
[3611] = {id = 3611, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206787, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100281, skipTime = 0}
, 
[3612] = {id = 3612, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206788, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100282, skipTime = 0}
, 
[3613] = {id = 3613, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206789, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100283, skipTime = 0}
, 
[3614] = {id = 3614, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206790, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100284, skipTime = 0}
, 
[3615] = {id = 3615, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206791, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100285, skipTime = 0}
, 
[3616] = {id = 3616, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206792, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100286, skipTime = 0}
, 
[3617] = {id = 3617, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206793, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100287, skipTime = 0}
, 
[3618] = {id = 3618, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206794, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100288, skipTime = 0}
, 
[3619] = {id = 3619, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206795, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100289, skipTime = 0}
, 
[3620] = {id = 3620, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206796, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3621] = {id = 3621, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206797, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100290, skipTime = 0}
, 
[3622] = {id = 3622, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206798, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100291, skipTime = 0}
, 
[3623] = {id = 3623, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206799, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100292, skipTime = 0}
, 
[3624] = {id = 3624, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206800, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100293, skipTime = 0}
, 
[3625] = {id = 3625, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 1062}
, 
nameTextID = {202064, 206359}
, 
emotionId = {0, 0}
, contentTextID = 206801, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100294, skipTime = 0}
, 
[3626] = {id = 3626, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206802, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100295, skipTime = 0}
, 
[3627] = {id = 3627, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {5025, 0}
, 
nameTextID = {206347, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206803, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100296, skipTime = 0}
, 
[3628] = {id = 3628, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206805, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100297, skipTime = 0}
, 
[3629] = {id = 3629, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206806, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100298, skipTime = 0}
, 
[3630] = {id = 3630, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206807, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100306, skipTime = 0}
, 
[3631] = {id = 3631, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206808, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100307, skipTime = 0}
, 
[3632] = {id = 3632, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206809, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100308, skipTime = 0}
, 
[3633] = {id = 3633, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206810, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100309, skipTime = 0}
, 
[3634] = {id = 3634, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206811}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3635] = {id = 3635, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206812, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100310, skipTime = 0}
, 
[3636] = {id = 3636, chatType = 3, isBlack = 1, isClickable = 0, 
shapeId = {0, 0}
, 
nameTextID = {202064, 202064}
, 
emotionId = {0, 0}
, contentTextID = -1, speed = "0.02", 
chooseTextID = {206813}
, 
chooseValue = {}
, voiceId = 0, skipTime = 0}
, 
[3637] = {id = 3637, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206814, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100311, skipTime = 0}
, 
[3638] = {id = 3638, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206815, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100312, skipTime = 0}
, 
[3639] = {id = 3639, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206816, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100313, skipTime = 0}
, 
[3640] = {id = 3640, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206817, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100314, skipTime = 0}
, 
[3641] = {id = 3641, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206818, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100315, skipTime = 0}
, 
[3642] = {id = 3642, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206819, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100316, skipTime = 0}
, 
[3643] = {id = 3643, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1014, 0}
, 
nameTextID = {206342, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206820, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100317, skipTime = 0}
, 
[3644] = {id = 3644, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206821, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100318, skipTime = 0}
, 
[3645] = {id = 3645, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206822, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100319, skipTime = 0}
, 
[3646] = {id = 3646, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206823, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100320, skipTime = 0}
, 
[3647] = {id = 3647, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206824, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100321, skipTime = 0}
, 
[3648] = {id = 3648, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1062, 0}
, 
nameTextID = {206359, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206825, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100322, skipTime = 0}
, 
[3649] = {id = 3649, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206826, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100323, skipTime = 0}
, 
[3650] = {id = 3650, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206827, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100324, skipTime = 0}
, 
[3651] = {id = 3651, chatType = 1, isBlack = 1, isClickable = 1, 
shapeId = {1030, 0}
, 
nameTextID = {206628, 202064}
, 
emotionId = {0, 0}
, contentTextID = 206828, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100325, skipTime = 0}
, 
[3652] = {id = 3652, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206829, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100326, skipTime = 0}
, 
[3653] = {id = 3653, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206830, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100327, skipTime = 0}
, 
[3654] = {id = 3654, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 5025}
, 
nameTextID = {202064, 206804}
, 
emotionId = {0, 0}
, contentTextID = 206831, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100328, skipTime = 0}
, 
[3655] = {id = 3655, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206832}
, 
emotionId = {0, 0}
, contentTextID = 206833, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100329, skipTime = 0}
, 
[3656] = {id = 3656, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206832}
, 
emotionId = {0, 0}
, contentTextID = 206834, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100330, skipTime = 0}
, 
[3657] = {id = 3657, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206832}
, 
emotionId = {0, 0}
, contentTextID = 206835, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100331, skipTime = 0}
, 
[3658] = {id = 3658, chatType = 2, isBlack = 1, isClickable = 1, 
shapeId = {0, 0}
, 
nameTextID = {202064, 206832}
, 
emotionId = {0, 0}
, contentTextID = 206836, speed = "0.02", 
chooseTextID = {}
, 
chooseValue = {}
, voiceId = 20100332, skipTime = 0}
}
cdramachatlist.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 1399, 1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499, 1500, 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1508, 1509, 1510, 1511, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1519, 1520, 1521, 1522, 1523, 1524, 1525, 1526, 1527, 1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1536, 1537, 1538, 1539, 1540, 1541, 1542, 1543, 1544, 1545, 1546, 1547, 1548, 1549, 1550, 1551, 1552, 1553, 1554, 1555, 1556, 1557, 1558, 1559, 1560, 1561, 1562, 1563, 1564, 1565, 1566, 1567, 1568, 1569, 1570, 1571, 1572, 1573, 1574, 1575, 1576, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1585, 1586, 1587, 1588, 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, 1600, 1601, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1609, 1610, 1611, 1612, 1613, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626, 1627, 1628, 1629, 1630, 1631, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1641, 1642, 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665, 1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1678, 1679, 1680, 1681, 1682, 1683, 1684, 1685, 1686, 1687, 1688, 1689, 1690, 1691, 1692, 1693, 1694, 1695, 1696, 1697, 1698, 1699, 1700, 1701, 1702, 1703, 1704, 1705, 1706, 1707, 1708, 1709, 1710, 1711, 1712, 1713, 1714, 1715, 1716, 1717, 1718, 1719, 1720, 1721, 1722, 1723, 1724, 1725, 1726, 1727, 1728, 1729, 1730, 1731, 1732, 1733, 1734, 1735, 1736, 1737, 1738, 1739, 1740, 1741, 1742, 1743, 1744, 1745, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1754, 1755, 1756, 1757, 1758, 1759, 1760, 1761, 1762, 1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770, 1771, 1772, 1773, 1774, 1775, 1776, 1777, 1778, 1779, 1780, 1781, 1782, 1783, 1784, 1785, 1786, 1787, 1788, 1789, 1790, 1791, 1792, 1793, 1794, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823, 1824, 1825, 1826, 1827, 1828, 1829, 1830, 1831, 1832, 1833, 1834, 1835, 1836, 1837, 1838, 1839, 1840, 1841, 1842, 1843, 1844, 1845, 1846, 1847, 1848, 1849, 1850, 1851, 1852, 1853, 1854, 1855, 1856, 1857, 1858, 1859, 1860, 1861, 1862, 1863, 1864, 1865, 1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875, 1876, 1877, 1878, 1879, 1880, 1881, 1882, 1883, 1884, 1885, 1886, 1887, 1888, 1889, 1890, 1891, 1892, 1893, 1894, 1895, 1896, 1897, 1898, 1899, 1900, 1901, 1902, 1903, 1904, 1905, 1906, 1907, 1908, 1909, 1910, 1911, 1912, 1913, 1914, 1915, 1916, 1917, 1918, 1919, 1920, 1921, 1922, 1923, 1924, 1925, 1926, 1927, 1928, 1929, 1930, 1931, 1932, 1933, 1934, 1935, 1936, 1937, 1938, 1939, 1940, 1941, 1942, 1943, 1944, 1945, 1946, 1947, 1948, 1949, 1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2062, 2063, 2064, 2065, 2066, 2067, 2068, 2069, 2070, 2071, 2072, 2073, 2074, 2075, 2076, 2077, 2078, 2079, 2080, 2081, 2082, 2083, 2084, 2085, 2086, 2087, 2088, 2089, 2090, 2091, 2092, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2121, 2122, 2123, 2124, 2125, 2126, 2127, 2128, 2129, 2130, 2131, 2132, 2133, 2134, 2135, 2136, 2137, 2138, 2139, 2140, 2141, 2142, 2143, 2144, 2145, 2146, 2147, 2148, 2149, 2150, 2151, 2152, 2153, 2154, 2155, 2156, 2157, 2158, 2159, 2160, 2161, 2162, 2163, 2164, 2165, 2166, 2167, 2168, 2169, 2170, 2171, 2172, 2173, 2174, 2175, 2176, 2177, 2178, 2179, 2180, 2181, 2182, 2183, 2184, 2185, 2186, 2187, 2188, 2189, 2190, 2191, 2192, 2193, 2194, 2195, 2196, 2197, 2198, 2199, 2200, 2201, 2202, 2203, 2204, 2205, 2206, 2207, 2208, 2209, 2210, 2211, 2212, 2213, 2214, 2215, 2216, 2217, 2218, 2219, 2220, 2221, 2222, 2223, 2224, 2225, 2226, 2227, 2228, 2229, 2230, 2231, 2232, 2233, 2234, 2235, 2236, 2237, 2238, 2239, 2240, 2241, 2242, 2243, 2244, 2245, 2246, 2247, 2248, 2249, 2250, 2251, 2252, 2253, 2254, 2255, 2256, 2257, 2258, 2259, 2260, 2261, 2262, 2263, 2264, 2265, 2266, 2267, 2268, 2269, 2270, 2271, 2272, 2273, 2274, 2275, 2276, 2277, 2278, 2279, 2280, 2281, 2282, 2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293, 2294, 2295, 2296, 2297, 2298, 2299, 2300, 2301, 2302, 2303, 2304, 2305, 2306, 2307, 2308, 2309, 2310, 2311, 2312, 2313, 2314, 2315, 2316, 2317, 2318, 2319, 2320, 2321, 2322, 2323, 2324, 2325, 2326, 2327, 2328, 2329, 2330, 2331, 2332, 2333, 2334, 2335, 2336, 2337, 2338, 2339, 2340, 2341, 2342, 2343, 2344, 2345, 2346, 2347, 2348, 2349, 2350, 2351, 2352, 2353, 2354, 2355, 2356, 2357, 2358, 2359, 2360, 2361, 2362, 2363, 2364, 2365, 2366, 2367, 2368, 2369, 2370, 2371, 2372, 2373, 2374, 2375, 2376, 2377, 2378, 2379, 2380, 2381, 2382, 2383, 2384, 2385, 2386, 2387, 2388, 2389, 2390, 2391, 2392, 2393, 2394, 2395, 2396, 2397, 2398, 2399, 2400, 2401, 2402, 2403, 2404, 2405, 2406, 2407, 2408, 2409, 2410, 2411, 2412, 2413, 2414, 2415, 2416, 2417, 2418, 2419, 2420, 2421, 2422, 2423, 2424, 2425, 2426, 2427, 2428, 2429, 2430, 2431, 2432, 2433, 2434, 2435, 2436, 2437, 2438, 2439, 2440, 2441, 2442, 2443, 2444, 2445, 2446, 2447, 2448, 2449, 2450, 2451, 2452, 2453, 2454, 2455, 2456, 2457, 2458, 2459, 2460, 2461, 2462, 2463, 2464, 2465, 2466, 2467, 2468, 2469, 2470, 2471, 2472, 2473, 2474, 2475, 2476, 2477, 2478, 2479, 2480, 2481, 2482, 2483, 2484, 2485, 2486, 2487, 2488, 2489, 2490, 2491, 2492, 2493, 2494, 2495, 2496, 2497, 2498, 2499, 2500, 2501, 2502, 2503, 2504, 2505, 2506, 2507, 2508, 2509, 2510, 2511, 2512, 2513, 2514, 2515, 2516, 2517, 2518, 2519, 2520, 2521, 2522, 2523, 2524, 2525, 2526, 2527, 2528, 2529, 2530, 2531, 2532, 2533, 2534, 2535, 2536, 2537, 2538, 2539, 2540, 2541, 2542, 2543, 2544, 2545, 2546, 2547, 2548, 2549, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2557, 2558, 2559, 2560, 2561, 2562, 2563, 2564, 2565, 2566, 2567, 2568, 2569, 2570, 2571, 2572, 2573, 2574, 2575, 2576, 2577, 2578, 2579, 2580, 2581, 2582, 2583, 2584, 2585, 2586, 2587, 2588, 2589, 2590, 2591, 2592, 2593, 2594, 2595, 2596, 2597, 2598, 2599, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2608, 2609, 2610, 2611, 2612, 2613, 2614, 2615, 2616, 2617, 2618, 2619, 2620, 2621, 2622, 2623, 2624, 2625, 2626, 2627, 2628, 2629, 2630, 2631, 2632, 2633, 2634, 2635, 2636, 2637, 2638, 2639, 2640, 2641, 2642, 2643, 2644, 2645, 2646, 2647, 2648, 2649, 2650, 2651, 2652, 2653, 2654, 2655, 2656, 2657, 2658, 2659, 2660, 2661, 2662, 2663, 2664, 2665, 2666, 2667, 2668, 2669, 2670, 2671, 2672, 2673, 2674, 2675, 2676, 2677, 2678, 2679, 2680, 2681, 2682, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2691, 2692, 2693, 2694, 2695, 2696, 2697, 2698, 2699, 2700, 2701, 2702, 2703, 2704, 2705, 2706, 2707, 2708, 2709, 2710, 2711, 2712, 2713, 2714, 2715, 2716, 2717, 2718, 2719, 2720, 2721, 2722, 2723, 2724, 2725, 2726, 2727, 2728, 2729, 2730, 2731, 2732, 2733, 2734, 2735, 2736, 2737, 2738, 2739, 2740, 2741, 2742, 2743, 2744, 2745, 2746, 2747, 2748, 2749, 2750, 2751, 2752, 2753, 2754, 2755, 2756, 2757, 2758, 2759, 2760, 2761, 2762, 2763, 2764, 2765, 2766, 2767, 2768, 2769, 2770, 2771, 2772, 2773, 2774, 2775, 2776, 2777, 2778, 2779, 2780, 2781, 2782, 2783, 2784, 2785, 2786, 2787, 2788, 2789, 2790, 2791, 2792, 2793, 2794, 2795, 2796, 2797, 2798, 2799, 2800, 2801, 2802, 2803, 2804, 2805, 2806, 2807, 2808, 2809, 2810, 2811, 2812, 2813, 2814, 2815, 2816, 2817, 2818, 2819, 2820, 2821, 2822, 2823, 2824, 2825, 2826, 2827, 2828, 2829, 2830, 2831, 2832, 2833, 2834, 2835, 2836, 2837, 2838, 2839, 2840, 2841, 2842, 2843, 2844, 2845, 2846, 2847, 2848, 2849, 2850, 2851, 2852, 2853, 2854, 2855, 2856, 2857, 2858, 2859, 2860, 2861, 2862, 2863, 2864, 2865, 2866, 2867, 2868, 2869, 2870, 2871, 2872, 2873, 2874, 2875, 2876, 2877, 2878, 2879, 2880, 2881, 2882, 2883, 2884, 2885, 2886, 2887, 2888, 2889, 2890, 2891, 2892, 2893, 2894, 2895, 2896, 2897, 2898, 2899, 2900, 2901, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2909, 2910, 2911, 2912, 2913, 2914, 2915, 2916, 2917, 2918, 2919, 2920, 2921, 2922, 2923, 2924, 2925, 2926, 2927, 2928, 2929, 2930, 2931, 2932, 2933, 2934, 2935, 2936, 2937, 2938, 2939, 2940, 2941, 2942, 2943, 2944, 2945, 2946, 2947, 2948, 2949, 2950, 2951, 2952, 2953, 2954, 2955, 2956, 2957, 2958, 2959, 2960, 2961, 2962, 2963, 2964, 2965, 2966, 2967, 2968, 2969, 2970, 2971, 2972, 2973, 2974, 2975, 2976, 2977, 2978, 2979, 2980, 2981, 2982, 2983, 2984, 2985, 2986, 2987, 2988, 2989, 2990, 2991, 2992, 2993, 2994, 2995, 2996, 2997, 2998, 2999, 3000, 3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009, 3010, 3011, 3012, 3013, 3014, 3015, 3016, 3017, 3018, 3019, 3020, 3021, 3022, 3023, 3024, 3025, 3026, 3027, 3028, 3029, 3030, 3031, 3032, 3033, 3034, 3035, 3036, 3037, 3038, 3039, 3040, 3041, 3042, 3043, 3044, 3045, 3046, 3047, 3048, 3049, 3050, 3051, 3052, 3053, 3054, 3055, 3056, 3057, 3058, 3059, 3060, 3061, 3062, 3063, 3064, 3065, 3066, 3067, 3068, 3069, 3070, 3071, 3072, 3073, 3074, 3075, 3076, 3077, 3078, 3079, 3080, 3081, 3082, 3083, 3084, 3085, 3086, 3087, 3088, 3089, 3090, 3091, 3092, 3093, 3094, 3095, 3096, 3097, 3098, 3099, 3100, 3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110, 3111, 3112, 3113, 3114, 3115, 3116, 3117, 3118, 3119, 3120, 3121, 3122, 3123, 3124, 3125, 3126, 3127, 3128, 3129, 3130, 3131, 3132, 3133, 3134, 3135, 3136, 3137, 3138, 3139, 3140, 3141, 3142, 3143, 3144, 3145, 3146, 3147, 3148, 3149, 3150, 3151, 3152, 3153, 3154, 3155, 3156, 3157, 3158, 3159, 3160, 3161, 3162, 3163, 3164, 3165, 3166, 3167, 3168, 3169, 3170, 3171, 3172, 3173, 3174, 3175, 3176, 3177, 3178, 3179, 3180, 3181, 3182, 3183, 3184, 3185, 3186, 3187, 3188, 3189, 3190, 3191, 3192, 3193, 3194, 3195, 3196, 3197, 3198, 3199, 3200, 3201, 3202, 3203, 3204, 3205, 3206, 3207, 3208, 3209, 3210, 3211, 3212, 3213, 3214, 3215, 3216, 3217, 3218, 3219, 3220, 3221, 3222, 3223, 3224, 3225, 3226, 3227, 3228, 3229, 3230, 3231, 3232, 3233, 3234, 3235, 3236, 3237, 3238, 3239, 3240, 3241, 3242, 3243, 3244, 3245, 3246, 3247, 3248, 3249, 3250, 3251, 3252, 3253, 3254, 3255, 3256, 3257, 3258, 3259, 3260, 3261, 3262, 3263, 3264, 3265, 3266, 3267, 3268, 3269, 3270, 3271, 3272, 3273, 3274, 3275, 3276, 3277, 3278, 3279, 3280, 3281, 3282, 3283, 3284, 3285, 3286, 3287, 3288, 3289, 3290, 3291, 3292, 3293, 3294, 3295, 3296, 3297, 3298, 3299, 3300, 3301, 3302, 3303, 3304, 3305, 3306, 3307, 3308, 3309, 3310, 3311, 3312, 3313, 3314, 3315, 3316, 3317, 3318, 3319, 3320, 3321, 3322, 3323, 3324, 3325, 3326, 3327, 3328, 3329, 3330, 3331, 3332, 3333, 3334, 3335, 3336, 3337, 3338, 3339, 3340, 3341, 3342, 3343, 3344, 3345, 3346, 3347, 3348, 3349, 3350, 3351, 3352, 3353, 3354, 3355, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 3365, 3366, 3367, 3368, 3369, 3370, 3371, 3372, 3373, 3374, 3375, 3376, 3377, 3378, 3379, 3380, 3381, 3382, 3383, 3384, 3385, 3386, 3387, 3388, 3389, 3390, 3391, 3392, 3393, 3394, 3395, 3396, 3397, 3398, 3399, 3400, 3401, 3402, 3403, 3404, 3405, 3406, 3407, 3408, 3409, 3410, 3411, 3412, 3413, 3414, 3415, 3416, 3417, 3418, 3419, 3420, 3421, 3422, 3423, 3424, 3425, 3426, 3427, 3428, 3429, 3430, 3431, 3432, 3433, 3434, 3435, 3436, 3437, 3438, 3439, 3440, 3441, 3442, 3443, 3444, 3445, 3446, 3447, 3448, 3449, 3450, 3451, 3452, 3453, 3454, 3455, 3456, 3457, 3458, 3459, 3460, 3461, 3462, 3463, 3464, 3465, 3466, 3467, 3468, 3469, 3470, 3471, 3472, 3473, 3474, 3475, 3476, 3477, 3478, 3479, 3480, 3481, 3482, 3483, 3484, 3485, 3486, 3487, 3488, 3489, 3490, 3491, 3492, 3493, 3494, 3495, 3496, 3497, 3498, 3499, 3500, 3501, 3502, 3503, 3504, 3505, 3506, 3507, 3508, 3509, 3510, 3511, 3512, 3513, 3514, 3515, 3516, 3517, 3518, 3519, 3520, 3521, 3522, 3523, 3524, 3525, 3526, 3527, 3528, 3529, 3530, 3531, 3532, 3533, 3534, 3535, 3536, 3537, 3538, 3539, 3540, 3541, 3542, 3543, 3544, 3545, 3546, 3547, 3548, 3549, 3550, 3551, 3552, 3553, 3554, 3555, 3556, 3557, 3558, 3559, 3560, 3561, 3562, 3563, 3564, 3565, 3566, 3567, 3568, 3569, 3570, 3571, 3572, 3573, 3574, 3575, 3576, 3577, 3578, 3579, 3580, 3581, 3582, 3583, 3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3594, 3595, 3596, 3597, 3598, 3599, 3600, 3601, 3602, 3603, 3604, 3605, 3606, 3607, 3608, 3609, 3610, 3611, 3612, 3613, 3614, 3615, 3616, 3617, 3618, 3619, 3620, 3621, 3622, 3623, 3624, 3625, 3626, 3627, 3628, 3629, 3630, 3631, 3632, 3633, 3634, 3635, 3636, 3637, 3638, 3639, 3640, 3641, 3642, 3643, 3644, 3645, 3646, 3647, 3648, 3649, 3650, 3651, 3652, 3653, 3654, 3655, 3656, 3657, 3658}
return cdramachatlist

