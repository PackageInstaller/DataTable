-- chunkname: @modules/configs/excel2json/lua_activity144_record_event.lua

module("modules.configs.excel2json.lua_activity144_record_event", package.seeall)

local lua_activity144_record_event = {}
local fields = {
	eventIds = 5,
	name = 3,
	unLockDesc = 4,
	recordId = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"recordId"
}
local mlStringKey = {
	unLockDesc = 2,
	name = 1
}

function lua_activity144_record_event.onLoad(json)
	lua_activity144_record_event.configList, lua_activity144_record_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_record_event
