-- chunkname: @modules/configs/excel2json/lua_hero_story_introduce.lua

module("modules.configs.excel2json.lua_hero_story_introduce", package.seeall)

local lua_hero_story_introduce = {}
local fields = {
	id = 1,
	name = 2,
	desc = 4,
	resource = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_hero_story_introduce.onLoad(json)
	lua_hero_story_introduce.configList, lua_hero_story_introduce.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_introduce
