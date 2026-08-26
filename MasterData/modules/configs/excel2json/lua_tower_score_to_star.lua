-- chunkname: @modules/configs/excel2json/lua_tower_score_to_star.lua

module("modules.configs.excel2json.lua_tower_score_to_star", package.seeall)

local lua_tower_score_to_star = {}
local fields = {
	needScore = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_tower_score_to_star.onLoad(json)
	lua_tower_score_to_star.configList, lua_tower_score_to_star.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_score_to_star
