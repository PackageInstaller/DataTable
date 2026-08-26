-- chunkname: @modules/configs/excel2json/lua_rogue_shop.lua

module("modules.configs.excel2json.lua_rogue_shop", package.seeall)

local lua_rogue_shop = {}
local fields = {
	desc = 2,
	pos13 = 15,
	pos12 = 14,
	pos5 = 7,
	pos1 = 3,
	pos8 = 10,
	pos4 = 6,
	pos14 = 16,
	pos15 = 17,
	pos6 = 8,
	pos10 = 12,
	pos16 = 18,
	pos9 = 11,
	pos11 = 13,
	pos3 = 5,
	pos7 = 9,
	pos2 = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rogue_shop.onLoad(json)
	lua_rogue_shop.configList, lua_rogue_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_shop
