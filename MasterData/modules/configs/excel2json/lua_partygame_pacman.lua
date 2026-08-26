-- chunkname: @modules/configs/excel2json/lua_partygame_pacman.lua

module("modules.configs.excel2json.lua_partygame_pacman", package.seeall)

local lua_partygame_pacman = {}
local fields = {
	interval = 5,
	numMax = 4,
	playerNum = 2,
	effect = 6,
	id = 1,
	refreshWeight = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_pacman.onLoad(json)
	lua_partygame_pacman.configList, lua_partygame_pacman.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_pacman
