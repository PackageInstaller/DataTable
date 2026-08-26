-- chunkname: @modules/configs/excel2json/lua_rest_building.lua

module("modules.configs.excel2json.lua_rest_building", package.seeall)

local lua_rest_building = {}
local fields = {
	id = 1,
	restSlotNum = 2,
	buySlotCost = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rest_building.onLoad(json)
	lua_rest_building.configList, lua_rest_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rest_building
