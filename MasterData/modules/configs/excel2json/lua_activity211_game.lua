-- chunkname: @modules/configs/excel2json/lua_activity211_game.lua

module("modules.configs.excel2json.lua_activity211_game", package.seeall)

local lua_activity211_game = {}
local fields = {
	desc = 5,
	shadowBg = 4,
	groupId = 1,
	targetDesc = 3,
	gameId = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {
	targetDesc = 1,
	desc = 2
}

function lua_activity211_game.onLoad(json)
	lua_activity211_game.configList, lua_activity211_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity211_game
