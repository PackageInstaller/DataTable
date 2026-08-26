-- chunkname: @modules/configs/excel2json/lua_activity109_interact_object.lua

module("modules.configs.excel2json.lua_activity109_interact_object", package.seeall)

local lua_activity109_interact_object = {}
local fields = {
	param = 6,
	name_en = 4,
	interactType = 5,
	name = 3,
	id = 2,
	avatar = 7,
	activityId = 1,
	showParam = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity109_interact_object.onLoad(json)
	lua_activity109_interact_object.configList, lua_activity109_interact_object.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity109_interact_object
