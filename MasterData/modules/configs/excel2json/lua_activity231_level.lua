-- chunkname: @modules/configs/excel2json/lua_activity231_level.lua

module("modules.configs.excel2json.lua_activity231_level", package.seeall)

local lua_activity231_level = {}
local fields = {
	exp = 3,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}

function lua_activity231_level.onLoad(json)
	lua_activity231_level.configList, lua_activity231_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_level
