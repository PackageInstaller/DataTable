-- chunkname: @modules/configs/excel2json/lua_video_lang.lua

module("modules.configs.excel2json.lua_video_lang", package.seeall)

local lua_video_lang = {}
local fields = {
	supportLang = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}

function lua_video_lang.onLoad(json)
	lua_video_lang.configList, lua_video_lang.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_video_lang
