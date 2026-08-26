-- chunkname: @modules/configs/excel2json/lua_critter_train_event.lua

module("modules.configs.excel2json.lua_critter_train_event", package.seeall)

local lua_critter_train_event = {}
local fields = {
	roomDialogId = 12,
	name = 3,
	skilledStoryId = 11,
	type = 2,
	normalStoryId = 10,
	autoFinish = 14,
	content = 17,
	desc = 8,
	preferenceAttribute = 6,
	computeIncrRate = 13,
	maxCount = 15,
	effectAttribute = 9,
	cost = 16,
	addAttribute = 5,
	condition = 4,
	initStoryId = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	content = 3,
	desc = 2
}

function lua_critter_train_event.onLoad(json)
	lua_critter_train_event.configList, lua_critter_train_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_train_event
