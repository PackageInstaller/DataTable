-- chunkname: @modules/configs/excel2json/lua_rouge_special_trigger.lua

module("modules.configs.excel2json.lua_rouge_special_trigger", package.seeall)

local lua_rouge_special_trigger = {}
local fields = {
	eventCorrectWeight = 4,
	unlockTask = 8,
	reasonRange = 3,
	name = 2,
	eventGroupCorrectWeight = 5,
	shopGroupCorrectWeight = 6,
	inPictorial = 9,
	dropGroupCorrectWeight = 7,
	id = 1,
	isShow = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_special_trigger.onLoad(json)
	lua_rouge_special_trigger.configList, lua_rouge_special_trigger.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_special_trigger
