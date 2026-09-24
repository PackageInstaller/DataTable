-- chunkname: @modules/configs/excel2json/lua_activity246_card.lua

module("modules.configs.excel2json.lua_activity246_card", package.seeall)

local lua_activity246_card = {}
local fields = {
	reward = 4,
	cardId = 1,
	row = 2,
	finalReward = 5,
	column = 3
}
local primaryKey = {
	"cardId"
}
local mlStringKey = {}

function lua_activity246_card.onLoad(json)
	lua_activity246_card.configList, lua_activity246_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity246_card
