-- chunkname: @modules/configs/excel2json/lua_hero_story_dispatch_talk.lua

module("modules.configs.excel2json.lua_hero_story_dispatch_talk", package.seeall)

local lua_hero_story_dispatch_talk = {}
local fields = {
	speaker = 5,
	id = 1,
	heroid = 6,
	type = 2,
	color = 4,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	speaker = 2
}

function lua_hero_story_dispatch_talk.onLoad(json)
	lua_hero_story_dispatch_talk.configList, lua_hero_story_dispatch_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_dispatch_talk
