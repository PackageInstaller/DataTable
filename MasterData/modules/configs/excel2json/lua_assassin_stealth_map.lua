-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map.lua

module("modules.configs.excel2json.lua_assassin_stealth_map", package.seeall)

local lua_assassin_stealth_map = {}
local fields = {
	mission = 4,
	player = 5,
	id = 1,
	title = 2,
	forbidScaleGuide = 6,
	born = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_assassin_stealth_map.onLoad(json)
	lua_assassin_stealth_map.configList, lua_assassin_stealth_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_map
