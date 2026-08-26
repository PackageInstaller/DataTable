-- chunkname: @modules/configs/excel2json/lua_activity_184_illustration.lua

module("modules.configs.excel2json.lua_activity_184_illustration", package.seeall)

local lua_activity_184_illustration = {}
local fields = {
	path = 5,
	id = 2,
	shape = 4,
	activityId = 1,
	attribute = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity_184_illustration.onLoad(json)
	lua_activity_184_illustration.configList, lua_activity_184_illustration.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_184_illustration
