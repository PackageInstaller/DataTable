-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cweidingsort.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cweidingsort = {}
cweidingsort.Data = {
[6349] = {id = 6349, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6350] = {id = 6350, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6351] = {id = 6351, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6352] = {id = 6352, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6353] = {id = 6353, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6354] = {id = 6354, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6355] = {id = 6355, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6356] = {id = 6356, sort = 8, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6357] = {id = 6357, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6358] = {id = 6358, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6359] = {id = 6359, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6360] = {id = 6360, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6361] = {id = 6361, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6362] = {id = 6362, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6363] = {id = 6363, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6365] = {id = 6365, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6366] = {id = 6366, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6367] = {id = 6367, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6368] = {id = 6368, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6369] = {id = 6369, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6370] = {id = 6370, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6371] = {id = 6371, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6373] = {id = 6373, sort = 1, photoid = 13558, bossshapeid = 20177, bosspos = "42,-279", bossscale = "0.7", nameTextID = 1901199}
, 
[6374] = {id = 6374, sort = 2, photoid = 13556, bossshapeid = 20176, bosspos = "0,-390", bossscale = "0.7", nameTextID = 1901200}
, 
[6375] = {id = 6375, sort = 3, photoid = 13557, bossshapeid = 20178, bosspos = "42,-279", bossscale = "0.7", nameTextID = 1901201}
, 
[6376] = {id = 6376, sort = 4, photoid = 13555, bossshapeid = 20175, bosspos = "42,-279", bossscale = "0.6", nameTextID = 1901202}
, 
[6377] = {id = 6377, sort = 5, photoid = 13556, bossshapeid = 20176, bosspos = "0,-390", bossscale = "0.7", nameTextID = 1901200}
, 
[6378] = {id = 6378, sort = 6, photoid = 13557, bossshapeid = 20178, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901201}
, 
[6379] = {id = 6379, sort = 7, photoid = 13555, bossshapeid = 20175, bosspos = "42,-279", bossscale = "0.6", nameTextID = 1901202}
, 
[6381] = {id = 6381, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6382] = {id = 6382, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6383] = {id = 6383, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6384] = {id = 6384, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6385] = {id = 6385, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6386] = {id = 6386, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6387] = {id = 6387, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6389] = {id = 6389, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6390] = {id = 6390, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6391] = {id = 6391, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6392] = {id = 6392, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6393] = {id = 6393, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6394] = {id = 6394, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6395] = {id = 6395, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6397] = {id = 6397, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6398] = {id = 6398, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6399] = {id = 6399, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6400] = {id = 6400, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6401] = {id = 6401, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6402] = {id = 6402, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6403] = {id = 6403, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6406] = {id = 6406, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6407] = {id = 6407, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6408] = {id = 6408, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6409] = {id = 6409, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6410] = {id = 6410, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6411] = {id = 6411, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6412] = {id = 6412, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6414] = {id = 6414, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6415] = {id = 6415, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6416] = {id = 6416, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6417] = {id = 6417, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6418] = {id = 6418, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6419] = {id = 6419, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6420] = {id = 6420, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6422] = {id = 6422, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6423] = {id = 6423, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6424] = {id = 6424, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6425] = {id = 6425, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6426] = {id = 6426, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6427] = {id = 6427, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6428] = {id = 6428, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6430] = {id = 6430, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6431] = {id = 6431, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6432] = {id = 6432, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6433] = {id = 6433, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6434] = {id = 6434, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6435] = {id = 6435, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6436] = {id = 6436, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6438] = {id = 6438, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6439] = {id = 6439, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6440] = {id = 6440, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6441] = {id = 6441, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6442] = {id = 6442, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6443] = {id = 6443, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6444] = {id = 6444, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6446] = {id = 6446, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6447] = {id = 6447, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6448] = {id = 6448, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6449] = {id = 6449, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6450] = {id = 6450, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6451] = {id = 6451, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6452] = {id = 6452, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6454] = {id = 6454, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6455] = {id = 6455, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6456] = {id = 6456, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6457] = {id = 6457, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6458] = {id = 6458, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6459] = {id = 6459, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6460] = {id = 6460, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6462] = {id = 6462, sort = 1, photoid = 13420, bossshapeid = 20016, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901186}
, 
[6463] = {id = 6463, sort = 2, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6464] = {id = 6464, sort = 3, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6465] = {id = 6465, sort = 4, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6466] = {id = 6466, sort = 5, photoid = 13421, bossshapeid = 20059, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901187}
, 
[6467] = {id = 6467, sort = 6, photoid = 13422, bossshapeid = 20042, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901188}
, 
[6468] = {id = 6468, sort = 7, photoid = 13423, bossshapeid = 20046, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901189}
, 
[6469] = {id = 6469, sort = 1, photoid = 13245, bossshapeid = 20153, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901021}
, 
[6470] = {id = 6470, sort = 2, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6471] = {id = 6471, sort = 3, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6472] = {id = 6472, sort = 4, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
, 
[6473] = {id = 6473, sort = 5, photoid = 13246, bossshapeid = 20032, bosspos = "0,-163", bossscale = "0.9", nameTextID = 1901022}
, 
[6474] = {id = 6474, sort = 6, photoid = 13244, bossshapeid = 20072, bosspos = "42,-202", bossscale = "0.7", nameTextID = 1901023}
, 
[6475] = {id = 6475, sort = 7, photoid = 13247, bossshapeid = 20117, bosspos = "55,-173", bossscale = "0.6", nameTextID = 1901024}
}
cweidingsort.AllIds = {6349, 6350, 6351, 6352, 6353, 6354, 6355, 6356, 6357, 6358, 6359, 6360, 6361, 6362, 6363, 6365, 6366, 6367, 6368, 6369, 6370, 6371, 6373, 6374, 6375, 6376, 6377, 6378, 6379, 6381, 6382, 6383, 6384, 6385, 6386, 6387, 6389, 6390, 6391, 6392, 6393, 6394, 6395, 6397, 6398, 6399, 6400, 6401, 6402, 6403, 6406, 6407, 6408, 6409, 6410, 6411, 6412, 6414, 6415, 6416, 6417, 6418, 6419, 6420, 6422, 6423, 6424, 6425, 6426, 6427, 6428, 6430, 6431, 6432, 6433, 6434, 6435, 6436, 6438, 6439, 6440, 6441, 6442, 6443, 6444, 6446, 6447, 6448, 6449, 6450, 6451, 6452, 6454, 6455, 6456, 6457, 6458, 6459, 6460, 6462, 6463, 6464, 6465, 6466, 6467, 6468, 6469, 6470, 6471, 6472, 6473, 6474, 6475}
return cweidingsort

