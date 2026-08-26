-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_music_ball_skill.lua

module("modules.configs.excel2json.lua_fight_rouge2_music_ball_skill", package.seeall)

local lua_fight_rouge2_music_ball_skill = {}
local fields = {
	condition1 = 3,
	behavior1 = 4,
	condition2 = 5,
	skillId = 1,
	condition3 = 7,
	icon = 2,
	behavior3 = 8,
	behavior2 = 6
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_fight_rouge2_music_ball_skill.onLoad(json)
	lua_fight_rouge2_music_ball_skill.configList, lua_fight_rouge2_music_ball_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_rouge2_music_ball_skill
