-- chunkname: @modules/configs/excel2json/lua_rogue_heartbeat.lua

module("modules.configs.excel2json.lua_rogue_heartbeat", package.seeall)

local lua_rogue_heartbeat = {}
local fields = {
	desc = 5,
	range = 2,
	id = 1,
	title = 4,
	rule = 6,
	attr = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rogue_heartbeat.onLoad(json)
	lua_rogue_heartbeat.configList, lua_rogue_heartbeat.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_heartbeat
