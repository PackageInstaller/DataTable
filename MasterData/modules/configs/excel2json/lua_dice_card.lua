-- chunkname: @modules/configs/excel2json/lua_dice_card.lua

module("modules.configs.excel2json.lua_dice_card", package.seeall)

local lua_dice_card = {}
local fields = {
	effect1 = 6,
	bufflist = 16,
	name = 2,
	type = 5,
	effect3 = 12,
	aim1 = 8,
	aim3 = 14,
	desc = 3,
	allRoundLimitCount = 18,
	params2 = 10,
	roundLimitCount = 17,
	effect2 = 9,
	patternlist = 15,
	quality = 4,
	spiritskilltype = 19,
	aim2 = 11,
	powerExtendRule = 20,
	params3 = 13,
	id = 1,
	params1 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_dice_card.onLoad(json)
	lua_dice_card.configList, lua_dice_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_card
