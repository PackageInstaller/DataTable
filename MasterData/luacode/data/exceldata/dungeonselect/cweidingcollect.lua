-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cweidingcollect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cweidingcollect = {}
cweidingcollect.Data = {
[1] = {id = 1, collectrequirenum = 0, 
collectbonus = {31037}
, 
collectbonusnum = {2}
, closeTime = "2021-09-30 03:59:59"}
, 
[2] = {id = 2, collectrequirenum = 500, 
collectbonus = {35026}
, 
collectbonusnum = {50}
, closeTime = "2021-09-30 03:59:59"}
, 
[3] = {id = 3, collectrequirenum = 1000, 
collectbonus = {35002}
, 
collectbonusnum = {500000}
, closeTime = "2021-09-30 03:59:59"}
, 
[4] = {id = 4, collectrequirenum = 1500, 
collectbonus = {35026}
, 
collectbonusnum = {50}
, closeTime = "2021-09-30 03:59:59"}
, 
[5] = {id = 5, collectrequirenum = 2000, 
collectbonus = {79001}
, 
collectbonusnum = {40}
, closeTime = "2021-09-30 03:59:59"}
, 
[6] = {id = 6, collectrequirenum = 2500, 
collectbonus = {35026}
, 
collectbonusnum = {50}
, closeTime = "2021-09-30 03:59:59"}
, 
[7] = {id = 7, collectrequirenum = 3000, 
collectbonus = {79001}
, 
collectbonusnum = {40}
, closeTime = "2021-09-30 03:59:59"}
, 
[8] = {id = 8, collectrequirenum = 3500, 
collectbonus = {35026}
, 
collectbonusnum = {50}
, closeTime = "2021-09-30 03:59:59"}
, 
[9] = {id = 9, collectrequirenum = 4000, 
collectbonus = {70003}
, 
collectbonusnum = {2}
, closeTime = "2021-09-30 03:59:59"}
, 
[10] = {id = 10, collectrequirenum = 4500, 
collectbonus = {35026}
, 
collectbonusnum = {80}
, closeTime = "2021-09-30 03:59:59"}
, 
[11] = {id = 11, collectrequirenum = 5000, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, closeTime = "2021-09-30 03:59:59"}
, 
[12] = {id = 12, collectrequirenum = 6000, 
collectbonus = {35026}
, 
collectbonusnum = {80}
, closeTime = "2021-09-30 03:59:59"}
, 
[13] = {id = 13, collectrequirenum = 7000, 
collectbonus = {79002}
, 
collectbonusnum = {20}
, closeTime = "2021-09-30 03:59:59"}
, 
[14] = {id = 14, collectrequirenum = 8000, 
collectbonus = {35026}
, 
collectbonusnum = {80}
, closeTime = "2021-09-30 03:59:59"}
, 
[15] = {id = 15, collectrequirenum = 9000, 
collectbonus = {74004}
, 
collectbonusnum = {20}
, closeTime = "2021-09-30 03:59:59"}
, 
[16] = {id = 16, collectrequirenum = 10000, 
collectbonus = {35026}
, 
collectbonusnum = {80}
, closeTime = "2021-09-30 03:59:59"}
, 
[17] = {id = 17, collectrequirenum = 11000, 
collectbonus = {74005}
, 
collectbonusnum = {20}
, closeTime = "2021-09-30 03:59:59"}
, 
[18] = {id = 18, collectrequirenum = 12000, 
collectbonus = {35026}
, 
collectbonusnum = {120}
, closeTime = "2021-09-30 03:59:59"}
, 
[19] = {id = 19, collectrequirenum = 13000, 
collectbonus = {74002}
, 
collectbonusnum = {40}
, closeTime = "2021-09-30 03:59:59"}
, 
[20] = {id = 20, collectrequirenum = 14000, 
collectbonus = {35026}
, 
collectbonusnum = {120}
, closeTime = "2021-09-30 03:59:59"}
, 
[21] = {id = 21, collectrequirenum = 15000, 
collectbonus = {30076}
, 
collectbonusnum = {2}
, closeTime = "2021-09-30 03:59:59"}
, 
[22] = {id = 22, collectrequirenum = 16000, 
collectbonus = {35026}
, 
collectbonusnum = {120}
, closeTime = "2021-09-30 03:59:59"}
, 
[23] = {id = 23, collectrequirenum = 17000, 
collectbonus = {79002}
, 
collectbonusnum = {20}
, closeTime = "2021-09-30 03:59:59"}
, 
[24] = {id = 24, collectrequirenum = 18000, 
collectbonus = {35026}
, 
collectbonusnum = {120}
, closeTime = "2021-09-30 03:59:59"}
, 
[25] = {id = 25, collectrequirenum = 19000, 
collectbonus = {79001}
, 
collectbonusnum = {60}
, closeTime = "2021-09-30 03:59:59"}
, 
[26] = {id = 26, collectrequirenum = 20000, 
collectbonus = {79002}
, 
collectbonusnum = {30}
, closeTime = "2021-09-30 03:59:59"}
, 
[27] = {id = 27, collectrequirenum = 23000, 
collectbonus = {79001}
, 
collectbonusnum = {60}
, closeTime = "2021-09-30 03:59:59"}
, 
[28] = {id = 28, collectrequirenum = 26000, 
collectbonus = {79002}
, 
collectbonusnum = {30}
, closeTime = "2021-09-30 03:59:59"}
, 
[29] = {id = 29, collectrequirenum = 29000, 
collectbonus = {79001}
, 
collectbonusnum = {60}
, closeTime = "2021-09-30 03:59:59"}
, 
[30] = {id = 30, collectrequirenum = 32000, 
collectbonus = {79002}
, 
collectbonusnum = {30}
, closeTime = "2021-09-30 03:59:59"}
, 
[31] = {id = 31, collectrequirenum = 35000, 
collectbonus = {31152}
, 
collectbonusnum = {1}
, closeTime = "2021-09-30 03:59:59"}
}
cweidingcollect.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
return cweidingcollect

