-- chunkname: @modules/configs/excel2json/lua_activity142_interact_object.lua

module("modules.configs.excel2json.lua_activity142_interact_object", package.seeall)

local lua_activity142_interact_object = {}
local fields = {
	alertType = 8,
	name = 3,
	id = 2,
	effectId = 10,
	moveAudioId = 12,
	param = 5,
	showParam = 7,
	createAudioId = 11,
	alertParam = 9,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity142_interact_object.onLoad(json)
	lua_activity142_interact_object.configList, lua_activity142_interact_object.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_interact_object
