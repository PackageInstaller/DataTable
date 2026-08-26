-- chunkname: @modules/configs/excel2json/lua_story_mode_battle_field.lua

module("modules.configs.excel2json.lua_story_mode_battle_field", package.seeall)

local lua_story_mode_battle_field = {}
local fields = {
	heroGroupTypeId = 4,
	chapterMapIds = 5,
	chapterId = 1,
	fieldId = 2,
	episodeIds = 3
}
local primaryKey = {
	"chapterId",
	"fieldId"
}
local mlStringKey = {}

function lua_story_mode_battle_field.onLoad(json)
	lua_story_mode_battle_field.configList, lua_story_mode_battle_field.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_mode_battle_field
