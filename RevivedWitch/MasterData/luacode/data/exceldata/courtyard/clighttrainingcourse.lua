-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/courtyard/clighttrainingcourse.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local clighttrainingcourse = {}
clighttrainingcourse.Data = {
[1] = {id = 1, trainingnametxtid = 800160, trainingrarity = 1, trainingtime = 120, lightcostitem = 35014, lightcostnum = 300, trainingexpgain = 6000, appearproportion = 5}
, 
[2] = {id = 2, trainingnametxtid = 800160, trainingrarity = 1, trainingtime = 240, lightcostitem = 35014, lightcostnum = 600, trainingexpgain = 12000, appearproportion = 5}
, 
[3] = {id = 3, trainingnametxtid = 800160, trainingrarity = 1, trainingtime = 480, lightcostitem = 35014, lightcostnum = 1200, trainingexpgain = 24000, appearproportion = 5}
, 
[4] = {id = 4, trainingnametxtid = 800161, trainingrarity = 1, trainingtime = 120, lightcostitem = 35015, lightcostnum = 100, trainingexpgain = 8000, appearproportion = 5}
, 
[5] = {id = 5, trainingnametxtid = 800161, trainingrarity = 1, trainingtime = 240, lightcostitem = 35015, lightcostnum = 200, trainingexpgain = 16000, appearproportion = 5}
, 
[6] = {id = 6, trainingnametxtid = 800161, trainingrarity = 1, trainingtime = 480, lightcostitem = 35015, lightcostnum = 400, trainingexpgain = 32000, appearproportion = 5}
, 
[7] = {id = 7, trainingnametxtid = 800160, trainingrarity = 2, trainingtime = 120, lightcostitem = 35014, lightcostnum = 900, trainingexpgain = 18000, appearproportion = 5}
, 
[8] = {id = 8, trainingnametxtid = 800160, trainingrarity = 2, trainingtime = 240, lightcostitem = 35014, lightcostnum = 1800, trainingexpgain = 36000, appearproportion = 5}
, 
[9] = {id = 9, trainingnametxtid = 800160, trainingrarity = 2, trainingtime = 480, lightcostitem = 35014, lightcostnum = 3600, trainingexpgain = 72000, appearproportion = 5}
, 
[10] = {id = 10, trainingnametxtid = 800160, trainingrarity = 2, trainingtime = 600, lightcostitem = 35014, lightcostnum = 4500, trainingexpgain = 90000, appearproportion = 5}
, 
[11] = {id = 11, trainingnametxtid = 800161, trainingrarity = 2, trainingtime = 120, lightcostitem = 35015, lightcostnum = 300, trainingexpgain = 24000, appearproportion = 5}
, 
[12] = {id = 12, trainingnametxtid = 800161, trainingrarity = 2, trainingtime = 240, lightcostitem = 35015, lightcostnum = 600, trainingexpgain = 48000, appearproportion = 5}
, 
[13] = {id = 13, trainingnametxtid = 800161, trainingrarity = 2, trainingtime = 480, lightcostitem = 35015, lightcostnum = 1200, trainingexpgain = 96000, appearproportion = 5}
, 
[14] = {id = 14, trainingnametxtid = 800161, trainingrarity = 2, trainingtime = 720, lightcostitem = 35015, lightcostnum = 1800, trainingexpgain = 144000, appearproportion = 5}
, 
[15] = {id = 15, trainingnametxtid = 800160, trainingrarity = 3, trainingtime = 120, lightcostitem = 35014, lightcostnum = 1800, trainingexpgain = 36000, appearproportion = 5}
, 
[16] = {id = 16, trainingnametxtid = 800160, trainingrarity = 3, trainingtime = 240, lightcostitem = 35014, lightcostnum = 3600, trainingexpgain = 72000, appearproportion = 5}
, 
[17] = {id = 17, trainingnametxtid = 800160, trainingrarity = 3, trainingtime = 480, lightcostitem = 35014, lightcostnum = 7200, trainingexpgain = 144000, appearproportion = 5}
, 
[18] = {id = 18, trainingnametxtid = 800160, trainingrarity = 3, trainingtime = 600, lightcostitem = 35014, lightcostnum = 9000, trainingexpgain = 180000, appearproportion = 5}
, 
[19] = {id = 19, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 120, lightcostitem = 35015, lightcostnum = 600, trainingexpgain = 48000, appearproportion = 5}
, 
[20] = {id = 20, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 240, lightcostitem = 35015, lightcostnum = 1200, trainingexpgain = 96000, appearproportion = 5}
, 
[21] = {id = 21, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 480, lightcostitem = 35015, lightcostnum = 2400, trainingexpgain = 192000, appearproportion = 5}
, 
[22] = {id = 22, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 720, lightcostitem = 35015, lightcostnum = 3600, trainingexpgain = 288000, appearproportion = 5}
, 
[23] = {id = 23, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 960, lightcostitem = 35015, lightcostnum = 4800, trainingexpgain = 384000, appearproportion = 5}
, 
[24] = {id = 24, trainingnametxtid = 800161, trainingrarity = 3, trainingtime = 360, lightcostitem = 35015, lightcostnum = 1800, trainingexpgain = 144000, appearproportion = 5}
, 
[25] = {id = 25, trainingnametxtid = 800162, trainingrarity = 3, trainingtime = 120, lightcostitem = 35016, lightcostnum = 360, trainingexpgain = 50400, appearproportion = 5}
, 
[26] = {id = 26, trainingnametxtid = 800162, trainingrarity = 3, trainingtime = 240, lightcostitem = 35016, lightcostnum = 720, trainingexpgain = 100800, appearproportion = 5}
, 
[27] = {id = 27, trainingnametxtid = 800162, trainingrarity = 3, trainingtime = 480, lightcostitem = 35016, lightcostnum = 1440, trainingexpgain = 201600, appearproportion = 5}
, 
[28] = {id = 28, trainingnametxtid = 800162, trainingrarity = 3, trainingtime = 720, lightcostitem = 35016, lightcostnum = 2160, trainingexpgain = 302400, appearproportion = 5}
, 
[29] = {id = 29, trainingnametxtid = 800162, trainingrarity = 3, trainingtime = 960, lightcostitem = 35016, lightcostnum = 2880, trainingexpgain = 403200, appearproportion = 5}
, 
[30] = {id = 30, trainingnametxtid = 800162, trainingrarity = 4, trainingtime = 240, lightcostitem = 35016, lightcostnum = 1080, trainingexpgain = 151200, appearproportion = 10}
, 
[31] = {id = 31, trainingnametxtid = 800162, trainingrarity = 4, trainingtime = 480, lightcostitem = 35016, lightcostnum = 2160, trainingexpgain = 302400, appearproportion = 10}
, 
[32] = {id = 32, trainingnametxtid = 800162, trainingrarity = 4, trainingtime = 640, lightcostitem = 35016, lightcostnum = 2880, trainingexpgain = 403200, appearproportion = 10}
}
clighttrainingcourse.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32}
return clighttrainingcourse

