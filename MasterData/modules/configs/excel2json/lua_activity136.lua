-- chunkname: @modules/configs/excel2json/lua_activity136.lua

module("modules.configs.excel2json.lua_activity136", package.seeall)

local lua_activity136 = {}
local fields = {
	activityId = 1,
	heroIds = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity136.onLoad(json)
	lua_activity136.configList, lua_activity136.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity136
