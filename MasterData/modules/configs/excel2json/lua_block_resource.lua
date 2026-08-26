-- chunkname: @modules/configs/excel2json/lua_block_resource.lua

module("modules.configs.excel2json.lua_block_resource", package.seeall)

local lua_block_resource = {}
local fields = {
	itemId = 4,
	name = 2,
	occupied = 6,
	vehicleId = 10,
	path = 3,
	placeBuilding = 9,
	numLimit = 8,
	buildingFilter = 5,
	id = 1,
	blockLight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_block_resource.onLoad(json)
	lua_block_resource.configList, lua_block_resource.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_block_resource
