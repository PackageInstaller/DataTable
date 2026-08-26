-- chunkname: @modules/configs/excel2json/lua_activity203_game.lua

module("modules.configs.excel2json.lua_activity203_game", package.seeall)

local lua_activity203_game = {}
local fields = {
	battleGroup = 3,
	gameTarget = 4,
	battlePic = 2,
	battleTime = 7,
	loseTarget = 5,
	skill = 6,
	battledesc = 8,
	targetDesc = 9,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {}

function lua_activity203_game.onLoad(json)
	lua_activity203_game.configList, lua_activity203_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_game
