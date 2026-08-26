-- chunkname: @modules/configs/excel2json/lua_fight_buff_reject_act.lua

module("modules.configs.excel2json.lua_fight_buff_reject_act", package.seeall)

local lua_fight_buff_reject_act = {}
local fields = {
	id = 1,
	rejectAct = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_buff_reject_act.onLoad(json)
	lua_fight_buff_reject_act.configList, lua_fight_buff_reject_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_reject_act
