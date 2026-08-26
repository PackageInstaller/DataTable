-- chunkname: @modules/configs/excel2json/lua_rogue_event_revive.lua

module("modules.configs.excel2json.lua_rogue_event_revive", package.seeall)

local lua_rogue_event_revive = {}
local fields = {
	id = 1,
	num = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_event_revive.onLoad(json)
	lua_rogue_event_revive.configList, lua_rogue_event_revive.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_revive
