-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_cup.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_cup", package.seeall)

local lua_weekwalk_ver2_cup = {}
local fields = {
	fightType = 3,
	layerId = 2,
	progressDesc = 10,
	desc1 = 6,
	paramOfProgressDesc = 11,
	cupNo = 4,
	desc = 9,
	desc2 = 7,
	id = 1,
	cupTask = 5,
	desc3 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc3 = 3,
	desc2 = 2,
	progressDesc = 5,
	desc1 = 1,
	desc = 4
}

function lua_weekwalk_ver2_cup.onLoad(json)
	lua_weekwalk_ver2_cup.configList, lua_weekwalk_ver2_cup.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2_cup
