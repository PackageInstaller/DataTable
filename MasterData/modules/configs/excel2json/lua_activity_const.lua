-- chunkname: @modules/configs/excel2json/lua_activity_const.lua

module("modules.configs.excel2json.lua_activity_const", package.seeall)

local lua_activity_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity_const.onLoad(json)
	lua_activity_const.configList, lua_activity_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_const
