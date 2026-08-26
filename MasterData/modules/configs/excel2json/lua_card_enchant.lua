-- chunkname: @modules/configs/excel2json/lua_card_enchant.lua

module("modules.configs.excel2json.lua_card_enchant", package.seeall)

local lua_card_enchant = {}
local fields = {
	feature = 7,
	id = 1,
	excludeTypes = 3,
	coverType = 2,
	rejectTypes = 4,
	stage = 5,
	desc = 8,
	decStage = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_card_enchant.onLoad(json)
	lua_card_enchant.configList, lua_card_enchant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_card_enchant
