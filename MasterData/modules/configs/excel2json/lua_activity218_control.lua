-- chunkname: @modules/configs/excel2json/lua_activity218_control.lua

module("modules.configs.excel2json.lua_activity218_control", package.seeall)

local lua_activity218_control = {}
local fields = {
	drawPoint = 4,
	losePoint = 5,
	winPoint = 3,
	activityId = 1,
	times = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity218_control.onLoad(json)
	lua_activity218_control.configList, lua_activity218_control.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity218_control
