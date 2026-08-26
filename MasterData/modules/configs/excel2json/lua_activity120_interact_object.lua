-- chunkname: @modules/configs/excel2json/lua_activity120_interact_object.lua

module("modules.configs.excel2json.lua_activity120_interact_object", package.seeall)

local lua_activity120_interact_object = {}
local fields = {
	param = 5,
	name = 3,
	id = 2,
	effectId = 8,
	moveAudioId = 10,
	createAudioId = 9,
	showParam = 7,
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

function lua_activity120_interact_object.onLoad(json)
	lua_activity120_interact_object.configList, lua_activity120_interact_object.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity120_interact_object
