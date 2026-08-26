-- chunkname: @modules/configs/excel2json/lua_playercard_const.lua

module("modules.configs.excel2json.lua_playercard_const", package.seeall)

local lua_playercard_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_playercard_const.onLoad(json)
	lua_playercard_const.configList, lua_playercard_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_playercard_const
