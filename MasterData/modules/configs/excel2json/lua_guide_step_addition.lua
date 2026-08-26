-- chunkname: @modules/configs/excel2json/lua_guide_step_addition.lua

module("modules.configs.excel2json.lua_guide_step_addition", package.seeall)

local lua_guide_step_addition = {}
local fields = {
	desc = 3,
	exception = 24,
	storyContent = 12,
	stepId = 2,
	tipsHead = 7,
	stat = 5,
	tipsTalker = 9,
	uiOffset = 15,
	keyStep = 4,
	maskId = 14,
	goPath = 17,
	againSteps = 23,
	uiInfo = 16,
	tipsContent = 10,
	exceptionDelay = 25,
	notForce = 18,
	action = 21,
	audio = 13,
	delay = 20,
	additionCmd = 22,
	touchGOPath = 19,
	portraitPos = 8,
	tipsPos = 6,
	id = 1,
	tipsDir = 11
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	storyContent = 3,
	tipsTalker = 1,
	tipsContent = 2
}

function lua_guide_step_addition.onLoad(json)
	lua_guide_step_addition.configList, lua_guide_step_addition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_guide_step_addition
