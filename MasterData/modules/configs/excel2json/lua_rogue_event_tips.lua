-- chunkname: @modules/configs/excel2json/lua_rogue_event_tips.lua

module("modules.configs.excel2json.lua_rogue_event_tips", package.seeall)

local lua_rogue_event_tips = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rogue_event_tips.onLoad(json)
	lua_rogue_event_tips.configList, lua_rogue_event_tips.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_tips
