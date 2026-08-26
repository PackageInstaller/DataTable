-- chunkname: @modules/configs/excel2json/lua_assassin_map.lua

module("modules.configs.excel2json.lua_assassin_map", package.seeall)

local lua_assassin_map = {}
local fields = {
	title = 2,
	bgCenter = 5,
	id = 1,
	bg = 4,
	unlock = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_assassin_map.onLoad(json)
	lua_assassin_map.configList, lua_assassin_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_map
