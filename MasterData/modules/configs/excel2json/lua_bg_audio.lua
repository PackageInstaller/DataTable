-- chunkname: @modules/configs/excel2json/lua_bg_audio.lua

module("modules.configs.excel2json.lua_bg_audio", package.seeall)

local lua_bg_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_bg_audio.onLoad(json)
	lua_bg_audio.configList, lua_bg_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bg_audio
