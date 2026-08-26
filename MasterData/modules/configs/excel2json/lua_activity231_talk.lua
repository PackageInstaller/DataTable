-- chunkname: @modules/configs/excel2json/lua_activity231_talk.lua

module("modules.configs.excel2json.lua_activity231_talk", package.seeall)

local lua_activity231_talk = {}
local fields = {
	weight = 4,
	trigger = 5,
	id = 1,
	content = 3,
	researcherId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_activity231_talk.onLoad(json)
	lua_activity231_talk.configList, lua_activity231_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_talk
