-- chunkname: @modules/configs/excel2json/lua_rouge2_story_list.lua

module("modules.configs.excel2json.lua_rouge2_story_list", package.seeall)

local lua_rouge2_story_list = {}
local fields = {
	storyIdList = 2,
	name = 6,
	stageId = 5,
	fullImage = 4,
	id = 1,
	eventId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge2_story_list.onLoad(json)
	lua_rouge2_story_list.configList, lua_rouge2_story_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_story_list
