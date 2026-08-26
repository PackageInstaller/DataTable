-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_refresh.lua

module("modules.configs.excel2json.lua_assassin_stealth_refresh", package.seeall)

local lua_assassin_stealth_refresh = {}
local fields = {
	id = 1,
	position1 = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_stealth_refresh.onLoad(json)
	lua_assassin_stealth_refresh.configList, lua_assassin_stealth_refresh.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_refresh
