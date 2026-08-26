-- chunkname: @modules/configs/excel2json/lua_activity140_const.lua

module("modules.configs.excel2json.lua_activity140_const", package.seeall)

local lua_activity140_const = {}
local fields = {
	id = 1,
	value = 3,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity140_const.onLoad(json)
	lua_activity140_const.configList, lua_activity140_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity140_const
