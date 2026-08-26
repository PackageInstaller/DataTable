-- chunkname: @modules/configs/excel2json/lua_skin_effect_mainframe.lua

module("modules.configs.excel2json.lua_skin_effect_mainframe", package.seeall)

local lua_skin_effect_mainframe = {}
local fields = {
	id = 1,
	effect = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_effect_mainframe.onLoad(json)
	lua_skin_effect_mainframe.configList, lua_skin_effect_mainframe.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_effect_mainframe
