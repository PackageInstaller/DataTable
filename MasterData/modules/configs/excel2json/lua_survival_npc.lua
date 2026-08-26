-- chunkname: @modules/configs/excel2json/lua_survival_npc.lua

module("modules.configs.excel2json.lua_survival_npc", package.seeall)

local lua_survival_npc = {}
local fields = {
	npcDesc = 14,
	name = 2,
	waterResource = 9,
	rotate = 10,
	transferId = 21,
	choiceText = 13,
	reward = 18,
	desc = 7,
	surBehavior = 23,
	subType = 15,
	cost = 20,
	copyIds = 25,
	tag = 17,
	recruitment = 19,
	worldLevel = 24,
	smallIcon = 12,
	versions = 5,
	extendCost = 3,
	priority = 26,
	incidentalRange = 29,
	incidental = 28,
	headIcon = 11,
	rare = 16,
	resource = 8,
	roll = 27,
	renown = 30,
	behavior = 22,
	seasons = 6,
	id = 1,
	exp = 31,
	takeOut = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	npcDesc = 4,
	name = 1,
	choiceText = 3,
	desc = 2
}

function lua_survival_npc.onLoad(json)
	lua_survival_npc.configList, lua_survival_npc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_npc
