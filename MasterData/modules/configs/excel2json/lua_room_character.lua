-- chunkname: @modules/configs/excel2json/lua_room_character.lua

module("modules.configs.excel2json.lua_room_character", package.seeall)

local lua_room_character = {}
local fields = {
	shadow = 8,
	moveSpeed = 6,
	zeroMix = 7,
	skinId = 1,
	cameraAnimPath = 9,
	specialIdle = 2,
	effectPath = 10,
	waterDistance = 11,
	specialRate = 3,
	roleVoice = 12,
	hideFootprint = 13,
	moveRate = 5,
	moveInterval = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_room_character.onLoad(json)
	lua_room_character.configList, lua_room_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character
