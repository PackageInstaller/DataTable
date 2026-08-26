-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_const.lua

module("modules.configs.excel2json.lua_assassin_stealth_const", package.seeall)

local lua_assassin_stealth_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_stealth_const.onLoad(json)
	lua_assassin_stealth_const.configList, lua_assassin_stealth_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_stealth_const
