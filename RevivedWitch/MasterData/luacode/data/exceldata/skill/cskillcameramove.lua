-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/skill/cskillcameramove.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cskillcameramove = {}
cskillcameramove.Data = {
[6000101] = {id = 6000101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000102] = {id = 6000102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000103] = {id = 6000103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000104] = {id = 6000104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000105] = {id = 6000105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000201] = {id = 6000201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000202] = {id = 6000202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000203] = {id = 6000203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000204] = {id = 6000204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000205] = {id = 6000205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000301] = {id = 6000301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000302] = {id = 6000302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000303] = {id = 6000303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000304] = {id = 6000304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000305] = {id = 6000305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000401] = {id = 6000401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000402] = {id = 6000402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000403] = {id = 6000403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000404] = {id = 6000404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000405] = {id = 6000405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000501] = {id = 6000501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000502] = {id = 6000502, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000503] = {id = 6000503, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000504] = {id = 6000504, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000505] = {id = 6000505, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000601] = {id = 6000601, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000602] = {id = 6000602, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000603] = {id = 6000603, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000604] = {id = 6000604, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6000605] = {id = 6000605, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6001101] = {id = 6001101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6001102] = {id = 6001102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6001103] = {id = 6001103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6001104] = {id = 6001104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6001105] = {id = 6001105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6001106] = {id = 6001106, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6001107] = {id = 6001107, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002101] = {id = 6002101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002102] = {id = 6002102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002103] = {id = 6002103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002104] = {id = 6002104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002105] = {id = 6002105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002201] = {id = 6002201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002202] = {id = 6002202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002203] = {id = 6002203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002204] = {id = 6002204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002205] = {id = 6002205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6002206] = {id = 6002206, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003101] = {id = 6003101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003102] = {id = 6003102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003103] = {id = 6003103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003104] = {id = 6003104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003105] = {id = 6003105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003201] = {id = 6003201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003202] = {id = 6003202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003203] = {id = 6003203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003204] = {id = 6003204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003205] = {id = 6003205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6003301] = {id = 6003301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003302] = {id = 6003302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003303] = {id = 6003303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003304] = {id = 6003304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6003305] = {id = 6003305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 30}
, 
[6004101] = {id = 6004101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004102] = {id = 6004102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004103] = {id = 6004103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004104] = {id = 6004104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004105] = {id = 6004105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004201] = {id = 6004201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004202] = {id = 6004202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004203] = {id = 6004203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004204] = {id = 6004204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004205] = {id = 6004205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004206] = {id = 6004206, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004301] = {id = 6004301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004302] = {id = 6004302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004303] = {id = 6004303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004304] = {id = 6004304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004305] = {id = 6004305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004401] = {id = 6004401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004402] = {id = 6004402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004403] = {id = 6004403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004404] = {id = 6004404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6004405] = {id = 6004405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005101] = {id = 6005101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005102] = {id = 6005102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005103] = {id = 6005103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005104] = {id = 6005104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005105] = {id = 6005105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005201] = {id = 6005201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005202] = {id = 6005202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005203] = {id = 6005203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005204] = {id = 6005204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6005205] = {id = 6005205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006101] = {id = 6006101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006102] = {id = 6006102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006103] = {id = 6006103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006104] = {id = 6006104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006105] = {id = 6006105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006201] = {id = 6006201, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006202] = {id = 6006202, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006203] = {id = 6006203, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006204] = {id = 6006204, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6006205] = {id = 6006205, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007101] = {id = 6007101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007102] = {id = 6007102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007103] = {id = 6007103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007104] = {id = 6007104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007105] = {id = 6007105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007201] = {id = 6007201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007202] = {id = 6007202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007203] = {id = 6007203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007204] = {id = 6007204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6007205] = {id = 6007205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008101] = {id = 6008101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008102] = {id = 6008102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008103] = {id = 6008103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008104] = {id = 6008104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008105] = {id = 6008105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6008201] = {id = 6008201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6008202] = {id = 6008202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6008203] = {id = 6008203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6008204] = {id = 6008204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6008205] = {id = 6008205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6009101] = {id = 6009101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009102] = {id = 6009102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009103] = {id = 6009103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009104] = {id = 6009104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009105] = {id = 6009105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009201] = {id = 6009201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009202] = {id = 6009202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009203] = {id = 6009203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009204] = {id = 6009204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6009205] = {id = 6009205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010101] = {id = 6010101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010102] = {id = 6010102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010103] = {id = 6010103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010104] = {id = 6010104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010105] = {id = 6010105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010201] = {id = 6010201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010202] = {id = 6010202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010203] = {id = 6010203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010204] = {id = 6010204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6010205] = {id = 6010205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011101] = {id = 6011101, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6011102] = {id = 6011102, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6011103] = {id = 6011103, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6011104] = {id = 6011104, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6011105] = {id = 6011105, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6011106] = {id = 6011106, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011201] = {id = 6011201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011202] = {id = 6011202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011203] = {id = 6011203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011204] = {id = 6011204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6011205] = {id = 6011205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012101] = {id = 6012101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012102] = {id = 6012102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012103] = {id = 6012103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012104] = {id = 6012104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012105] = {id = 6012105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012201] = {id = 6012201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012202] = {id = 6012202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012203] = {id = 6012203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012204] = {id = 6012204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012205] = {id = 6012205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012301] = {id = 6012301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012302] = {id = 6012302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012303] = {id = 6012303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012304] = {id = 6012304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012305] = {id = 6012305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012401] = {id = 6012401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012402] = {id = 6012402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012403] = {id = 6012403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012404] = {id = 6012404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012405] = {id = 6012405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012501] = {id = 6012501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012502] = {id = 6012502, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012503] = {id = 6012503, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012504] = {id = 6012504, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012505] = {id = 6012505, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012601] = {id = 6012601, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012602] = {id = 6012602, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012603] = {id = 6012603, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012604] = {id = 6012604, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6012605] = {id = 6012605, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6013101] = {id = 6013101, CameraMoveType = 1, CameraMoveDelay = 16, CameraResetDelay = 36}
, 
[6013102] = {id = 6013102, CameraMoveType = 1, CameraMoveDelay = 16, CameraResetDelay = 36}
, 
[6013103] = {id = 6013103, CameraMoveType = 1, CameraMoveDelay = 16, CameraResetDelay = 36}
, 
[6013104] = {id = 6013104, CameraMoveType = 1, CameraMoveDelay = 16, CameraResetDelay = 36}
, 
[6013105] = {id = 6013105, CameraMoveType = 1, CameraMoveDelay = 16, CameraResetDelay = 36}
, 
[6013201] = {id = 6013201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6013202] = {id = 6013202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6013203] = {id = 6013203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6013204] = {id = 6013204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6013205] = {id = 6013205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6014101] = {id = 6014101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014102] = {id = 6014102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014103] = {id = 6014103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014104] = {id = 6014104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014105] = {id = 6014105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014201] = {id = 6014201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014202] = {id = 6014202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014203] = {id = 6014203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014204] = {id = 6014204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014205] = {id = 6014205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014301] = {id = 6014301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014302] = {id = 6014302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014303] = {id = 6014303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014304] = {id = 6014304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014305] = {id = 6014305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6014401] = {id = 6014401, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6014402] = {id = 6014402, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6014403] = {id = 6014403, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6014404] = {id = 6014404, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6014405] = {id = 6014405, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6015101] = {id = 6015101, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6015102] = {id = 6015102, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6015103] = {id = 6015103, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6015104] = {id = 6015104, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6015105] = {id = 6015105, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6015201] = {id = 6015201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6015202] = {id = 6015202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6015203] = {id = 6015203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6015204] = {id = 6015204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6015205] = {id = 6015205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6016101] = {id = 6016101, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 35}
, 
[6016102] = {id = 6016102, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 35}
, 
[6016103] = {id = 6016103, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 35}
, 
[6016104] = {id = 6016104, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 35}
, 
[6016105] = {id = 6016105, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 35}
, 
[6016201] = {id = 6016201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6016202] = {id = 6016202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6016203] = {id = 6016203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6016204] = {id = 6016204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6016205] = {id = 6016205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017101] = {id = 6017101, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017102] = {id = 6017102, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017103] = {id = 6017103, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017104] = {id = 6017104, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017105] = {id = 6017105, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017201] = {id = 6017201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017202] = {id = 6017202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017203] = {id = 6017203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017204] = {id = 6017204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017205] = {id = 6017205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017301] = {id = 6017301, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017302] = {id = 6017302, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017303] = {id = 6017303, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017304] = {id = 6017304, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017305] = {id = 6017305, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6017401] = {id = 6017401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017402] = {id = 6017402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017403] = {id = 6017403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017404] = {id = 6017404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6017405] = {id = 6017405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018101] = {id = 6018101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018102] = {id = 6018102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018103] = {id = 6018103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018104] = {id = 6018104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018105] = {id = 6018105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018201] = {id = 6018201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018202] = {id = 6018202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018203] = {id = 6018203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018204] = {id = 6018204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6018205] = {id = 6018205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019101] = {id = 6019101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019102] = {id = 6019102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019103] = {id = 6019103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019104] = {id = 6019104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019105] = {id = 6019105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6019201] = {id = 6019201, CameraMoveType = 1, CameraMoveDelay = 11, CameraResetDelay = 21}
, 
[6019202] = {id = 6019202, CameraMoveType = 1, CameraMoveDelay = 11, CameraResetDelay = 21}
, 
[6019203] = {id = 6019203, CameraMoveType = 1, CameraMoveDelay = 11, CameraResetDelay = 21}
, 
[6019204] = {id = 6019204, CameraMoveType = 1, CameraMoveDelay = 11, CameraResetDelay = 21}
, 
[6019205] = {id = 6019205, CameraMoveType = 1, CameraMoveDelay = 11, CameraResetDelay = 21}
, 
[6020101] = {id = 6020101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020102] = {id = 6020102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020103] = {id = 6020103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020104] = {id = 6020104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020105] = {id = 6020105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020201] = {id = 6020201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020202] = {id = 6020202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020203] = {id = 6020203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020204] = {id = 6020204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6020205] = {id = 6020205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021101] = {id = 6021101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021102] = {id = 6021102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021103] = {id = 6021103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021104] = {id = 6021104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021105] = {id = 6021105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021201] = {id = 6021201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021202] = {id = 6021202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021203] = {id = 6021203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021204] = {id = 6021204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6021205] = {id = 6021205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022101] = {id = 6022101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022102] = {id = 6022102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022103] = {id = 6022103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022104] = {id = 6022104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022105] = {id = 6022105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022201] = {id = 6022201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6022202] = {id = 6022202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6022203] = {id = 6022203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6022204] = {id = 6022204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6022205] = {id = 6022205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6022301] = {id = 6022301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022401] = {id = 6022401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022402] = {id = 6022402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022403] = {id = 6022403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022404] = {id = 6022404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6022405] = {id = 6022405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023101] = {id = 6023101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023102] = {id = 6023102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023103] = {id = 6023103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023104] = {id = 6023104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023105] = {id = 6023105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023201] = {id = 6023201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023202] = {id = 6023202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023203] = {id = 6023203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023204] = {id = 6023204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023205] = {id = 6023205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023301] = {id = 6023301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023302] = {id = 6023302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023303] = {id = 6023303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023304] = {id = 6023304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023305] = {id = 6023305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023401] = {id = 6023401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023402] = {id = 6023402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023403] = {id = 6023403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023404] = {id = 6023404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6023405] = {id = 6023405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024101] = {id = 6024101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024102] = {id = 6024102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024103] = {id = 6024103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024104] = {id = 6024104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024105] = {id = 6024105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024201] = {id = 6024201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024202] = {id = 6024202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024203] = {id = 6024203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024204] = {id = 6024204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024205] = {id = 6024205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024301] = {id = 6024301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024302] = {id = 6024302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024303] = {id = 6024303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024304] = {id = 6024304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024305] = {id = 6024305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6024401] = {id = 6024401, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6024402] = {id = 6024402, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6024403] = {id = 6024403, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6024404] = {id = 6024404, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6024405] = {id = 6024405, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 30}
, 
[6025101] = {id = 6025101, CameraMoveType = 1, CameraMoveDelay = 30, CameraResetDelay = 50}
, 
[6025102] = {id = 6025102, CameraMoveType = 1, CameraMoveDelay = 30, CameraResetDelay = 50}
, 
[6025103] = {id = 6025103, CameraMoveType = 1, CameraMoveDelay = 30, CameraResetDelay = 50}
, 
[6025104] = {id = 6025104, CameraMoveType = 1, CameraMoveDelay = 30, CameraResetDelay = 50}
, 
[6025105] = {id = 6025105, CameraMoveType = 1, CameraMoveDelay = 30, CameraResetDelay = 50}
, 
[6025201] = {id = 6025201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025202] = {id = 6025202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025203] = {id = 6025203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025204] = {id = 6025204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025205] = {id = 6025205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025301] = {id = 6025301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025302] = {id = 6025302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025303] = {id = 6025303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025304] = {id = 6025304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025305] = {id = 6025305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025401] = {id = 6025401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025402] = {id = 6025402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025403] = {id = 6025403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025404] = {id = 6025404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6025405] = {id = 6025405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026101] = {id = 6026101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026102] = {id = 6026102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026103] = {id = 6026103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026104] = {id = 6026104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026105] = {id = 6026105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026201] = {id = 6026201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026202] = {id = 6026202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026203] = {id = 6026203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026204] = {id = 6026204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6026205] = {id = 6026205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6027101] = {id = 6027101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027102] = {id = 6027102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027103] = {id = 6027103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027104] = {id = 6027104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027105] = {id = 6027105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027201] = {id = 6027201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027202] = {id = 6027202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027203] = {id = 6027203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027204] = {id = 6027204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6027205] = {id = 6027205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028101] = {id = 6028101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028102] = {id = 6028102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028103] = {id = 6028103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028104] = {id = 6028104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028105] = {id = 6028105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6028201] = {id = 6028201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6028202] = {id = 6028202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6028203] = {id = 6028203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6028204] = {id = 6028204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6028205] = {id = 6028205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029101] = {id = 6029101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029102] = {id = 6029102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029103] = {id = 6029103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029104] = {id = 6029104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029105] = {id = 6029105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029201] = {id = 6029201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029202] = {id = 6029202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029203] = {id = 6029203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029204] = {id = 6029204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6029205] = {id = 6029205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030101] = {id = 6030101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030102] = {id = 6030102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030103] = {id = 6030103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030104] = {id = 6030104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030105] = {id = 6030105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030201] = {id = 6030201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030202] = {id = 6030202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030203] = {id = 6030203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030204] = {id = 6030204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030205] = {id = 6030205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030301] = {id = 6030301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030302] = {id = 6030302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030303] = {id = 6030303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030304] = {id = 6030304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030305] = {id = 6030305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030401] = {id = 6030401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030402] = {id = 6030402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030403] = {id = 6030403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030404] = {id = 6030404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030405] = {id = 6030405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030501] = {id = 6030501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030502] = {id = 6030502, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030503] = {id = 6030503, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030504] = {id = 6030504, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030505] = {id = 6030505, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030601] = {id = 6030601, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030602] = {id = 6030602, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030603] = {id = 6030603, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030604] = {id = 6030604, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030605] = {id = 6030605, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030701] = {id = 6030701, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030702] = {id = 6030702, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030703] = {id = 6030703, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030704] = {id = 6030704, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030705] = {id = 6030705, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030801] = {id = 6030801, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030802] = {id = 6030802, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030803] = {id = 6030803, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030804] = {id = 6030804, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6030805] = {id = 6030805, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6032101] = {id = 6032101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032102] = {id = 6032102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032103] = {id = 6032103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032104] = {id = 6032104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032105] = {id = 6032105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032201] = {id = 6032201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032202] = {id = 6032202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032203] = {id = 6032203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032204] = {id = 6032204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6032205] = {id = 6032205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6033101] = {id = 6033101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033102] = {id = 6033102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033103] = {id = 6033103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033104] = {id = 6033104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033105] = {id = 6033105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033201] = {id = 6033201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033202] = {id = 6033202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033203] = {id = 6033203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033204] = {id = 6033204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6033205] = {id = 6033205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6034101] = {id = 6034101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034102] = {id = 6034102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034103] = {id = 6034103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034104] = {id = 6034104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034105] = {id = 6034105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034201] = {id = 6034201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034202] = {id = 6034202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034203] = {id = 6034203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034204] = {id = 6034204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6034205] = {id = 6034205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035101] = {id = 6035101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035102] = {id = 6035102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035103] = {id = 6035103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035104] = {id = 6035104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035105] = {id = 6035105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035201] = {id = 6035201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035202] = {id = 6035202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035203] = {id = 6035203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035204] = {id = 6035204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035205] = {id = 6035205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6035301] = {id = 6035301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035302] = {id = 6035302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035303] = {id = 6035303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035304] = {id = 6035304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035305] = {id = 6035305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035401] = {id = 6035401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035402] = {id = 6035402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035403] = {id = 6035403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035404] = {id = 6035404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6035405] = {id = 6035405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6036101] = {id = 6036101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6036102] = {id = 6036102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6036103] = {id = 6036103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6036104] = {id = 6036104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6036105] = {id = 6036105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6036201] = {id = 6036201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6036202] = {id = 6036202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6036203] = {id = 6036203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6036204] = {id = 6036204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6036205] = {id = 6036205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038101] = {id = 6038101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038102] = {id = 6038102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038103] = {id = 6038103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038104] = {id = 6038104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038105] = {id = 6038105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038201] = {id = 6038201, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038202] = {id = 6038202, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038203] = {id = 6038203, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038204] = {id = 6038204, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038205] = {id = 6038205, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038301] = {id = 6038301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038302] = {id = 6038302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038303] = {id = 6038303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038304] = {id = 6038304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038305] = {id = 6038305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038401] = {id = 6038401, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038402] = {id = 6038402, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038403] = {id = 6038403, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038404] = {id = 6038404, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038405] = {id = 6038405, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038501] = {id = 6038501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038502] = {id = 6038502, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038503] = {id = 6038503, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038504] = {id = 6038504, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038505] = {id = 6038505, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038601] = {id = 6038601, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038602] = {id = 6038602, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038603] = {id = 6038603, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038604] = {id = 6038604, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038605] = {id = 6038605, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[6038701] = {id = 6038701, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038702] = {id = 6038702, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038703] = {id = 6038703, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038704] = {id = 6038704, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038705] = {id = 6038705, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038801] = {id = 6038801, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038802] = {id = 6038802, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038803] = {id = 6038803, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038804] = {id = 6038804, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038805] = {id = 6038805, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038901] = {id = 6038901, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038902] = {id = 6038902, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038903] = {id = 6038903, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038904] = {id = 6038904, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038905] = {id = 6038905, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6038906] = {id = 6038906, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039101] = {id = 6039101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039102] = {id = 6039102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039103] = {id = 6039103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039104] = {id = 6039104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039105] = {id = 6039105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039106] = {id = 6039106, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039111] = {id = 6039111, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039112] = {id = 6039112, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039113] = {id = 6039113, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039114] = {id = 6039114, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039115] = {id = 6039115, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039201] = {id = 6039201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039202] = {id = 6039202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039203] = {id = 6039203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039204] = {id = 6039204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039205] = {id = 6039205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039301] = {id = 6039301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039302] = {id = 6039302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039303] = {id = 6039303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039304] = {id = 6039304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6039305] = {id = 6039305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6041101] = {id = 6041101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041102] = {id = 6041102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041103] = {id = 6041103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041104] = {id = 6041104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041105] = {id = 6041105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041201] = {id = 6041201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041202] = {id = 6041202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041203] = {id = 6041203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041204] = {id = 6041204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041205] = {id = 6041205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041301] = {id = 6041301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041302] = {id = 6041302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041303] = {id = 6041303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041304] = {id = 6041304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041305] = {id = 6041305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041401] = {id = 6041401, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041402] = {id = 6041402, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041403] = {id = 6041403, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041404] = {id = 6041404, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6041405] = {id = 6041405, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042101] = {id = 6042101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042102] = {id = 6042102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042103] = {id = 6042103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042104] = {id = 6042104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042105] = {id = 6042105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042201] = {id = 6042201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042202] = {id = 6042202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042203] = {id = 6042203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042204] = {id = 6042204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6042205] = {id = 6042205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043101] = {id = 6043101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043102] = {id = 6043102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043103] = {id = 6043103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043104] = {id = 6043104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043105] = {id = 6043105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6043201] = {id = 6043201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6043202] = {id = 6043202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6043203] = {id = 6043203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6043204] = {id = 6043204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6043205] = {id = 6043205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6044101] = {id = 6044101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044102] = {id = 6044102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044103] = {id = 6044103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044104] = {id = 6044104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044105] = {id = 6044105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044201] = {id = 6044201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044202] = {id = 6044202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044203] = {id = 6044203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044204] = {id = 6044204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6044205] = {id = 6044205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6045101] = {id = 6045101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045102] = {id = 6045102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045103] = {id = 6045103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045104] = {id = 6045104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045105] = {id = 6045105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045201] = {id = 6045201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045202] = {id = 6045202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045203] = {id = 6045203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045204] = {id = 6045204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6045205] = {id = 6045205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6047101] = {id = 6047101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6047102] = {id = 6047102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6047103] = {id = 6047103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6047104] = {id = 6047104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6047105] = {id = 6047105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6047201] = {id = 6047201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6047202] = {id = 6047202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6047203] = {id = 6047203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6047204] = {id = 6047204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6047205] = {id = 6047205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6048101] = {id = 6048101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048102] = {id = 6048102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048103] = {id = 6048103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048104] = {id = 6048104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048105] = {id = 6048105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048201] = {id = 6048201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048202] = {id = 6048202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048203] = {id = 6048203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048204] = {id = 6048204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6048205] = {id = 6048205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049101] = {id = 6049101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049102] = {id = 6049102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049103] = {id = 6049103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049104] = {id = 6049104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049105] = {id = 6049105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6049201] = {id = 6049201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6049202] = {id = 6049202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6049203] = {id = 6049203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6049204] = {id = 6049204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6049205] = {id = 6049205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051101] = {id = 6051101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051102] = {id = 6051102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051103] = {id = 6051103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051104] = {id = 6051104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051105] = {id = 6051105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051201] = {id = 6051201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051202] = {id = 6051202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051203] = {id = 6051203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051204] = {id = 6051204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6051205] = {id = 6051205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052101] = {id = 6052101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052102] = {id = 6052102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052103] = {id = 6052103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052104] = {id = 6052104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052105] = {id = 6052105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052201] = {id = 6052201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052202] = {id = 6052202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052203] = {id = 6052203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052204] = {id = 6052204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6052205] = {id = 6052205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053101] = {id = 6053101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053102] = {id = 6053102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053103] = {id = 6053103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053104] = {id = 6053104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053105] = {id = 6053105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6053201] = {id = 6053201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6053202] = {id = 6053202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6053203] = {id = 6053203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6053204] = {id = 6053204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6053205] = {id = 6053205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6054101] = {id = 6054101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054102] = {id = 6054102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054103] = {id = 6054103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054104] = {id = 6054104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054105] = {id = 6054105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054201] = {id = 6054201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054202] = {id = 6054202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054203] = {id = 6054203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054204] = {id = 6054204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6054205] = {id = 6054205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055101] = {id = 6055101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055102] = {id = 6055102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055103] = {id = 6055103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055104] = {id = 6055104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055105] = {id = 6055105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6055201] = {id = 6055201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055202] = {id = 6055202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055203] = {id = 6055203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055204] = {id = 6055204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055205] = {id = 6055205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055301] = {id = 6055301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055302] = {id = 6055302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055303] = {id = 6055303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055304] = {id = 6055304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055305] = {id = 6055305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055401] = {id = 6055401, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055402] = {id = 6055402, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055403] = {id = 6055403, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055404] = {id = 6055404, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6055405] = {id = 6055405, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6056101] = {id = 6056101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6056102] = {id = 6056102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6056103] = {id = 6056103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6056104] = {id = 6056104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6056105] = {id = 6056105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6056201] = {id = 6056201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6056202] = {id = 6056202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6056203] = {id = 6056203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6056204] = {id = 6056204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6056205] = {id = 6056205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6057101] = {id = 6057101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057102] = {id = 6057102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057103] = {id = 6057103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057104] = {id = 6057104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057105] = {id = 6057105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057201] = {id = 6057201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057202] = {id = 6057202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057203] = {id = 6057203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057204] = {id = 6057204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6057205] = {id = 6057205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059101] = {id = 6059101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059102] = {id = 6059102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059103] = {id = 6059103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059104] = {id = 6059104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059105] = {id = 6059105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6059201] = {id = 6059201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059202] = {id = 6059202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059203] = {id = 6059203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059204] = {id = 6059204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059205] = {id = 6059205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059301] = {id = 6059301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059302] = {id = 6059302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059303] = {id = 6059303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059304] = {id = 6059304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6059305] = {id = 6059305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6060101] = {id = 6060101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060102] = {id = 6060102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060103] = {id = 6060103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060104] = {id = 6060104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060105] = {id = 6060105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060201] = {id = 6060201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060202] = {id = 6060202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060203] = {id = 6060203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060204] = {id = 6060204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6060205] = {id = 6060205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061101] = {id = 6061101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061102] = {id = 6061102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061103] = {id = 6061103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061104] = {id = 6061104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061105] = {id = 6061105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061201] = {id = 6061201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061202] = {id = 6061202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061203] = {id = 6061203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061204] = {id = 6061204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061205] = {id = 6061205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061301] = {id = 6061301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061302] = {id = 6061302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061303] = {id = 6061303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061304] = {id = 6061304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061305] = {id = 6061305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6061401] = {id = 6061401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6061402] = {id = 6061402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063101] = {id = 6063101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063102] = {id = 6063102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063103] = {id = 6063103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063104] = {id = 6063104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063105] = {id = 6063105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063201] = {id = 6063201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063202] = {id = 6063202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063203] = {id = 6063203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063204] = {id = 6063204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063205] = {id = 6063205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063301] = {id = 6063301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063302] = {id = 6063302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063303] = {id = 6063303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063304] = {id = 6063304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6063305] = {id = 6063305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064101] = {id = 6064101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064102] = {id = 6064102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064103] = {id = 6064103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064104] = {id = 6064104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064105] = {id = 6064105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064201] = {id = 6064201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064202] = {id = 6064202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064203] = {id = 6064203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064204] = {id = 6064204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6064205] = {id = 6064205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065101] = {id = 6065101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065102] = {id = 6065102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065103] = {id = 6065103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065104] = {id = 6065104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065105] = {id = 6065105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065106] = {id = 6065106, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6065201] = {id = 6065201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6065202] = {id = 6065202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6065203] = {id = 6065203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6065204] = {id = 6065204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6065205] = {id = 6065205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6066101] = {id = 6066101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066102] = {id = 6066102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066103] = {id = 6066103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066104] = {id = 6066104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066105] = {id = 6066105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066201] = {id = 6066201, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066202] = {id = 6066202, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066203] = {id = 6066203, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066204] = {id = 6066204, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066205] = {id = 6066205, CameraMoveType = 1, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066301] = {id = 6066301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066302] = {id = 6066302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066303] = {id = 6066303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066304] = {id = 6066304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066305] = {id = 6066305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066401] = {id = 6066401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066402] = {id = 6066402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066403] = {id = 6066403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066404] = {id = 6066404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6066405] = {id = 6066405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067101] = {id = 6067101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067102] = {id = 6067102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067103] = {id = 6067103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067104] = {id = 6067104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067105] = {id = 6067105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067201] = {id = 6067201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067202] = {id = 6067202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067203] = {id = 6067203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067204] = {id = 6067204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067205] = {id = 6067205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067301] = {id = 6067301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067302] = {id = 6067302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067303] = {id = 6067303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067304] = {id = 6067304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6067305] = {id = 6067305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068101] = {id = 6068101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068102] = {id = 6068102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068103] = {id = 6068103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068104] = {id = 6068104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068105] = {id = 6068105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068201] = {id = 6068201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068202] = {id = 6068202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068203] = {id = 6068203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068204] = {id = 6068204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068205] = {id = 6068205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068501] = {id = 6068501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068502] = {id = 6068502, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068503] = {id = 6068503, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068504] = {id = 6068504, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068505] = {id = 6068505, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068601] = {id = 6068601, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068602] = {id = 6068602, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068603] = {id = 6068603, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068604] = {id = 6068604, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6068605] = {id = 6068605, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6069101] = {id = 6069101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069102] = {id = 6069102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069103] = {id = 6069103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069104] = {id = 6069104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069105] = {id = 6069105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069201] = {id = 6069201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069202] = {id = 6069202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069203] = {id = 6069203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069204] = {id = 6069204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6069205] = {id = 6069205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070101] = {id = 6070101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070102] = {id = 6070102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070103] = {id = 6070103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070104] = {id = 6070104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070105] = {id = 6070105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070201] = {id = 6070201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070202] = {id = 6070202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070203] = {id = 6070203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070204] = {id = 6070204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070205] = {id = 6070205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070301] = {id = 6070301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6070302] = {id = 6070302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6070303] = {id = 6070303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6070304] = {id = 6070304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6070305] = {id = 6070305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6070401] = {id = 6070401, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070402] = {id = 6070402, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070403] = {id = 6070403, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070404] = {id = 6070404, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6070405] = {id = 6070405, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6071101] = {id = 6071101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071102] = {id = 6071102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071103] = {id = 6071103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071104] = {id = 6071104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071105] = {id = 6071105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071201] = {id = 6071201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071202] = {id = 6071202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071203] = {id = 6071203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071204] = {id = 6071204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6071205] = {id = 6071205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072101] = {id = 6072101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072102] = {id = 6072102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072103] = {id = 6072103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072104] = {id = 6072104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072105] = {id = 6072105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072201] = {id = 6072201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072202] = {id = 6072202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072203] = {id = 6072203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072204] = {id = 6072204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072205] = {id = 6072205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072301] = {id = 6072301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072302] = {id = 6072302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072303] = {id = 6072303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072304] = {id = 6072304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6072305] = {id = 6072305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073101] = {id = 6073101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073102] = {id = 6073102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073103] = {id = 6073103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073104] = {id = 6073104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073105] = {id = 6073105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073201] = {id = 6073201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6073202] = {id = 6073202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6073203] = {id = 6073203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6073204] = {id = 6073204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6073205] = {id = 6073205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6073301] = {id = 6073301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073302] = {id = 6073302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073303] = {id = 6073303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073304] = {id = 6073304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073305] = {id = 6073305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6073401] = {id = 6073401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6074101] = {id = 6074101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074102] = {id = 6074102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074103] = {id = 6074103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074104] = {id = 6074104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074105] = {id = 6074105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074201] = {id = 6074201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074202] = {id = 6074202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074203] = {id = 6074203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074204] = {id = 6074204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6074205] = {id = 6074205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075101] = {id = 6075101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075102] = {id = 6075102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075103] = {id = 6075103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075104] = {id = 6075104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075105] = {id = 6075105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075201] = {id = 6075201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6075202] = {id = 6075202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6075203] = {id = 6075203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6075204] = {id = 6075204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6075205] = {id = 6075205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6075301] = {id = 6075301, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075302] = {id = 6075302, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075303] = {id = 6075303, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075304] = {id = 6075304, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6075305] = {id = 6075305, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6076101] = {id = 6076101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076102] = {id = 6076102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076103] = {id = 6076103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076104] = {id = 6076104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076105] = {id = 6076105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076201] = {id = 6076201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076202] = {id = 6076202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076203] = {id = 6076203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076204] = {id = 6076204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6076205] = {id = 6076205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6078101] = {id = 6078101, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6078102] = {id = 6078102, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6078103] = {id = 6078103, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6078104] = {id = 6078104, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6078105] = {id = 6078105, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6078201] = {id = 6078201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6078202] = {id = 6078202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6078203] = {id = 6078203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6078204] = {id = 6078204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6078205] = {id = 6078205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6079101] = {id = 6079101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6079102] = {id = 6079102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6079103] = {id = 6079103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6079104] = {id = 6079104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6079105] = {id = 6079105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6079201] = {id = 6079201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6079202] = {id = 6079202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6079203] = {id = 6079203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6079204] = {id = 6079204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6079205] = {id = 6079205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 20}
, 
[6080101] = {id = 6080101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080102] = {id = 6080102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080103] = {id = 6080103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080104] = {id = 6080104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080105] = {id = 6080105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080201] = {id = 6080201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080202] = {id = 6080202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080203] = {id = 6080203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080204] = {id = 6080204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6080205] = {id = 6080205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081101] = {id = 6081101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081102] = {id = 6081102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081103] = {id = 6081103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081104] = {id = 6081104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081105] = {id = 6081105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081201] = {id = 6081201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081202] = {id = 6081202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081203] = {id = 6081203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081204] = {id = 6081204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081205] = {id = 6081205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6081301] = {id = 6081301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082101] = {id = 6082101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082102] = {id = 6082102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082103] = {id = 6082103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082104] = {id = 6082104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082105] = {id = 6082105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082201] = {id = 6082201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082202] = {id = 6082202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082203] = {id = 6082203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082204] = {id = 6082204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082205] = {id = 6082205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082301] = {id = 6082301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082302] = {id = 6082302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082303] = {id = 6082303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082304] = {id = 6082304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6082305] = {id = 6082305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083101] = {id = 6083101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083102] = {id = 6083102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083103] = {id = 6083103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083104] = {id = 6083104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083105] = {id = 6083105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083201] = {id = 6083201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083202] = {id = 6083202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083203] = {id = 6083203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083204] = {id = 6083204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083205] = {id = 6083205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083301] = {id = 6083301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083302] = {id = 6083302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083303] = {id = 6083303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083304] = {id = 6083304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6083305] = {id = 6083305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084101] = {id = 6084101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084102] = {id = 6084102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084103] = {id = 6084103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084104] = {id = 6084104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084105] = {id = 6084105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084111] = {id = 6084111, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084112] = {id = 6084112, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084113] = {id = 6084113, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084201] = {id = 6084201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084202] = {id = 6084202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084203] = {id = 6084203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084204] = {id = 6084204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084205] = {id = 6084205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084211] = {id = 6084211, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084212] = {id = 6084212, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6084213] = {id = 6084213, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085101] = {id = 6085101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085102] = {id = 6085102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085103] = {id = 6085103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085104] = {id = 6085104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085105] = {id = 6085105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085111] = {id = 6085111, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085112] = {id = 6085112, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085113] = {id = 6085113, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085114] = {id = 6085114, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085115] = {id = 6085115, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085121] = {id = 6085121, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085201] = {id = 6085201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085202] = {id = 6085202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085203] = {id = 6085203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085204] = {id = 6085204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085205] = {id = 6085205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085211] = {id = 6085211, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085212] = {id = 6085212, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085213] = {id = 6085213, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085214] = {id = 6085214, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085215] = {id = 6085215, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6085221] = {id = 6085221, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086101] = {id = 6086101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086102] = {id = 6086102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086103] = {id = 6086103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086104] = {id = 6086104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086105] = {id = 6086105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086201] = {id = 6086201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086202] = {id = 6086202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086203] = {id = 6086203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086204] = {id = 6086204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6086205] = {id = 6086205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088101] = {id = 6088101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088102] = {id = 6088102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088103] = {id = 6088103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088104] = {id = 6088104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088105] = {id = 6088105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088111] = {id = 6088111, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088112] = {id = 6088112, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088113] = {id = 6088113, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088114] = {id = 6088114, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088115] = {id = 6088115, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088201] = {id = 6088201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088202] = {id = 6088202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088203] = {id = 6088203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088204] = {id = 6088204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088205] = {id = 6088205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6088211] = {id = 6088211, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6089101] = {id = 6089101, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6089102] = {id = 6089102, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6089103] = {id = 6089103, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6089104] = {id = 6089104, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6089105] = {id = 6089105, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6089201] = {id = 6089201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6089202] = {id = 6089202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6089203] = {id = 6089203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6089204] = {id = 6089204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6089205] = {id = 6089205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6090101] = {id = 6090101, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6090102] = {id = 6090102, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6090103] = {id = 6090103, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6090104] = {id = 6090104, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6090105] = {id = 6090105, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 0}
, 
[6090201] = {id = 6090201, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6090202] = {id = 6090202, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6090203] = {id = 6090203, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6090204] = {id = 6090204, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6090205] = {id = 6090205, CameraMoveType = 1, CameraMoveDelay = 10, CameraResetDelay = 0}
, 
[6091101] = {id = 6091101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091102] = {id = 6091102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091103] = {id = 6091103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091104] = {id = 6091104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091105] = {id = 6091105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091201] = {id = 6091201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091202] = {id = 6091202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091203] = {id = 6091203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091204] = {id = 6091204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091205] = {id = 6091205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091301] = {id = 6091301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091302] = {id = 6091302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091303] = {id = 6091303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091304] = {id = 6091304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6091305] = {id = 6091305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092101] = {id = 6092101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092102] = {id = 6092102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092103] = {id = 6092103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092104] = {id = 6092104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092105] = {id = 6092105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092201] = {id = 6092201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092202] = {id = 6092202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092203] = {id = 6092203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092204] = {id = 6092204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092205] = {id = 6092205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6092301] = {id = 6092301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093101] = {id = 6093101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093102] = {id = 6093102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093103] = {id = 6093103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093104] = {id = 6093104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093105] = {id = 6093105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093201] = {id = 6093201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093202] = {id = 6093202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093203] = {id = 6093203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093204] = {id = 6093204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093205] = {id = 6093205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6093206] = {id = 6093206, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6094101] = {id = 6094101, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094102] = {id = 6094102, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094103] = {id = 6094103, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094104] = {id = 6094104, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094105] = {id = 6094105, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094201] = {id = 6094201, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094202] = {id = 6094202, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094203] = {id = 6094203, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094204] = {id = 6094204, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6094205] = {id = 6094205, CameraMoveType = 1, CameraMoveDelay = 20, CameraResetDelay = 40}
, 
[6095101] = {id = 6095101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095102] = {id = 6095102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095103] = {id = 6095103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095104] = {id = 6095104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095105] = {id = 6095105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095201] = {id = 6095201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095202] = {id = 6095202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095203] = {id = 6095203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095204] = {id = 6095204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095205] = {id = 6095205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095301] = {id = 6095301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095302] = {id = 6095302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095303] = {id = 6095303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095304] = {id = 6095304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6095305] = {id = 6095305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097101] = {id = 6097101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097102] = {id = 6097102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097103] = {id = 6097103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097104] = {id = 6097104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097105] = {id = 6097105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097201] = {id = 6097201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097202] = {id = 6097202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097203] = {id = 6097203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097204] = {id = 6097204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097205] = {id = 6097205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097301] = {id = 6097301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097302] = {id = 6097302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097303] = {id = 6097303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097304] = {id = 6097304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6097305] = {id = 6097305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098101] = {id = 6098101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098102] = {id = 6098102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098103] = {id = 6098103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098104] = {id = 6098104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098105] = {id = 6098105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098201] = {id = 6098201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098202] = {id = 6098202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098203] = {id = 6098203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098204] = {id = 6098204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098205] = {id = 6098205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6098211] = {id = 6098211, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099101] = {id = 6099101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099102] = {id = 6099102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099103] = {id = 6099103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099104] = {id = 6099104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099105] = {id = 6099105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099201] = {id = 6099201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099202] = {id = 6099202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099203] = {id = 6099203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099204] = {id = 6099204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6099205] = {id = 6099205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100101] = {id = 6100101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100102] = {id = 6100102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100103] = {id = 6100103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100104] = {id = 6100104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100105] = {id = 6100105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100201] = {id = 6100201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100202] = {id = 6100202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100203] = {id = 6100203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100204] = {id = 6100204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6100205] = {id = 6100205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101101] = {id = 6101101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101102] = {id = 6101102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101103] = {id = 6101103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101104] = {id = 6101104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101105] = {id = 6101105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101201] = {id = 6101201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101202] = {id = 6101202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101203] = {id = 6101203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101204] = {id = 6101204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101205] = {id = 6101205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101301] = {id = 6101301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101302] = {id = 6101302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101303] = {id = 6101303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101304] = {id = 6101304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6101305] = {id = 6101305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102101] = {id = 6102101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102102] = {id = 6102102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102103] = {id = 6102103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102104] = {id = 6102104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102105] = {id = 6102105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102201] = {id = 6102201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102202] = {id = 6102202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102203] = {id = 6102203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102204] = {id = 6102204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102205] = {id = 6102205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102301] = {id = 6102301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102302] = {id = 6102302, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102303] = {id = 6102303, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102304] = {id = 6102304, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102305] = {id = 6102305, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102401] = {id = 6102401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102402] = {id = 6102402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102403] = {id = 6102403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102404] = {id = 6102404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6102405] = {id = 6102405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103101] = {id = 6103101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103102] = {id = 6103102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103103] = {id = 6103103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103104] = {id = 6103104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103105] = {id = 6103105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103201] = {id = 6103201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103202] = {id = 6103202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103203] = {id = 6103203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103204] = {id = 6103204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6103205] = {id = 6103205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104101] = {id = 6104101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104102] = {id = 6104102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104103] = {id = 6104103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104104] = {id = 6104104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104105] = {id = 6104105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104201] = {id = 6104201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104202] = {id = 6104202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104203] = {id = 6104203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104204] = {id = 6104204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6104205] = {id = 6104205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105101] = {id = 6105101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105102] = {id = 6105102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105103] = {id = 6105103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105104] = {id = 6105104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105105] = {id = 6105105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105201] = {id = 6105201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105202] = {id = 6105202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105203] = {id = 6105203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105204] = {id = 6105204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6105205] = {id = 6105205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106101] = {id = 6106101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106102] = {id = 6106102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106103] = {id = 6106103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106104] = {id = 6106104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106105] = {id = 6106105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106201] = {id = 6106201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106202] = {id = 6106202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106203] = {id = 6106203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106204] = {id = 6106204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6106205] = {id = 6106205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107101] = {id = 6107101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107102] = {id = 6107102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107103] = {id = 6107103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107104] = {id = 6107104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107105] = {id = 6107105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107201] = {id = 6107201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107202] = {id = 6107202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107203] = {id = 6107203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107204] = {id = 6107204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6107205] = {id = 6107205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109101] = {id = 6109101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109102] = {id = 6109102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109103] = {id = 6109103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109104] = {id = 6109104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109105] = {id = 6109105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109201] = {id = 6109201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109202] = {id = 6109202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109203] = {id = 6109203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109204] = {id = 6109204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6109205] = {id = 6109205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111101] = {id = 6111101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111102] = {id = 6111102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111103] = {id = 6111103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111104] = {id = 6111104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111105] = {id = 6111105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111201] = {id = 6111201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111202] = {id = 6111202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111203] = {id = 6111203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111204] = {id = 6111204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6111205] = {id = 6111205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112101] = {id = 6112101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112102] = {id = 6112102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112103] = {id = 6112103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112104] = {id = 6112104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112105] = {id = 6112105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112201] = {id = 6112201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112202] = {id = 6112202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112203] = {id = 6112203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112204] = {id = 6112204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6112205] = {id = 6112205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113101] = {id = 6113101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113102] = {id = 6113102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113103] = {id = 6113103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113104] = {id = 6113104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113105] = {id = 6113105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113201] = {id = 6113201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113202] = {id = 6113202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113203] = {id = 6113203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113204] = {id = 6113204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6113205] = {id = 6113205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115101] = {id = 6115101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115102] = {id = 6115102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115103] = {id = 6115103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115104] = {id = 6115104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115105] = {id = 6115105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115201] = {id = 6115201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115202] = {id = 6115202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115203] = {id = 6115203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115204] = {id = 6115204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115205] = {id = 6115205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6115211] = {id = 6115211, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116101] = {id = 6116101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116102] = {id = 6116102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116103] = {id = 6116103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116104] = {id = 6116104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116105] = {id = 6116105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116201] = {id = 6116201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116202] = {id = 6116202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116203] = {id = 6116203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116204] = {id = 6116204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6116205] = {id = 6116205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117101] = {id = 6117101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117102] = {id = 6117102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117103] = {id = 6117103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117104] = {id = 6117104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117105] = {id = 6117105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117201] = {id = 6117201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117202] = {id = 6117202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117203] = {id = 6117203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117204] = {id = 6117204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6117205] = {id = 6117205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118101] = {id = 6118101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118102] = {id = 6118102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118103] = {id = 6118103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118104] = {id = 6118104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118105] = {id = 6118105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118201] = {id = 6118201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118202] = {id = 6118202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118203] = {id = 6118203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118204] = {id = 6118204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6118205] = {id = 6118205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119101] = {id = 6119101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119102] = {id = 6119102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119103] = {id = 6119103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119104] = {id = 6119104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119105] = {id = 6119105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119201] = {id = 6119201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119202] = {id = 6119202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119203] = {id = 6119203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119204] = {id = 6119204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6119205] = {id = 6119205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120101] = {id = 6120101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120102] = {id = 6120102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120103] = {id = 6120103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120104] = {id = 6120104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120105] = {id = 6120105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120201] = {id = 6120201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120202] = {id = 6120202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120203] = {id = 6120203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120204] = {id = 6120204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6120205] = {id = 6120205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121101] = {id = 6121101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121102] = {id = 6121102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121103] = {id = 6121103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121104] = {id = 6121104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121105] = {id = 6121105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121201] = {id = 6121201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121202] = {id = 6121202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121203] = {id = 6121203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121204] = {id = 6121204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6121205] = {id = 6121205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122101] = {id = 6122101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122102] = {id = 6122102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122103] = {id = 6122103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122104] = {id = 6122104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122105] = {id = 6122105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122201] = {id = 6122201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122202] = {id = 6122202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122203] = {id = 6122203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122204] = {id = 6122204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6122205] = {id = 6122205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123101] = {id = 6123101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123102] = {id = 6123102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123103] = {id = 6123103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123104] = {id = 6123104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123105] = {id = 6123105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123201] = {id = 6123201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123202] = {id = 6123202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123203] = {id = 6123203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123204] = {id = 6123204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6123205] = {id = 6123205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124101] = {id = 6124101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124102] = {id = 6124102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124103] = {id = 6124103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124104] = {id = 6124104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124105] = {id = 6124105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124201] = {id = 6124201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124202] = {id = 6124202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124203] = {id = 6124203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124204] = {id = 6124204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6124205] = {id = 6124205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126101] = {id = 6126101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126102] = {id = 6126102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126103] = {id = 6126103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126104] = {id = 6126104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126105] = {id = 6126105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126201] = {id = 6126201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126202] = {id = 6126202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126203] = {id = 6126203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126204] = {id = 6126204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6126205] = {id = 6126205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130101] = {id = 6130101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130102] = {id = 6130102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130103] = {id = 6130103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130104] = {id = 6130104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130105] = {id = 6130105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130201] = {id = 6130201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130202] = {id = 6130202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130203] = {id = 6130203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130204] = {id = 6130204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[6130205] = {id = 6130205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108101] = {id = 60108101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108102] = {id = 60108102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108103] = {id = 60108103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108104] = {id = 60108104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108105] = {id = 60108105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108201] = {id = 60108201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108202] = {id = 60108202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108203] = {id = 60108203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108204] = {id = 60108204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60108205] = {id = 60108205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110101] = {id = 60110101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110102] = {id = 60110102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110103] = {id = 60110103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110104] = {id = 60110104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110105] = {id = 60110105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110201] = {id = 60110201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110202] = {id = 60110202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110203] = {id = 60110203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110204] = {id = 60110204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60110205] = {id = 60110205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381001] = {id = 60381001, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381002] = {id = 60381002, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381003] = {id = 60381003, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381004] = {id = 60381004, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381005] = {id = 60381005, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381101] = {id = 60381101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381102] = {id = 60381102, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381103] = {id = 60381103, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381104] = {id = 60381104, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381105] = {id = 60381105, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381201] = {id = 60381201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381202] = {id = 60381202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381203] = {id = 60381203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381204] = {id = 60381204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381205] = {id = 60381205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60381301] = {id = 60381301, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[60381302] = {id = 60381302, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[60381303] = {id = 60381303, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[60381304] = {id = 60381304, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[60381305] = {id = 60381305, CameraMoveType = 1, CameraMoveDelay = 15, CameraResetDelay = 25}
, 
[60712201] = {id = 60712201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60712202] = {id = 60712202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60712203] = {id = 60712203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60712204] = {id = 60712204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60712205] = {id = 60712205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60811201] = {id = 60811201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60811202] = {id = 60811202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60811203] = {id = 60811203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60811204] = {id = 60811204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60811205] = {id = 60811205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812201] = {id = 60812201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812202] = {id = 60812202, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812203] = {id = 60812203, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812204] = {id = 60812204, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812205] = {id = 60812205, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812401] = {id = 60812401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812402] = {id = 60812402, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812403] = {id = 60812403, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812404] = {id = 60812404, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[60812405] = {id = 60812405, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081011] = {id = 601081011, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081012] = {id = 601081012, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081013] = {id = 601081013, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081014] = {id = 601081014, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081015] = {id = 601081015, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601081016] = {id = 601081016, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102011] = {id = 601102011, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102021] = {id = 601102021, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102022] = {id = 601102022, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102023] = {id = 601102023, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102024] = {id = 601102024, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[601102025] = {id = 601102025, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608910101] = {id = 608910101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608910201] = {id = 608910201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608910301] = {id = 608910301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608910401] = {id = 608910401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608910501] = {id = 608910501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608920101] = {id = 608920101, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608920201] = {id = 608920201, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608920301] = {id = 608920301, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608920401] = {id = 608920401, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
, 
[608920501] = {id = 608920501, CameraMoveType = 0, CameraMoveDelay = 0, CameraResetDelay = 0}
}
cskillcameramove.AllIds = {6000101, 6000102, 6000103, 6000104, 6000105, 6000201, 6000202, 6000203, 6000204, 6000205, 6000301, 6000302, 6000303, 6000304, 6000305, 6000401, 6000402, 6000403, 6000404, 6000405, 6000501, 6000502, 6000503, 6000504, 6000505, 6000601, 6000602, 6000603, 6000604, 6000605, 6001101, 6001102, 6001103, 6001104, 6001105, 6001106, 6001107, 6002101, 6002102, 6002103, 6002104, 6002105, 6002201, 6002202, 6002203, 6002204, 6002205, 6002206, 6003101, 6003102, 6003103, 6003104, 6003105, 6003201, 6003202, 6003203, 6003204, 6003205, 6003301, 6003302, 6003303, 6003304, 6003305, 6004101, 6004102, 6004103, 6004104, 6004105, 6004201, 6004202, 6004203, 6004204, 6004205, 6004206, 6004301, 6004302, 6004303, 6004304, 6004305, 6004401, 6004402, 6004403, 6004404, 6004405, 6005101, 6005102, 6005103, 6005104, 6005105, 6005201, 6005202, 6005203, 6005204, 6005205, 6006101, 6006102, 6006103, 6006104, 6006105, 6006201, 6006202, 6006203, 6006204, 6006205, 6007101, 6007102, 6007103, 6007104, 6007105, 6007201, 6007202, 6007203, 6007204, 6007205, 6008101, 6008102, 6008103, 6008104, 6008105, 6008201, 6008202, 6008203, 6008204, 6008205, 6009101, 6009102, 6009103, 6009104, 6009105, 6009201, 6009202, 6009203, 6009204, 6009205, 6010101, 6010102, 6010103, 6010104, 6010105, 6010201, 6010202, 6010203, 6010204, 6010205, 6011101, 6011102, 6011103, 6011104, 6011105, 6011106, 6011201, 6011202, 6011203, 6011204, 6011205, 6012101, 6012102, 6012103, 6012104, 6012105, 6012201, 6012202, 6012203, 6012204, 6012205, 6012301, 6012302, 6012303, 6012304, 6012305, 6012401, 6012402, 6012403, 6012404, 6012405, 6012501, 6012502, 6012503, 6012504, 6012505, 6012601, 6012602, 6012603, 6012604, 6012605, 6013101, 6013102, 6013103, 6013104, 6013105, 6013201, 6013202, 6013203, 6013204, 6013205, 6014101, 6014102, 6014103, 6014104, 6014105, 6014201, 6014202, 6014203, 6014204, 6014205, 6014301, 6014302, 6014303, 6014304, 6014305, 6014401, 6014402, 6014403, 6014404, 6014405, 6015101, 6015102, 6015103, 6015104, 6015105, 6015201, 6015202, 6015203, 6015204, 6015205, 6016101, 6016102, 6016103, 6016104, 6016105, 6016201, 6016202, 6016203, 6016204, 6016205, 6017101, 6017102, 6017103, 6017104, 6017105, 6017201, 6017202, 6017203, 6017204, 6017205, 6017301, 6017302, 6017303, 6017304, 6017305, 6017401, 6017402, 6017403, 6017404, 6017405, 6018101, 6018102, 6018103, 6018104, 6018105, 6018201, 6018202, 6018203, 6018204, 6018205, 6019101, 6019102, 6019103, 6019104, 6019105, 6019201, 6019202, 6019203, 6019204, 6019205, 6020101, 6020102, 6020103, 6020104, 6020105, 6020201, 6020202, 6020203, 6020204, 6020205, 6021101, 6021102, 6021103, 6021104, 6021105, 6021201, 6021202, 6021203, 6021204, 6021205, 6022101, 6022102, 6022103, 6022104, 6022105, 6022201, 6022202, 6022203, 6022204, 6022205, 6022301, 6022401, 6022402, 6022403, 6022404, 6022405, 6023101, 6023102, 6023103, 6023104, 6023105, 6023201, 6023202, 6023203, 6023204, 6023205, 6023301, 6023302, 6023303, 6023304, 6023305, 6023401, 6023402, 6023403, 6023404, 6023405, 6024101, 6024102, 6024103, 6024104, 6024105, 6024201, 6024202, 6024203, 6024204, 6024205, 6024301, 6024302, 6024303, 6024304, 6024305, 6024401, 6024402, 6024403, 6024404, 6024405, 6025101, 6025102, 6025103, 6025104, 6025105, 6025201, 6025202, 6025203, 6025204, 6025205, 6025301, 6025302, 6025303, 6025304, 6025305, 6025401, 6025402, 6025403, 6025404, 6025405, 6026101, 6026102, 6026103, 6026104, 6026105, 6026201, 6026202, 6026203, 6026204, 6026205, 6027101, 6027102, 6027103, 6027104, 6027105, 6027201, 6027202, 6027203, 6027204, 6027205, 6028101, 6028102, 6028103, 6028104, 6028105, 6028201, 6028202, 6028203, 6028204, 6028205, 6029101, 6029102, 6029103, 6029104, 6029105, 6029201, 6029202, 6029203, 6029204, 6029205, 6030101, 6030102, 6030103, 6030104, 6030105, 6030201, 6030202, 6030203, 6030204, 6030205, 6030301, 6030302, 6030303, 6030304, 6030305, 6030401, 6030402, 6030403, 6030404, 6030405, 6030501, 6030502, 6030503, 6030504, 6030505, 6030601, 6030602, 6030603, 6030604, 6030605, 6030701, 6030702, 6030703, 6030704, 6030705, 6030801, 6030802, 6030803, 6030804, 6030805, 6032101, 6032102, 6032103, 6032104, 6032105, 6032201, 6032202, 6032203, 6032204, 6032205, 6033101, 6033102, 6033103, 6033104, 6033105, 6033201, 6033202, 6033203, 6033204, 6033205, 6034101, 6034102, 6034103, 6034104, 6034105, 6034201, 6034202, 6034203, 6034204, 6034205, 6035101, 6035102, 6035103, 6035104, 6035105, 6035201, 6035202, 6035203, 6035204, 6035205, 6035301, 6035302, 6035303, 6035304, 6035305, 6035401, 6035402, 6035403, 6035404, 6035405, 6036101, 6036102, 6036103, 6036104, 6036105, 6036201, 6036202, 6036203, 6036204, 6036205, 6038101, 6038102, 6038103, 6038104, 6038105, 6038201, 6038202, 6038203, 6038204, 6038205, 6038301, 6038302, 6038303, 6038304, 6038305, 6038401, 6038402, 6038403, 6038404, 6038405, 6038501, 6038502, 6038503, 6038504, 6038505, 6038601, 6038602, 6038603, 6038604, 6038605, 6038701, 6038702, 6038703, 6038704, 6038705, 6038801, 6038802, 6038803, 6038804, 6038805, 6038901, 6038902, 6038903, 6038904, 6038905, 6038906, 6039101, 6039102, 6039103, 6039104, 6039105, 6039106, 6039111, 6039112, 6039113, 6039114, 6039115, 6039201, 6039202, 6039203, 6039204, 6039205, 6039301, 6039302, 6039303, 6039304, 6039305, 6041101, 6041102, 6041103, 6041104, 6041105, 6041201, 6041202, 6041203, 6041204, 6041205, 6041301, 6041302, 6041303, 6041304, 6041305, 6041401, 6041402, 6041403, 6041404, 6041405, 6042101, 6042102, 6042103, 6042104, 6042105, 6042201, 6042202, 6042203, 6042204, 6042205, 6043101, 6043102, 6043103, 6043104, 6043105, 6043201, 6043202, 6043203, 6043204, 6043205, 6044101, 6044102, 6044103, 6044104, 6044105, 6044201, 6044202, 6044203, 6044204, 6044205, 6045101, 6045102, 6045103, 6045104, 6045105, 6045201, 6045202, 6045203, 6045204, 6045205, 6047101, 6047102, 6047103, 6047104, 6047105, 6047201, 6047202, 6047203, 6047204, 6047205, 6048101, 6048102, 6048103, 6048104, 6048105, 6048201, 6048202, 6048203, 6048204, 6048205, 6049101, 6049102, 6049103, 6049104, 6049105, 6049201, 6049202, 6049203, 6049204, 6049205, 6051101, 6051102, 6051103, 6051104, 6051105, 6051201, 6051202, 6051203, 6051204, 6051205, 6052101, 6052102, 6052103, 6052104, 6052105, 6052201, 6052202, 6052203, 6052204, 6052205, 6053101, 6053102, 6053103, 6053104, 6053105, 6053201, 6053202, 6053203, 6053204, 6053205, 6054101, 6054102, 6054103, 6054104, 6054105, 6054201, 6054202, 6054203, 6054204, 6054205, 6055101, 6055102, 6055103, 6055104, 6055105, 6055201, 6055202, 6055203, 6055204, 6055205, 6055301, 6055302, 6055303, 6055304, 6055305, 6055401, 6055402, 6055403, 6055404, 6055405, 6056101, 6056102, 6056103, 6056104, 6056105, 6056201, 6056202, 6056203, 6056204, 6056205, 6057101, 6057102, 6057103, 6057104, 6057105, 6057201, 6057202, 6057203, 6057204, 6057205, 6059101, 6059102, 6059103, 6059104, 6059105, 6059201, 6059202, 6059203, 6059204, 6059205, 6059301, 6059302, 6059303, 6059304, 6059305, 6060101, 6060102, 6060103, 6060104, 6060105, 6060201, 6060202, 6060203, 6060204, 6060205, 6061101, 6061102, 6061103, 6061104, 6061105, 6061201, 6061202, 6061203, 6061204, 6061205, 6061301, 6061302, 6061303, 6061304, 6061305, 6061401, 6061402, 6063101, 6063102, 6063103, 6063104, 6063105, 6063201, 6063202, 6063203, 6063204, 6063205, 6063301, 6063302, 6063303, 6063304, 6063305, 6064101, 6064102, 6064103, 6064104, 6064105, 6064201, 6064202, 6064203, 6064204, 6064205, 6065101, 6065102, 6065103, 6065104, 6065105, 6065106, 6065201, 6065202, 6065203, 6065204, 6065205, 6066101, 6066102, 6066103, 6066104, 6066105, 6066201, 6066202, 6066203, 6066204, 6066205, 6066301, 6066302, 6066303, 6066304, 6066305, 6066401, 6066402, 6066403, 6066404, 6066405, 6067101, 6067102, 6067103, 6067104, 6067105, 6067201, 6067202, 6067203, 6067204, 6067205, 6067301, 6067302, 6067303, 6067304, 6067305, 6068101, 6068102, 6068103, 6068104, 6068105, 6068201, 6068202, 6068203, 6068204, 6068205, 6068501, 6068502, 6068503, 6068504, 6068505, 6068601, 6068602, 6068603, 6068604, 6068605, 6069101, 6069102, 6069103, 6069104, 6069105, 6069201, 6069202, 6069203, 6069204, 6069205, 6070101, 6070102, 6070103, 6070104, 6070105, 6070201, 6070202, 6070203, 6070204, 6070205, 6070301, 6070302, 6070303, 6070304, 6070305, 6070401, 6070402, 6070403, 6070404, 6070405, 6071101, 6071102, 6071103, 6071104, 6071105, 6071201, 6071202, 6071203, 6071204, 6071205, 6072101, 6072102, 6072103, 6072104, 6072105, 6072201, 6072202, 6072203, 6072204, 6072205, 6072301, 6072302, 6072303, 6072304, 6072305, 6073101, 6073102, 6073103, 6073104, 6073105, 6073201, 6073202, 6073203, 6073204, 6073205, 6073301, 6073302, 6073303, 6073304, 6073305, 6073401, 6074101, 6074102, 6074103, 6074104, 6074105, 6074201, 6074202, 6074203, 6074204, 6074205, 6075101, 6075102, 6075103, 6075104, 6075105, 6075201, 6075202, 6075203, 6075204, 6075205, 6075301, 6075302, 6075303, 6075304, 6075305, 6076101, 6076102, 6076103, 6076104, 6076105, 6076201, 6076202, 6076203, 6076204, 6076205, 6078101, 6078102, 6078103, 6078104, 6078105, 6078201, 6078202, 6078203, 6078204, 6078205, 6079101, 6079102, 6079103, 6079104, 6079105, 6079201, 6079202, 6079203, 6079204, 6079205, 6080101, 6080102, 6080103, 6080104, 6080105, 6080201, 6080202, 6080203, 6080204, 6080205, 6081101, 6081102, 6081103, 6081104, 6081105, 6081201, 6081202, 6081203, 6081204, 6081205, 6081301, 6082101, 6082102, 6082103, 6082104, 6082105, 6082201, 6082202, 6082203, 6082204, 6082205, 6082301, 6082302, 6082303, 6082304, 6082305, 6083101, 6083102, 6083103, 6083104, 6083105, 6083201, 6083202, 6083203, 6083204, 6083205, 6083301, 6083302, 6083303, 6083304, 6083305, 6084101, 6084102, 6084103, 6084104, 6084105, 6084111, 6084112, 6084113, 6084201, 6084202, 6084203, 6084204, 6084205, 6084211, 6084212, 6084213, 6085101, 6085102, 6085103, 6085104, 6085105, 6085111, 6085112, 6085113, 6085114, 6085115, 6085121, 6085201, 6085202, 6085203, 6085204, 6085205, 6085211, 6085212, 6085213, 6085214, 6085215, 6085221, 6086101, 6086102, 6086103, 6086104, 6086105, 6086201, 6086202, 6086203, 6086204, 6086205, 6088101, 6088102, 6088103, 6088104, 6088105, 6088111, 6088112, 6088113, 6088114, 6088115, 6088201, 6088202, 6088203, 6088204, 6088205, 6088211, 6089101, 6089102, 6089103, 6089104, 6089105, 6089201, 6089202, 6089203, 6089204, 6089205, 6090101, 6090102, 6090103, 6090104, 6090105, 6090201, 6090202, 6090203, 6090204, 6090205, 6091101, 6091102, 6091103, 6091104, 6091105, 6091201, 6091202, 6091203, 6091204, 6091205, 6091301, 6091302, 6091303, 6091304, 6091305, 6092101, 6092102, 6092103, 6092104, 6092105, 6092201, 6092202, 6092203, 6092204, 6092205, 6092301, 6093101, 6093102, 6093103, 6093104, 6093105, 6093201, 6093202, 6093203, 6093204, 6093205, 6093206, 6094101, 6094102, 6094103, 6094104, 6094105, 6094201, 6094202, 6094203, 6094204, 6094205, 6095101, 6095102, 6095103, 6095104, 6095105, 6095201, 6095202, 6095203, 6095204, 6095205, 6095301, 6095302, 6095303, 6095304, 6095305, 6097101, 6097102, 6097103, 6097104, 6097105, 6097201, 6097202, 6097203, 6097204, 6097205, 6097301, 6097302, 6097303, 6097304, 6097305, 6098101, 6098102, 6098103, 6098104, 6098105, 6098201, 6098202, 6098203, 6098204, 6098205, 6098211, 6099101, 6099102, 6099103, 6099104, 6099105, 6099201, 6099202, 6099203, 6099204, 6099205, 6100101, 6100102, 6100103, 6100104, 6100105, 6100201, 6100202, 6100203, 6100204, 6100205, 6101101, 6101102, 6101103, 6101104, 6101105, 6101201, 6101202, 6101203, 6101204, 6101205, 6101301, 6101302, 6101303, 6101304, 6101305, 6102101, 6102102, 6102103, 6102104, 6102105, 6102201, 6102202, 6102203, 6102204, 6102205, 6102301, 6102302, 6102303, 6102304, 6102305, 6102401, 6102402, 6102403, 6102404, 6102405, 6103101, 6103102, 6103103, 6103104, 6103105, 6103201, 6103202, 6103203, 6103204, 6103205, 6104101, 6104102, 6104103, 6104104, 6104105, 6104201, 6104202, 6104203, 6104204, 6104205, 6105101, 6105102, 6105103, 6105104, 6105105, 6105201, 6105202, 6105203, 6105204, 6105205, 6106101, 6106102, 6106103, 6106104, 6106105, 6106201, 6106202, 6106203, 6106204, 6106205, 6107101, 6107102, 6107103, 6107104, 6107105, 6107201, 6107202, 6107203, 6107204, 6107205, 6109101, 6109102, 6109103, 6109104, 6109105, 6109201, 6109202, 6109203, 6109204, 6109205, 6111101, 6111102, 6111103, 6111104, 6111105, 6111201, 6111202, 6111203, 6111204, 6111205, 6112101, 6112102, 6112103, 6112104, 6112105, 6112201, 6112202, 6112203, 6112204, 6112205, 6113101, 6113102, 6113103, 6113104, 6113105, 6113201, 6113202, 6113203, 6113204, 6113205, 6115101, 6115102, 6115103, 6115104, 6115105, 6115201, 6115202, 6115203, 6115204, 6115205, 6115211, 6116101, 6116102, 6116103, 6116104, 6116105, 6116201, 6116202, 6116203, 6116204, 6116205, 6117101, 6117102, 6117103, 6117104, 6117105, 6117201, 6117202, 6117203, 6117204, 6117205, 6118101, 6118102, 6118103, 6118104, 6118105, 6118201, 6118202, 6118203, 6118204, 6118205, 6119101, 6119102, 6119103, 6119104, 6119105, 6119201, 6119202, 6119203, 6119204, 6119205, 6120101, 6120102, 6120103, 6120104, 6120105, 6120201, 6120202, 6120203, 6120204, 6120205, 6121101, 6121102, 6121103, 6121104, 6121105, 6121201, 6121202, 6121203, 6121204, 6121205, 6122101, 6122102, 6122103, 6122104, 6122105, 6122201, 6122202, 6122203, 6122204, 6122205, 6123101, 6123102, 6123103, 6123104, 6123105, 6123201, 6123202, 6123203, 6123204, 6123205, 6124101, 6124102, 6124103, 6124104, 6124105, 6124201, 6124202, 6124203, 6124204, 6124205, 6126101, 6126102, 6126103, 6126104, 6126105, 6126201, 6126202, 6126203, 6126204, 6126205, 6130101, 6130102, 6130103, 6130104, 6130105, 6130201, 6130202, 6130203, 6130204, 6130205, 60108101, 60108102, 60108103, 60108104, 60108105, 60108201, 60108202, 60108203, 60108204, 60108205, 60110101, 60110102, 60110103, 60110104, 60110105, 60110201, 60110202, 60110203, 60110204, 60110205, 60381001, 60381002, 60381003, 60381004, 60381005, 60381101, 60381102, 60381103, 60381104, 60381105, 60381201, 60381202, 60381203, 60381204, 60381205, 60381301, 60381302, 60381303, 60381304, 60381305, 60712201, 60712202, 60712203, 60712204, 60712205, 60811201, 60811202, 60811203, 60811204, 60811205, 60812201, 60812202, 60812203, 60812204, 60812205, 60812401, 60812402, 60812403, 60812404, 60812405, 601081011, 601081012, 601081013, 601081014, 601081015, 601081016, 601102011, 601102021, 601102022, 601102023, 601102024, 601102025, 608910101, 608910201, 608910301, 608910401, 608910501, 608920101, 608920201, 608920301, 608920401, 608920501}
return cskillcameramove

