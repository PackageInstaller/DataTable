-- chunkname: @modules/configs/excel2json/lua_activity122_interact.lua

module("modules.configs.excel2json.lua_activity122_interact", package.seeall)

local lua_activity122_interact = {}
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

function lua_activity122_interact.onLoad(json)
	lua_activity122_interact.configList, lua_activity122_interact.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_interact
