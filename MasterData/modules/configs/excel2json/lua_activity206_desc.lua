-- chunkname: @modules/configs/excel2json/lua_activity206_desc.lua

module("modules.configs.excel2json.lua_activity206_desc", package.seeall)

local lua_activity206_desc = {}
local fields = {
	stageId = 2,
	name = 3,
	targetDesc = 5,
	ruleTitle = 6,
	ruleDesc = 7,
	icon = 8,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {
	ruleTitle = 4,
	name = 1,
	ruleDesc = 5,
	targetDesc = 3,
	desc = 2
}

function lua_activity206_desc.onLoad(json)
	lua_activity206_desc.configList, lua_activity206_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity206_desc
