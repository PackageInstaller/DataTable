-- chunkname: @modules/configs/excel2json/lua_investigate_clue.lua

module("modules.configs.excel2json.lua_investigate_clue", package.seeall)

local lua_investigate_clue = {}
local fields = {
	mapRes = 5,
	relatedDesc = 9,
	infoID = 4,
	res = 6,
	mapElement = 3,
	id = 1,
	mapResLocked = 7,
	detailedDesc = 8,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detailedDesc = 1,
	relatedDesc = 2
}

function lua_investigate_clue.onLoad(json)
	lua_investigate_clue.configList, lua_investigate_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_investigate_clue
