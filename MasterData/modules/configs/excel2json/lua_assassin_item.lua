-- chunkname: @modules/configs/excel2json/lua_assassin_item.lua

module("modules.configs.excel2json.lua_assassin_item", package.seeall)

local lua_assassin_item = {}
local fields = {
	targetCheck = 15,
	name = 4,
	count = 6,
	roundLimit = 9,
	stealthEffDesc = 12,
	targetEff = 17,
	fightEffDesc = 11,
	unlock = 13,
	effect = 7,
	param = 8,
	itemType = 2,
	skillId = 18,
	icon = 5,
	level = 3,
	itemId = 1,
	range = 14,
	costPoint = 10,
	target = 16
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	fightEffDesc = 2,
	name = 1,
	stealthEffDesc = 3
}

function lua_assassin_item.onLoad(json)
	lua_assassin_item.configList, lua_assassin_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_item
