-- chunkname: @modules/configs/excel2json/lua_fight_hnj_second_stage_effect.lua

module("modules.configs.excel2json.lua_fight_hnj_second_stage_effect", package.seeall)

local lua_fight_hnj_second_stage_effect = {}
local fields = {
	effect = 2,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_hnj_second_stage_effect.onLoad(json)
	lua_fight_hnj_second_stage_effect.configList, lua_fight_hnj_second_stage_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hnj_second_stage_effect
