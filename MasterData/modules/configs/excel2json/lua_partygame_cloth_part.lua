-- chunkname: @modules/configs/excel2json/lua_partygame_cloth_part.lua

module("modules.configs.excel2json.lua_partygame_cloth_part", package.seeall)

local lua_partygame_cloth_part = {}
local fields = {
	partRes = 6,
	name = 2,
	partId = 5,
	activityId = 8,
	suitId = 3,
	image = 7,
	rare = 4,
	clothId = 1
}
local primaryKey = {
	"clothId"
}
local mlStringKey = {}

function lua_partygame_cloth_part.onLoad(json)
	lua_partygame_cloth_part.configList, lua_partygame_cloth_part.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_cloth_part
