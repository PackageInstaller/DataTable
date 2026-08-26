-- chunkname: @modules/configs/excel2json/lua_activity107_bubble_talk.lua

module("modules.configs.excel2json.lua_activity107_bubble_talk", package.seeall)

local lua_activity107_bubble_talk = {}
local fields = {
	groupId = 2,
	id = 1,
	condition = 3,
	weight = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity107_bubble_talk.onLoad(json)
	lua_activity107_bubble_talk.configList, lua_activity107_bubble_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity107_bubble_talk
