-- chunkname: @modules/configs/excel2json/lua_activity168_endless_event.lua

module("modules.configs.excel2json.lua_activity168_endless_event", package.seeall)

local lua_activity168_endless_event = {}
local fields = {
	id = 2,
	scene = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity168_endless_event.onLoad(json)
	lua_activity168_endless_event.configList, lua_activity168_endless_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_endless_event
