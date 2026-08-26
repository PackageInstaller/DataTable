-- chunkname: @modules/configs/excel2json/lua_fight_transition_act.lua

module("modules.configs.excel2json.lua_fight_transition_act", package.seeall)

local lua_fight_transition_act = {}
local fields = {
	fromAct = 2,
	id = 1,
	endAct = 3,
	transitionAct = 4
}
local primaryKey = {
	"id",
	"fromAct",
	"endAct"
}
local mlStringKey = {}

function lua_fight_transition_act.onLoad(json)
	lua_fight_transition_act.configList, lua_fight_transition_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_transition_act
