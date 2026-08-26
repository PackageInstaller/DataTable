-- chunkname: @modules/configs/excel2json/lua_month_card.lua

module("modules.configs.excel2json.lua_month_card", package.seeall)

local lua_month_card = {}
local fields = {
	dailyBonus = 4,
	signingItem = 9,
	signatureDays = 8,
	days = 2,
	onceBonus = 3,
	itemSource = 7,
	id = 1,
	maxDaysLimit = 5,
	overMaxDayBonus = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_month_card.onLoad(json)
	lua_month_card.configList, lua_month_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_month_card
