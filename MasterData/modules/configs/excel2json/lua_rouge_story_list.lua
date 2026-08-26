-- chunkname: @modules/configs/excel2json/lua_rouge_story_list.lua

module("modules.configs.excel2json.lua_rouge_story_list", package.seeall)

local lua_rouge_story_list = {}
local fields = {
	stageId = 4,
	name = 7,
	levelIdDict = 6,
	id = 2,
	season = 1,
	image = 5,
	storyIdList = 3,
	desc = 8
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_story_list.onLoad(json)
	lua_rouge_story_list.configList, lua_rouge_story_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_story_list
