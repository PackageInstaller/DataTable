-- chunkname: @modules/configs/excel2json/lua_month_card_added.lua

module("modules.configs.excel2json.lua_month_card_added", package.seeall)

local lua_month_card_added = {}
local fields = {
	overMaxDayBonus = 6,
	signingItem = 9,
	signatureDays = 8,
	days = 4,
	limit = 5,
	onceBonus = 3,
	itemSource = 7,
	id = 1,
	month_id = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_month_card_added.onLoad(json)
	lua_month_card_added.configList, lua_month_card_added.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_month_card_added
