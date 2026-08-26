-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_game.lua

module("modules.configs.excel2json.lua_activity220_hedone_game", package.seeall)

local lua_activity220_hedone_game = {}
local fields = {
	playerBaseAttr = 4,
	levelWaves = 5,
	winDesc = 3,
	monsterGrowPerSecond = 6,
	targetTime = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	winDesc = 1
}

function lua_activity220_hedone_game.onLoad(json)
	lua_activity220_hedone_game.configList, lua_activity220_hedone_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_game
