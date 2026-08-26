-- chunkname: @modules/configs/excel2json/lua_udimo.lua

module("modules.configs.excel2json.lua_udimo", package.seeall)

local lua_udimo = {}
local fields = {
	id = 1,
	name = 2,
	defaultUse = 6,
	colliderOffset = 9,
	groupId = 3,
	imgParam = 11,
	spineParam = 12,
	resource = 7,
	colliderSize = 8,
	heroId = 4,
	outlineRes = 14,
	orderLayer = 15,
	isDefault = 5,
	resourceParam = 13,
	emojiPos = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_udimo.onLoad(json)
	lua_udimo.configList, lua_udimo.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo
