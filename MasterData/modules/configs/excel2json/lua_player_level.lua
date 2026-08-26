-- chunkname: @modules/configs/excel2json/lua_player_level.lua

module("modules.configs.excel2json.lua_player_level", package.seeall)

local lua_player_level = {}
local fields = {
	addUpRecoverPower = 4,
	addBuyRecoverPower = 5,
	bonus = 6,
	exp = 2,
	maxAutoRecoverPower = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_player_level.onLoad(json)
	lua_player_level.configList, lua_player_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_player_level
