-- chunkname: @modules/configs/excel2json/lua_effect_audio.lua

module("modules.configs.excel2json.lua_effect_audio", package.seeall)

local lua_effect_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_effect_audio.onLoad(json)
	lua_effect_audio.configList, lua_effect_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_effect_audio
