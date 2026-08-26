-- chunkname: @modules/configs/excel2json/lua_rogue_event_life.lua

module("modules.configs.excel2json.lua_rogue_event_life", package.seeall)

local lua_rogue_event_life = {}
local fields = {
	id = 1,
	num = 2,
	lifeAdd = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_event_life.onLoad(json)
	lua_rogue_event_life.configList, lua_rogue_event_life.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_life
