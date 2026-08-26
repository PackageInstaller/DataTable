-- chunkname: @modules/configs/excel2json/lua_manufacture_building.lua

module("modules.configs.excel2json.lua_manufacture_building", package.seeall)

local lua_manufacture_building = {}
local fields = {
	tradeGroupId = 6,
	placeTradeLevel = 2,
	id = 1,
	buildIcon = 8,
	taskIcon = 9,
	upgradeGroupId = 5,
	cameraIds = 7,
	placeCost = 4,
	placeNoCost = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_manufacture_building.onLoad(json)
	lua_manufacture_building.configList, lua_manufacture_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_manufacture_building
