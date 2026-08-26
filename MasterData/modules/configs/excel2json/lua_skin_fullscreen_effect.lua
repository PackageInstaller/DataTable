-- chunkname: @modules/configs/excel2json/lua_skin_fullscreen_effect.lua

module("modules.configs.excel2json.lua_skin_fullscreen_effect", package.seeall)

local lua_skin_fullscreen_effect = {}
local fields = {
	id = 1,
	effectList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_fullscreen_effect.onLoad(json)
	lua_skin_fullscreen_effect.configList, lua_skin_fullscreen_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_fullscreen_effect
