-- chunkname: @modules/configs/excel2json/lua_arcade_bomb.lua

module("modules.configs.excel2json.lua_arcade_bomb", package.seeall)

local lua_arcade_bomb = {}
local fields = {
	skillDesc = 3,
	name = 2,
	damage = 9,
	resPath = 5,
	skill = 13,
	skills = 14,
	target = 11,
	countdown = 10,
	addFloor = 12,
	icon = 15,
	alertEffectId = 6,
	effectDefault = 7,
	id = 1,
	shape = 4,
	scale = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}

function lua_arcade_bomb.onLoad(json)
	lua_arcade_bomb.configList, lua_arcade_bomb.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_bomb
