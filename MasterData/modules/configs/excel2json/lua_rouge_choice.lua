-- chunkname: @modules/configs/excel2json/lua_rouge_choice.lua

module("modules.configs.excel2json.lua_rouge_choice", package.seeall)

local lua_rouge_choice = {}
local fields = {
	interactive = 8,
	display = 9,
	selectedDesc = 7,
	unlockParam = 4,
	title = 5,
	desc = 6,
	unlockType = 3,
	id = 1,
	version = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1,
	selectedDesc = 3,
	desc = 2
}

function lua_rouge_choice.onLoad(json)
	lua_rouge_choice.configList, lua_rouge_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_choice
