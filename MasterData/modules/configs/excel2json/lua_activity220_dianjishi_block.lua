-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_block.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_block", package.seeall)

local lua_activity220_dianjishi_block = {}
local fields = {
	value = 5,
	mapId = 1,
	helpOrder = 7,
	type = 3,
	id = 2,
	shape = 4,
	icon = 8,
	rightPos = 6
}
local primaryKey = {
	"mapId",
	"id"
}
local mlStringKey = {}

function lua_activity220_dianjishi_block.onLoad(json)
	lua_activity220_dianjishi_block.configList, lua_activity220_dianjishi_block.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_dianjishi_block
