-- chunkname: @modules/configs/excel2json/lua_fight_replace_skill_behavior_effect.lua

module("modules.configs.excel2json.lua_fight_replace_skill_behavior_effect", package.seeall)

local lua_fight_replace_skill_behavior_effect = {}
local fields = {
	audioId = 5,
	effect = 3,
	id = 1,
	skillBehaviorId = 2,
	effectHangPoint = 4
}
local primaryKey = {
	"id",
	"skillBehaviorId"
}
local mlStringKey = {}

function lua_fight_replace_skill_behavior_effect.onLoad(json)
	lua_fight_replace_skill_behavior_effect.configList, lua_fight_replace_skill_behavior_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_replace_skill_behavior_effect
