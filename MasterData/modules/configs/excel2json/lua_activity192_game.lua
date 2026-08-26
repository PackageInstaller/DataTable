-- chunkname: @modules/configs/excel2json/lua_activity192_game.lua

module("modules.configs.excel2json.lua_activity192_game", package.seeall)

local lua_activity192_game = {}
local fields = {
	cubeOpenAnim = 4,
	cubeSwitchAnim = 5,
	removeCount = 3,
	panelImage = 6,
	id = 1,
	scenePath = 7,
	maps = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity192_game.onLoad(json)
	lua_activity192_game.configList, lua_activity192_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity192_game
