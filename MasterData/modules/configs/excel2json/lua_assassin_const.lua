-- chunkname: @modules/configs/excel2json/lua_assassin_const.lua

module("modules.configs.excel2json.lua_assassin_const", package.seeall)

local lua_assassin_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_assassin_const.onLoad(json)
	lua_assassin_const.configList, lua_assassin_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_const
