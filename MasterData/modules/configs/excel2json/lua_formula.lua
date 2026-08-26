-- chunkname: @modules/configs/excel2json/lua_formula.lua

module("modules.configs.excel2json.lua_formula", package.seeall)

local lua_formula = {}
local fields = {
	showType = 3,
	needEpisodeId = 13,
	needRoomLevel = 11,
	type = 2,
	needProductionLevel = 12,
	name = 4,
	produce = 8,
	desc = 17,
	costMaterial = 5,
	icon = 14,
	costReserve = 9,
	order = 10,
	costTime = 7,
	useDesc = 16,
	rare = 15,
	costScore = 6,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_formula.onLoad(json)
	lua_formula.configList, lua_formula.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_formula
