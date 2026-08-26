-- chunkname: @modules/configs/excel2json/lua_activity216_hero_circle.lua

module("modules.configs.excel2json.lua_activity216_hero_circle", package.seeall)

local lua_activity216_hero_circle = {}
local fields = {
	id = 1,
	heroId = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity216_hero_circle.onLoad(json)
	lua_activity216_hero_circle.configList, lua_activity216_hero_circle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity216_hero_circle
