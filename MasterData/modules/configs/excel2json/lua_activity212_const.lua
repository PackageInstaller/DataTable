-- chunkname: @modules/configs/excel2json/lua_activity212_const.lua

module("modules.configs.excel2json.lua_activity212_const", package.seeall)

local lua_activity212_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity212_const.onLoad(json)
	lua_activity212_const.configList, lua_activity212_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity212_const
