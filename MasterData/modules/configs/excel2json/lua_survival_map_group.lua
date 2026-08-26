-- chunkname: @modules/configs/excel2json/lua_survival_map_group.lua

module("modules.configs.excel2json.lua_survival_map_group", package.seeall)

local lua_survival_map_group = {}
local fields = {
	effectDesc = 6,
	name = 3,
	useScene = 5,
	type = 2,
	disasterLayout = 9,
	initDisaster = 8,
	mapRichness = 10,
	desc = 4,
	id = 1,
	hardLevel = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 3,
	name = 1,
	desc = 2
}

function lua_survival_map_group.onLoad(json)
	lua_survival_map_group.configList, lua_survival_map_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_map_group
