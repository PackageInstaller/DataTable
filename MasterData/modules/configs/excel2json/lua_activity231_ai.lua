-- chunkname: @modules/configs/excel2json/lua_activity231_ai.lua

module("modules.configs.excel2json.lua_activity231_ai", package.seeall)

local lua_activity231_ai = {}
local fields = {
	name2 = 4,
	name1 = 3,
	id = 2,
	activityId = 1,
	name3 = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name3 = 3,
	name2 = 2,
	name1 = 1
}

function lua_activity231_ai.onLoad(json)
	lua_activity231_ai.configList, lua_activity231_ai.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_ai
