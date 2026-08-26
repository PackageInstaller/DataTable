-- chunkname: @modules/configs/excel2json/lua_partygame_pedalingplaid.lua

module("modules.configs.excel2json.lua_partygame_pedalingplaid", package.seeall)

local lua_partygame_pedalingplaid = {}
local fields = {
	param = 5,
	playerNum = 2,
	maxNum = 6,
	type = 3,
	id = 1,
	duration = 7,
	interval = 8,
	assetId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_pedalingplaid.onLoad(json)
	lua_partygame_pedalingplaid.configList, lua_partygame_pedalingplaid.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_pedalingplaid
