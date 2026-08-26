-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_fugaoren_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_fugaoren_base", package.seeall)

local lua_hero_story_mode_fugaoren_base = {}
local fields = {
	costTime = 4,
	areaId = 5,
	preId = 7,
	type = 3,
	name = 2,
	id = 1,
	storyId = 12,
	resource = 15,
	unlockAreaId = 6,
	rightChoose = 14,
	weather = 16,
	endTime = 10,
	conArea = 8,
	dialogId = 11,
	choose = 13,
	startTime = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	choose = 2,
	name = 1
}

function lua_hero_story_mode_fugaoren_base.onLoad(json)
	lua_hero_story_mode_fugaoren_base.configList, lua_hero_story_mode_fugaoren_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_fugaoren_base
