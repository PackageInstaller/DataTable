-- chunkname: @modules/configs/excel2json/lua_effect_with_audio.lua

module("modules.configs.excel2json.lua_effect_with_audio", package.seeall)

local lua_effect_with_audio = {}
local fields = {
	id = 1,
	effect = 2,
	audioId = 3,
	once = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_effect_with_audio.onLoad(json)
	lua_effect_with_audio.configList, lua_effect_with_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_effect_with_audio
