-- chunkname: @modules/configs/excel2json/lua_activity234_control.lua

module("modules.configs.excel2json.lua_activity234_control", package.seeall)

local lua_activity234_control = {}
local fields = {
	magnificationCount = 3,
	magnificationRate = 4,
	singleScoreLimit = 5,
	activityId = 1,
	times = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity234_control.onLoad(json)
	lua_activity234_control.configList, lua_activity234_control.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_control
