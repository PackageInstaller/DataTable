-- chunkname: @modules/configs/excel2json/lua_activity191_stage.lua

module("modules.configs.excel2json.lua_activity191_stage", package.seeall)

local lua_activity191_stage = {}
local fields = {
	score = 7,
	name = 6,
	rule = 5,
	nextId = 3,
	id = 2,
	initStage = 4,
	activityId = 1,
	coin = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity191_stage.onLoad(json)
	lua_activity191_stage.configList, lua_activity191_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_stage
