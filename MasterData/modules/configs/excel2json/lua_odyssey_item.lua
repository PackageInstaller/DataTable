-- chunkname: @modules/configs/excel2json/lua_odyssey_item.lua

module("modules.configs.excel2json.lua_odyssey_item", package.seeall)

local lua_odyssey_item = {}
local fields = {
	suitId = 8,
	name = 4,
	addSkill = 9,
	type = 3,
	extraSuitCount = 10,
	rare = 2,
	desc = 5,
	id = 1,
	icon = 7,
	skillDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillDesc = 3,
	desc = 2
}

function lua_odyssey_item.onLoad(json)
	lua_odyssey_item.configList, lua_odyssey_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_item
