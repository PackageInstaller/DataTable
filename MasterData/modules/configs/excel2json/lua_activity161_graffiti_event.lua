-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_event.lua

module("modules.configs.excel2json.lua_activity161_graffiti_event", package.seeall)

local lua_activity161_graffiti_event = {}
local fields = {
	elementId = 2,
	cd = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {}

function lua_activity161_graffiti_event.onLoad(json)
	lua_activity161_graffiti_event.configList, lua_activity161_graffiti_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity161_graffiti_event
