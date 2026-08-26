-- chunkname: @modules/configs/excel2json/lua_activity123_stage.lua

module("modules.configs.excel2json.lua_activity123_stage", package.seeall)

local lua_activity123_stage = {}
local fields = {
	recommendSchool = 13,
	name = 4,
	preCondition = 3,
	finalScale = 9,
	mainEquip = 10,
	initScale = 7,
	initPos = 6,
	stageCondition = 12,
	res = 5,
	finalPos = 8,
	stage = 2,
	activityId = 1,
	recommend = 11
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	name = 1
}

function lua_activity123_stage.onLoad(json)
	lua_activity123_stage.configList, lua_activity123_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_stage
