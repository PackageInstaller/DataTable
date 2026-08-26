-- chunkname: @modules/configs/excel2json/lua_arcade_talk.lua

module("modules.configs.excel2json.lua_arcade_talk", package.seeall)

local lua_arcade_talk = {}
local fields = {
	param = 4,
	groupId = 2,
	weight = 5,
	id = 1,
	condition = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}

function lua_arcade_talk.onLoad(json)
	lua_arcade_talk.configList, lua_arcade_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_talk
