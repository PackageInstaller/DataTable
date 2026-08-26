-- chunkname: @modules/configs/excel2json/lua_atomic_talent.lua

module("modules.configs.excel2json.lua_atomic_talent", package.seeall)

local lua_atomic_talent = {}
local fields = {
	cost = 10,
	name = 4,
	effect = 9,
	mark = 11,
	descType = 12,
	pic = 7,
	desc = 6,
	preNodes = 8,
	point = 3,
	id = 1,
	icon = 5,
	skillDesc = 13,
	branchId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillDesc = 3,
	desc = 2
}

function lua_atomic_talent.onLoad(json)
	lua_atomic_talent.configList, lua_atomic_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_talent
