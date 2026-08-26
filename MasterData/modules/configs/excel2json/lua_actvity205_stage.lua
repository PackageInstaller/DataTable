-- chunkname: @modules/configs/excel2json/lua_actvity205_stage.lua

module("modules.configs.excel2json.lua_actvity205_stage", package.seeall)

local lua_actvity205_stage = {}
local fields = {
	stageId = 2,
	name = 6,
	times = 5,
	targetDesc = 8,
	ruleTitle = 9,
	ruleDesc = 10,
	desc = 7,
	endTime = 4,
	icon = 11,
	activityId = 1,
	startTime = 3
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

function lua_actvity205_stage.onLoad(json)
	lua_actvity205_stage.configList, lua_actvity205_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity205_stage
