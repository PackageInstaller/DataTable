-- chunkname: @modules/configs/excel2json/lua_activity206_dialogue.lua

module("modules.configs.excel2json.lua_activity206_dialogue", package.seeall)

local lua_activity206_dialogue = {}
local fields = {
	roleName = 4,
	roleIcon = 3,
	chaseId = 2,
	dialog = 6,
	roleNameEn = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"chaseId"
}
local mlStringKey = {
	roleName = 1,
	dialog = 2
}

function lua_activity206_dialogue.onLoad(json)
	lua_activity206_dialogue.configList, lua_activity206_dialogue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity206_dialogue
