-- chunkname: @modules/configs/excel2json/lua_antique.lua

module("modules.configs.excel2json.lua_antique", package.seeall)

local lua_antique = {}
local fields = {
	sources = 10,
	name = 2,
	storyId = 11,
	nameen = 3,
	effect = 13,
	title = 7,
	desc = 9,
	titleen = 8,
	gifticon = 5,
	sign = 6,
	id = 1,
	icon = 4,
	iconArea = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 2,
	name = 1,
	desc = 3
}

function lua_antique.onLoad(json)
	lua_antique.configList, lua_antique.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_antique
