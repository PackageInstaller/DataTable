-- chunkname: @modules/configs/excel2json/lua_story_hero_to_character.lua

module("modules.configs.excel2json.lua_story_hero_to_character", package.seeall)

local lua_story_hero_to_character = {}
local fields = {
	heroIndex = 1,
	heroId = 2
}
local primaryKey = {
	"heroIndex"
}
local mlStringKey = {}

function lua_story_hero_to_character.onLoad(json)
	lua_story_hero_to_character.configList, lua_story_hero_to_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_hero_to_character
