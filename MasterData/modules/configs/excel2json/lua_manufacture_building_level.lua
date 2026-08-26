-- chunkname: @modules/configs/excel2json/lua_manufacture_building_level.lua

module("modules.configs.excel2json.lua_manufacture_building_level", package.seeall)

local lua_manufacture_building_level = {}
local fields = {
	cost = 4,
	effect = 3,
	id = 2,
	productions = 5,
	groupId = 1,
	needTradeLevel = 6,
	slotCount = 7
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {}

function lua_manufacture_building_level.onLoad(json)
	lua_manufacture_building_level.configList, lua_manufacture_building_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_manufacture_building_level
