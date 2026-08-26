-- chunkname: @modules/configs/excel2json/lua_manufacture_building_trade_level.lua

module("modules.configs.excel2json.lua_manufacture_building_trade_level", package.seeall)

local lua_manufacture_building_trade_level = {}
local fields = {
	maxCritterCount = 3,
	tradeGroupId = 1,
	tradeLevel = 2
}
local primaryKey = {
	"tradeGroupId",
	"tradeLevel"
}
local mlStringKey = {}

function lua_manufacture_building_trade_level.onLoad(json)
	lua_manufacture_building_trade_level.configList, lua_manufacture_building_trade_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_manufacture_building_trade_level
