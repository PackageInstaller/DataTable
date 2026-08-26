-- chunkname: @modules/configs/excel2json/lua_fight_dead_entity_mgr.lua

module("modules.configs.excel2json.lua_fight_dead_entity_mgr", package.seeall)

local lua_fight_dead_entity_mgr = {}
local fields = {
	id = 1,
	playTime = 3,
	loopActName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_dead_entity_mgr.onLoad(json)
	lua_fight_dead_entity_mgr.configList, lua_fight_dead_entity_mgr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_dead_entity_mgr
