-- chunkname: @modules/configs/excel2json/lua_fight_buff_replace_spine_act.lua

module("modules.configs.excel2json.lua_fight_buff_replace_spine_act", package.seeall)

local lua_fight_buff_replace_spine_act = {}
local fields = {
	combination = 4,
	priority = 3,
	buffId = 2,
	id = 1,
	suffix = 5
}
local primaryKey = {
	"id",
	"buffId",
	"priority"
}
local mlStringKey = {}

function lua_fight_buff_replace_spine_act.onLoad(json)
	lua_fight_buff_replace_spine_act.configList, lua_fight_buff_replace_spine_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_replace_spine_act
