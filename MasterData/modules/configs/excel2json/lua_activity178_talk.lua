-- chunkname: @modules/configs/excel2json/lua_activity178_talk.lua

module("modules.configs.excel2json.lua_activity178_talk", package.seeall)

local lua_activity178_talk = {}
local fields = {
	id = 2,
	pram = 4,
	activityId = 1,
	type = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity178_talk.onLoad(json)
	lua_activity178_talk.configList, lua_activity178_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_talk
