-- chunkname: @modules/configs/excel2json/lua_activity215_main_stage.lua

module("modules.configs.excel2json.lua_activity215_main_stage", package.seeall)

local lua_activity215_main_stage = {}
local fields = {
	stageId = 2,
	startDayOffset = 3,
	activityId = 1,
	endDayOffset = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}

function lua_activity215_main_stage.onLoad(json)
	lua_activity215_main_stage.configList, lua_activity215_main_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity215_main_stage
