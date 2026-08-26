-- chunkname: @modules/configs/excel2json/lua_equip.lua

module("modules.configs.excel2json.lua_equip", package.seeall)

local lua_equip = {}
local fields = {
	isSpRefine = 11,
	name = 2,
	name_en = 3,
	skillName = 4,
	upperLimit = 17,
	desc = 13,
	isExpEquip = 10,
	strengthType = 8,
	amplify = 18,
	tag = 9,
	icon = 5,
	sources = 15,
	useDesc = 14,
	skillType = 7,
	rare = 6,
	characterId = 19,
	id = 1,
	canShowHandbook = 16,
	useSpRefine = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillName = 2,
	name = 1,
	useDesc = 4,
	desc = 3
}

function lua_equip.onLoad(json)
	lua_equip.configList, lua_equip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip
