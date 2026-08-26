-- chunkname: @modules/configs/excel2json/lua_hero_effectiveness.lua

module("modules.configs.excel2json.lua_hero_effectiveness", package.seeall)

local lua_hero_effectiveness = {}
local fields = {
	sr = 3,
	ssr = 2,
	r = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_hero_effectiveness.onLoad(json)
	lua_hero_effectiveness.configList, lua_hero_effectiveness.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_effectiveness
