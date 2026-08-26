-- chunkname: @modules/configs/excel2json/lua_manufacture_item.lua

module("modules.configs.excel2json.lua_manufacture_item", package.seeall)

local lua_manufacture_item = {}
local fields = {
	itemId = 3,
	needMat = 2,
	criProductionCount = 5,
	batchName = 6,
	showInAdvancedOrder = 10,
	orderPrice = 11,
	unitCount = 9,
	batchIcon = 7,
	needTime = 8,
	id = 1,
	criProductionId = 4,
	wholesalePrice = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	batchName = 1
}

function lua_manufacture_item.onLoad(json)
	lua_manufacture_item.configList, lua_manufacture_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_manufacture_item
