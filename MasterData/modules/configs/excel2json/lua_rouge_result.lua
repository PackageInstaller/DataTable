-- chunkname: @modules/configs/excel2json/lua_rouge_result.lua

module("modules.configs.excel2json.lua_rouge_result", package.seeall)

local lua_rouge_result = {}
local fields = {
	id = 2,
	priority = 5,
	triggerParam = 7,
	type = 3,
	season = 1,
	trigger = 6,
	desc = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_result.onLoad(json)
	lua_rouge_result.configList, lua_rouge_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_result
