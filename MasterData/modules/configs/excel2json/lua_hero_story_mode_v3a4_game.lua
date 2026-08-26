-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_game.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_game", package.seeall)

local lua_hero_story_mode_v3a4_game = {}
local fields = {
	nodeSlot = 4,
	nodeId = 2,
	nodeName = 3,
	nodeItemId = 6,
	audioId = 7,
	nodePoint = 5,
	audioTime = 8,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"nodeId"
}
local mlStringKey = {
	nodeName = 1
}

function lua_hero_story_mode_v3a4_game.onLoad(json)
	lua_hero_story_mode_v3a4_game.configList, lua_hero_story_mode_v3a4_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a4_game
