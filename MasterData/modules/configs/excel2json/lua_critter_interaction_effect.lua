-- chunkname: @modules/configs/excel2json/lua_critter_interaction_effect.lua

module("modules.configs.excel2json.lua_critter_interaction_effect", package.seeall)

local lua_critter_interaction_effect = {}
local fields = {
	animName = 5,
	effectKey = 6,
	point = 3,
	skinId = 1,
	id = 2,
	effectRes = 4
}
local primaryKey = {
	"skinId",
	"id"
}
local mlStringKey = {}

function lua_critter_interaction_effect.onLoad(json)
	lua_critter_interaction_effect.configList, lua_critter_interaction_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_interaction_effect
