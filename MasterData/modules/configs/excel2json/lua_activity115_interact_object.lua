-- chunkname: @modules/configs/excel2json/lua_activity115_interact_object.lua

module("modules.configs.excel2json.lua_activity115_interact_object", package.seeall)

local lua_activity115_interact_object = {}
local fields = {
	alertType = 8,
	name = 3,
	id = 2,
	param = 5,
	battleDesc = 11,
	alertParam = 9,
	showParam = 7,
	battleName = 10,
	recommendLevel = 12,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	battleDesc = 3,
	name = 1,
	battleName = 2
}

function lua_activity115_interact_object.onLoad(json)
	lua_activity115_interact_object.configList, lua_activity115_interact_object.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_interact_object
