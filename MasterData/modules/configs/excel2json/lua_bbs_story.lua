-- chunkname: @modules/configs/excel2json/lua_bbs_story.lua

module("modules.configs.excel2json.lua_bbs_story", package.seeall)

local lua_bbs_story = {}
local fields = {
	stepId = 2,
	post = 3,
	storyId = 1
}
local primaryKey = {
	"storyId",
	"stepId"
}
local mlStringKey = {}

function lua_bbs_story.onLoad(json)
	lua_bbs_story.configList, lua_bbs_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bbs_story
