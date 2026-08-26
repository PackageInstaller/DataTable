-- chunkname: @modules/configs/excel2json/lua_activity220_igor_game.lua

module("modules.configs.excel2json.lua_activity220_igor_game", package.seeall)

local lua_activity220_igor_game = {}
local fields = {
	soldier = 4,
	gameid = 1,
	enemyId = 3,
	rules = 5,
	oursideId = 2
}
local primaryKey = {
	"gameid"
}
local mlStringKey = {}

function lua_activity220_igor_game.onLoad(json)
	lua_activity220_igor_game.configList, lua_activity220_igor_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_igor_game
