-- chunkname: @modules/configs/excel2json/lua_room_character_interaction_effect.lua

module("modules.configs.excel2json.lua_room_character_interaction_effect", package.seeall)

local lua_room_character_interaction_effect = {}
local fields = {
	animName = 5,
	point = 3,
	skinId = 1,
	id = 2,
	effectRes = 4
}
local primaryKey = {
	"skinId",
	"id"
}
local mlStringKey = {}

function lua_room_character_interaction_effect.onLoad(json)
	lua_room_character_interaction_effect.configList, lua_room_character_interaction_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_interaction_effect
