-- chunkname: @modules/configs/excel2json/lua_setting_lang.lua

module("modules.configs.excel2json.lua_setting_lang", package.seeall)

local lua_setting_lang = {}
local fields = {
	fontasset2 = 4,
	lang = 2,
	textfontasset1 = 5,
	textfontasset2 = 6,
	shortcuts = 1,
	fontasset1 = 3
}
local primaryKey = {
	"shortcuts"
}
local mlStringKey = {}

function lua_setting_lang.onLoad(json)
	lua_setting_lang.configList, lua_setting_lang.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_setting_lang
