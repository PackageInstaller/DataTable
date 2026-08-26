-- chunkname: @modules/configs/excel2json/lua_sodache_card.lua

module("modules.configs.excel2json.lua_sodache_card", package.seeall)

local lua_sodache_card = {}
local fields = {
	dropWeight = 9,
	name = 2,
	funcDesc = 4,
	type = 7,
	diceList = 20,
	dropPrice = 8,
	desc = 3,
	disappear = 14,
	subType = 10,
	refrain = 21,
	icon = 6,
	price = 11,
	cost = 12,
	quality = 5,
	useDesc = 18,
	additionRule = 22,
	bagSkillIds = 19,
	maxStack = 15,
	directUse = 16,
	useEffect = 17,
	id = 1,
	takeOut = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	funcDesc = 3,
	name = 1,
	useDesc = 4,
	desc = 2
}

function lua_sodache_card.onLoad(json)
	lua_sodache_card.configList, lua_sodache_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_card
