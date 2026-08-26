-- chunkname: @modules/configs/excel2json/lua_activity228_effects.lua

module("modules.configs.excel2json.lua_activity228_effects", package.seeall)

local lua_activity228_effects = {}
local fields = {
	param = 2,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}

function lua_activity228_effects.onLoad(json)
	lua_activity228_effects.configList, lua_activity228_effects.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity228_effects
