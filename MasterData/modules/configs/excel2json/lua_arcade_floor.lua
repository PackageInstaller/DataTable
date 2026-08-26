-- chunkname: @modules/configs/excel2json/lua_arcade_floor.lua

module("modules.configs.excel2json.lua_arcade_floor", package.seeall)

local lua_arcade_floor = {}
local fields = {
	scale = 7,
	name = 2,
	priority = 9,
	icon = 11,
	limitRound = 12,
	desc = 3,
	posOffset = 8,
	skill = 4,
	category = 10,
	id = 1,
	shape = 6,
	resPath = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_arcade_floor.onLoad(json)
	lua_arcade_floor.configList, lua_arcade_floor.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_floor
