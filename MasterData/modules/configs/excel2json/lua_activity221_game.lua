-- chunkname: @modules/configs/excel2json/lua_activity221_game.lua

module("modules.configs.excel2json.lua_activity221_game", package.seeall)

local lua_activity221_game = {}
local fields = {
	maxBuff = 7,
	mapId = 1,
	time = 2,
	targets = 3,
	useSkill = 8,
	type7Weight = 5,
	targetDesc = 4,
	type7Num = 6
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {
	targetDesc = 1
}

function lua_activity221_game.onLoad(json)
	lua_activity221_game.configList, lua_activity221_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity221_game
