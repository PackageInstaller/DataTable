-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cstarrymirrorcollect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstarrymirrorcollect = {}
cstarrymirrorcollect.Data = {
[101] = {id = 101, collectrequirenum = 200, collecttype = 35024, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 6001}
, 
[102] = {id = 102, collectrequirenum = 400, collecttype = 35024, 
collectbonus = {75016}
, 
collectbonusnum = {5}
, eventid = 6001}
, 
[103] = {id = 103, collectrequirenum = 600, collecttype = 35024, 
collectbonus = {75016}
, 
collectbonusnum = {5}
, eventid = 6001}
, 
[104] = {id = 104, collectrequirenum = 800, collecttype = 35024, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 6001}
, 
[105] = {id = 105, collectrequirenum = 1000, collecttype = 35024, 
collectbonus = {75017}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[106] = {id = 106, collectrequirenum = 1300, collecttype = 35024, 
collectbonus = {75017}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[107] = {id = 107, collectrequirenum = 1600, collecttype = 35024, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 6001}
, 
[108] = {id = 108, collectrequirenum = 1800, collecttype = 35024, 
collectbonus = {75017}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[109] = {id = 109, collectrequirenum = 2000, collecttype = 35024, 
collectbonus = {75017}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[110] = {id = 110, collectrequirenum = 2200, collecttype = 35024, 
collectbonus = {75017}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[111] = {id = 111, collectrequirenum = 2400, collecttype = 35024, 
collectbonus = {75019}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[112] = {id = 112, collectrequirenum = 2800, collecttype = 35024, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 6001}
, 
[113] = {id = 113, collectrequirenum = 3000, collecttype = 35024, 
collectbonus = {75019}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[114] = {id = 114, collectrequirenum = 3300, collecttype = 35024, 
collectbonus = {75019}
, 
collectbonusnum = {10}
, eventid = 6001}
, 
[115] = {id = 115, collectrequirenum = 3500, collecttype = 35024, 
collectbonus = {31102}
, 
collectbonusnum = {1}
, eventid = 6001}
, 
[116] = {id = 116, collectrequirenum = 200, collecttype = 35069, 
collectbonus = {74001}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[117] = {id = 117, collectrequirenum = 400, collecttype = 35069, 
collectbonus = {74002}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[118] = {id = 118, collectrequirenum = 600, collecttype = 35069, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 47001}
, 
[119] = {id = 119, collectrequirenum = 800, collecttype = 35069, 
collectbonus = {75018}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[120] = {id = 120, collectrequirenum = 1000, collecttype = 35069, 
collectbonus = {75019}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[121] = {id = 121, collectrequirenum = 1200, collecttype = 35069, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 47001}
, 
[122] = {id = 122, collectrequirenum = 1500, collecttype = 35069, 
collectbonus = {74004}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[123] = {id = 123, collectrequirenum = 1800, collecttype = 35069, 
collectbonus = {74005}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[124] = {id = 124, collectrequirenum = 2100, collecttype = 35069, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 47001}
, 
[125] = {id = 125, collectrequirenum = 2400, collecttype = 35069, 
collectbonus = {31386}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[126] = {id = 126, collectrequirenum = 2700, collecttype = 35069, 
collectbonus = {31389}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[127] = {id = 127, collectrequirenum = 3000, collecttype = 35069, 
collectbonus = {30076}
, 
collectbonusnum = {1}
, eventid = 47001}
, 
[128] = {id = 128, collectrequirenum = 3500, collecttype = 35069, 
collectbonus = {31383}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[129] = {id = 129, collectrequirenum = 4000, collecttype = 35069, 
collectbonus = {31380}
, 
collectbonusnum = {10}
, eventid = 47001}
, 
[130] = {id = 130, collectrequirenum = 5000, collecttype = 35069, 
collectbonus = {35068}
, 
collectbonusnum = {1}
, eventid = 47001}
}
cstarrymirrorcollect.AllIds = {101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130}
return cstarrymirrorcollect

