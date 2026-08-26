-- chunkname: @modules/configs/excel2json/lua_activity188_card.lua

module("modules.configs.excel2json.lua_activity188_card", package.seeall)

local lua_activity188_card = {}
local fields = {
	cardId = 2,
	name = 5,
	skillId = 4,
	type = 3,
	resource = 7,
	activityId = 1,
	desc = 6
}
local primaryKey = {
	"activityId",
	"cardId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity188_card.onLoad(json)
	lua_activity188_card.configList, lua_activity188_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_card
