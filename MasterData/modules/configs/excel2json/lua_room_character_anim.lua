-- chunkname: @modules/configs/excel2json/lua_room_character_anim.lua

module("modules.configs.excel2json.lua_room_character_anim", package.seeall)

local lua_room_character_anim = {}
local fields = {
	animName = 2,
	upTime = 3,
	upDuration = 4,
	downDuration = 7,
	id = 1,
	downTime = 6,
	upDistance = 5,
	cameraState = 8
}
local primaryKey = {
	"id",
	"animName"
}
local mlStringKey = {}

function lua_room_character_anim.onLoad(json)
	lua_room_character_anim.configList, lua_room_character_anim.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_anim
