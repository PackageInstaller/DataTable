-- chunkname: @modules/configs/excel2json/lua_activity178_const.lua

module("modules.configs.excel2json.lua_activity178_const", package.seeall)

local lua_activity178_const = {}
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

function lua_activity178_const.onLoad(json)
	lua_activity178_const.configList, lua_activity178_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_const
