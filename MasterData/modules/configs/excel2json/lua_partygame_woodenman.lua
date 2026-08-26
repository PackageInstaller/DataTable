-- chunkname: @modules/configs/excel2json/lua_partygame_woodenman.lua

module("modules.configs.excel2json.lua_partygame_woodenman", package.seeall)

local lua_partygame_woodenman = {}
local fields = {
	id = 1,
	group = 2,
	scanTime = 6,
	stopTime = 5,
	prepareTime = 4,
	safeTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_woodenman.onLoad(json)
	lua_partygame_woodenman.configList, lua_partygame_woodenman.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_woodenman
