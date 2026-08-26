-- chunkname: @modules/configs/excel2json/lua_rogue_event_fight.lua

module("modules.configs.excel2json.lua_rogue_event_fight", package.seeall)

local lua_rogue_event_fight = {}
local fields = {
	heartChange5 = 8,
	heartChange4 = 7,
	attrChange1 = 9,
	type = 3,
	oldtemplate = 14,
	attrChange2 = 10,
	episode = 2,
	attrChange3 = 11,
	attrChange5 = 13,
	attrChange4 = 12,
	newtemplate = 15,
	heartChange1 = 4,
	id = 1,
	heartChange2 = 5,
	isChangeScene = 16,
	heartChange3 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_event_fight.onLoad(json)
	lua_rogue_event_fight.configList, lua_rogue_event_fight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_fight
