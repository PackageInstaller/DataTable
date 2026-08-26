-- chunkname: @modules/configs/excel2json/lua_room_water_reform.lua

module("modules.configs.excel2json.lua_room_water_reform", package.seeall)

local lua_room_water_reform = {}
local fields = {
	itemId = 3,
	blockType = 1,
	blockId = 2
}
local primaryKey = {
	"blockType"
}
local mlStringKey = {}

function lua_room_water_reform.onLoad(json)
	lua_room_water_reform.configList, lua_room_water_reform.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_water_reform
