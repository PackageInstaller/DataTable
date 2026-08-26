-- chunkname: @modules/configs/excel2json/lua_setting_voice.lua

module("modules.configs.excel2json.lua_setting_voice", package.seeall)

local lua_setting_voice = {}
local fields = {
	shortcuts = 1,
	tips = 2
}
local primaryKey = {
	"shortcuts"
}
local mlStringKey = {
	tips = 1
}

function lua_setting_voice.onLoad(json)
	lua_setting_voice.configList, lua_setting_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_setting_voice
