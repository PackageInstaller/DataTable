-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_event.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_event", package.seeall)

local lua_activity_nuodika_180_event = {}
local fields = {
	initVisible = 4,
	eventId = 1,
	eventParam = 3,
	eventType = 2
}
local primaryKey = {
	"eventId"
}
local mlStringKey = {}

function lua_activity_nuodika_180_event.onLoad(json)
	lua_activity_nuodika_180_event.configList, lua_activity_nuodika_180_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_nuodika_180_event
