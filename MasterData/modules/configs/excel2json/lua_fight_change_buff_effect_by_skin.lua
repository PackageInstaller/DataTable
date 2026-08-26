-- chunkname: @modules/configs/excel2json/lua_fight_change_buff_effect_by_skin.lua

module("modules.configs.excel2json.lua_fight_change_buff_effect_by_skin", package.seeall)

local lua_fight_change_buff_effect_by_skin = {}
local fields = {
	effectPath = 1,
	changedPath = 4,
	audio = 7,
	skinId = 3,
	effectHangPoint = 6,
	duration = 5,
	target = 2
}
local primaryKey = {
	"effectPath",
	"target",
	"skinId"
}
local mlStringKey = {}

function lua_fight_change_buff_effect_by_skin.onLoad(json)
	lua_fight_change_buff_effect_by_skin.configList, lua_fight_change_buff_effect_by_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_change_buff_effect_by_skin
