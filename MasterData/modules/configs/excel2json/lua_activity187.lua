-- chunkname: @modules/configs/excel2json/lua_activity187.lua

module("modules.configs.excel2json.lua_activity187", package.seeall)

local lua_activity187 = {}
local fields = {
	finishGameCount = 2,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"finishGameCount"
}
local mlStringKey = {}

function lua_activity187.onLoad(json)
	lua_activity187.configList, lua_activity187.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity187
