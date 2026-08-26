-- chunkname: @modules/configs/excel2json/lua_rouge2_funnyfight_event.lua

module("modules.configs.excel2json.lua_rouge2_funnyfight_event", package.seeall)

local lua_rouge2_funnyfight_event = {}
local fields = {
	idIndicator = 2,
	fightTaskinfo = 7,
	taskLevel = 3,
	fightTaskDetail = 8,
	isTopic = 5,
	fightTaskDesc = 6,
	id = 1,
	stage1Interactive = 9,
	nextTask = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	fightTaskinfo = 2,
	fightTaskDesc = 1,
	fightTaskDetail = 3
}

function lua_rouge2_funnyfight_event.onLoad(json)
	lua_rouge2_funnyfight_event.configList, lua_rouge2_funnyfight_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_funnyfight_event
