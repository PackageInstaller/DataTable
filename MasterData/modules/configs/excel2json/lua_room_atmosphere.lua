-- chunkname: @modules/configs/excel2json/lua_room_atmosphere.lua

module("modules.configs.excel2json.lua_room_atmosphere", package.seeall)

local lua_room_atmosphere = {}
local fields = {
	effectSequence = 3,
	openTime = 6,
	buildingId = 2,
	cdtimes = 9,
	residentEffect = 4,
	triggerType = 8,
	cyclesTimes = 5,
	id = 1,
	durationDay = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_atmosphere.onLoad(json)
	lua_room_atmosphere.configList, lua_room_atmosphere.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_atmosphere
