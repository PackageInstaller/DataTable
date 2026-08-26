-- chunkname: @modules/configs/excel2json/lua_explore_hero_effect.lua

module("modules.configs.excel2json.lua_explore_hero_effect", package.seeall)

local lua_explore_hero_effect = {}
local fields = {
	audioId = 5,
	status = 1,
	index = 2,
	effectPath = 3,
	hangPath = 4
}
local primaryKey = {
	"status",
	"index"
}
local mlStringKey = {}

function lua_explore_hero_effect.onLoad(json)
	lua_explore_hero_effect.configList, lua_explore_hero_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_hero_effect
