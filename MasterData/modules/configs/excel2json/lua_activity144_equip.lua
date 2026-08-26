-- chunkname: @modules/configs/excel2json/lua_activity144_equip.lua

module("modules.configs.excel2json.lua_activity144_equip", package.seeall)

local lua_activity144_equip = {}
local fields = {
	cost = 4,
	name = 8,
	buffId = 6,
	preEquipId = 3,
	typeId = 7,
	equipId = 2,
	effectDesc = 9,
	activityId = 1,
	level = 5
}
local primaryKey = {
	"activityId",
	"equipId"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1
}

function lua_activity144_equip.onLoad(json)
	lua_activity144_equip.configList, lua_activity144_equip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_equip
