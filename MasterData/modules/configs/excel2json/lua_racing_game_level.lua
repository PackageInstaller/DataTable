-- chunkname: @modules/configs/excel2json/lua_racing_game_level.lua

module("modules.configs.excel2json.lua_racing_game_level", package.seeall)

local lua_racing_game_level = {}
local fields = {
	map = 6,
	name = 3,
	video = 5,
	desc = 4,
	traceId = 2,
	starCondition = 7,
	aiRacer = 8,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_racing_game_level.onLoad(json)
	lua_racing_game_level.configList, lua_racing_game_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_game_level
