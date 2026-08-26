-- chunkname: @modules/configs/excel2json/lua_activity139_const.lua

module("modules.configs.excel2json.lua_activity139_const", package.seeall)

local lua_activity139_const = {}
local fields = {
	id = 1,
	value = 3,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity139_const.onLoad(json)
	lua_activity139_const.configList, lua_activity139_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity139_const
