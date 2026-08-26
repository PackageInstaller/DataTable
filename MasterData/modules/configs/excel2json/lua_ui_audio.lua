-- chunkname: @modules/configs/excel2json/lua_ui_audio.lua

module("modules.configs.excel2json.lua_ui_audio", package.seeall)

local lua_ui_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_ui_audio.onLoad(json)
	lua_ui_audio.configList, lua_ui_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_ui_audio
