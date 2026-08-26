-- chunkname: @modules/configs/excel2json/lua_room_interact_building.lua

module("modules.configs.excel2json.lua_room_interact_building", package.seeall)

local lua_room_interact_building = {}
local fields = {
	buildingId = 1,
	heroCount = 2,
	cameraId = 8,
	heroAnimStr = 6,
	interactType = 4,
	intervalTime = 3,
	buildingAnim = 7,
	showTime = 5
}
local primaryKey = {
	"buildingId"
}
local mlStringKey = {}

function lua_room_interact_building.onLoad(json)
	lua_room_interact_building.configList, lua_room_interact_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_interact_building
