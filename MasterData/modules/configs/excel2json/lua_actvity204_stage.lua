-- chunkname: @modules/configs/excel2json/lua_actvity204_stage.lua

module("modules.configs.excel2json.lua_actvity204_stage", package.seeall)

local lua_actvity204_stage = {}
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

function lua_actvity204_stage.onLoad(json)
	lua_actvity204_stage.configList, lua_actvity204_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity204_stage
