-- chunkname: @modules/configs/excel2json/lua_fight_replace_buff_act_effect.lua

module("modules.configs.excel2json.lua_fight_replace_buff_act_effect", package.seeall)

local lua_fight_replace_buff_act_effect = {}
local fields = {
	audioId = 5,
	effect = 3,
	id = 1,
	buffActId = 2,
	effectHangPoint = 4
}
local primaryKey = {
	"id",
	"buffActId"
}
local mlStringKey = {}

function lua_fight_replace_buff_act_effect.onLoad(json)
	lua_fight_replace_buff_act_effect.configList, lua_fight_replace_buff_act_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_replace_buff_act_effect
