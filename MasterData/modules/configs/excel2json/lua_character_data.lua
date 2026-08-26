-- chunkname: @modules/configs/excel2json/lua_character_data.lua

module("modules.configs.excel2json.lua_character_data", package.seeall)

local lua_character_data = {}
local fields = {
	skinId = 3,
	lockText = 11,
	unlockConditine = 12,
	type = 4,
	isCustom = 14,
	title = 6,
	unlockRewards = 13,
	number = 5,
	text = 8,
	heroId = 1,
	titleEn = 7,
	id = 2,
	icon = 9,
	estimate = 10
}
local primaryKey = {
	"heroId",
	"id"
}
local mlStringKey = {
	text = 2,
	title = 1
}

function lua_character_data.onLoad(json)
	lua_character_data.configList, lua_character_data.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_data
