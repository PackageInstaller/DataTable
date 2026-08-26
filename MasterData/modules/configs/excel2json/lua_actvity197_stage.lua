-- chunkname: @modules/configs/excel2json/lua_actvity197_stage.lua

module("modules.configs.excel2json.lua_actvity197_stage", package.seeall)

local lua_actvity197_stage = {}
local fields = {
	stageId = 2,
	globalTaskId = 6,
	globalTaskActivityId = 5,
	endTime = 4,
	activityId = 1,
	startTime = 3
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}

function lua_actvity197_stage.onLoad(json)
	lua_actvity197_stage.configList, lua_actvity197_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity197_stage
