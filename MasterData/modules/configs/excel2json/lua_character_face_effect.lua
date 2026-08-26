-- chunkname: @modules/configs/excel2json/lua_character_face_effect.lua

module("modules.configs.excel2json.lua_character_face_effect", package.seeall)

local lua_character_face_effect = {}
local fields = {
	node = 4,
	face = 3,
	heroResName = 1,
	effectCompName = 2
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}

function lua_character_face_effect.onLoad(json)
	lua_character_face_effect.configList, lua_character_face_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_face_effect
