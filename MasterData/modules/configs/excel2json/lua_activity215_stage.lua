-- chunkname: @modules/configs/excel2json/lua_activity215_stage.lua

module("modules.configs.excel2json.lua_activity215_stage", package.seeall)

local lua_activity215_stage = {}
local fields = {
	stageId = 2,
	globalTaskActivityId = 3,
	activityId = 1,
	globalTaskId = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}

function lua_activity215_stage.onLoad(json)
	lua_activity215_stage.configList, lua_activity215_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity215_stage
