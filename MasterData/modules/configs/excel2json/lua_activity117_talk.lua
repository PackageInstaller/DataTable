-- chunkname: @modules/configs/excel2json/lua_activity117_talk.lua

module("modules.configs.excel2json.lua_activity117_talk", package.seeall)

local lua_activity117_talk = {}
local fields = {
	content2 = 4,
	content1 = 3,
	activityId = 1,
	type = 2
}
local primaryKey = {
	"activityId",
	"type"
}
local mlStringKey = {
	content2 = 2,
	content1 = 1
}

function lua_activity117_talk.onLoad(json)
	lua_activity117_talk.configList, lua_activity117_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity117_talk
