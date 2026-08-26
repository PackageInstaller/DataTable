-- chunkname: @modules/configs/excel2json/lua_activity106_minigame.lua

module("modules.configs.excel2json.lua_activity106_minigame", package.seeall)

local lua_activity106_minigame = {}
local fields = {
	minBlock = 2,
	blockCount = 4,
	victoryRound = 5,
	randomLength = 6,
	id = 1,
	levelTime = 3,
	matPool = 8,
	pointerSpeed = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity106_minigame.onLoad(json)
	lua_activity106_minigame.configList, lua_activity106_minigame.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity106_minigame
