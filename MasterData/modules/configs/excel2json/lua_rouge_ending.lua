-- chunkname: @modules/configs/excel2json/lua_rouge_ending.lua

module("modules.configs.excel2json.lua_rouge_ending", package.seeall)

local lua_rouge_ending = {}
local fields = {
	id = 1,
	version = 2,
	endingStoryId = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_ending.onLoad(json)
	lua_rouge_ending.configList, lua_rouge_ending.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_ending
