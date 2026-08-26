-- chunkname: @modules/configs/excel2json/lua_activity122_interact_effect.lua

module("modules.configs.excel2json.lua_activity122_interact_effect", package.seeall)

local lua_activity122_interact_effect = {}
local fields = {
	id = 1,
	effectType = 2,
	avatar = 4,
	piontName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity122_interact_effect.onLoad(json)
	lua_activity122_interact_effect.configList, lua_activity122_interact_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_interact_effect
