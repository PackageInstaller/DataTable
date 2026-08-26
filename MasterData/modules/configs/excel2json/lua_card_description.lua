-- chunkname: @modules/configs/excel2json/lua_card_description.lua

module("modules.configs.excel2json.lua_card_description", package.seeall)

local lua_card_description = {}
local fields = {
	card2 = 4,
	card1 = 2,
	cardname_en = 5,
	cardname = 6,
	id = 1,
	carddescription2 = 8,
	carddescription1 = 7,
	attribute = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	carddescription1 = 2,
	carddescription2 = 3,
	cardname = 1
}

function lua_card_description.onLoad(json)
	lua_card_description.configList, lua_card_description.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_card_description
