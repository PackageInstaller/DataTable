-- chunkname: @modules/configs/excel2json/lua_explore_unit_effect.lua

module("modules.configs.excel2json.lua_explore_unit_effect", package.seeall)

local lua_explore_unit_effect = {}
local fields = {
	prefabPath = 1,
	isLoopAudio = 7,
	audioId = 5,
	isBindGo = 6,
	animName = 2,
	effectPath = 3,
	isOnce = 4
}
local primaryKey = {
	"prefabPath",
	"animName"
}
local mlStringKey = {}

function lua_explore_unit_effect.onLoad(json)
	lua_explore_unit_effect.configList, lua_explore_unit_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_unit_effect
