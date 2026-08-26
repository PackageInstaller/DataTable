-- chunkname: @modules/configs/excel2json/lua_survival_shop.lua

module("modules.configs.excel2json.lua_survival_shop", package.seeall)

local lua_survival_shop = {}
local fields = {
	pos12 = 15,
	pos13 = 16,
	pos8 = 11,
	pos5 = 8,
	pos19 = 22,
	name = 2,
	pos4 = 7,
	pos14 = 17,
	type = 3,
	pos15 = 18,
	pos17 = 20,
	pos1 = 4,
	pos20 = 23,
	pos6 = 9,
	pos21 = 24,
	pos10 = 13,
	pos22 = 25,
	pos16 = 19,
	pos9 = 12,
	pos11 = 14,
	pos3 = 6,
	pos7 = 10,
	pos2 = 5,
	id = 1,
	pos18 = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_survival_shop.onLoad(json)
	lua_survival_shop.configList, lua_survival_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shop
