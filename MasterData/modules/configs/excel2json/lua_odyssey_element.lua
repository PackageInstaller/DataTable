-- chunkname: @modules/configs/excel2json/lua_odyssey_element.lua

module("modules.configs.excel2json.lua_odyssey_element", package.seeall)

local lua_odyssey_element = {}
local fields = {
	type = 4,
	iconFrame = 7,
	refreshType = 11,
	main = 8,
	needFollow = 10,
	unlockCondition = 3,
	pos = 5,
	taskDesc = 9,
	isPermanent = 12,
	mapId = 2,
	heroPos = 13,
	dataBase = 14,
	id = 1,
	icon = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDesc = 1
}

function lua_odyssey_element.onLoad(json)
	lua_odyssey_element.configList, lua_odyssey_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_element
