-- chunkname: @modules/configs/excel2json/lua_college_story_node.lua

module("modules.configs.excel2json.lua_college_story_node", package.seeall)

local lua_college_story_node = {}
local fields = {
	tracePoints = 9,
	effect = 5,
	unlockCost = 8,
	location = 7,
	themeId = 2,
	title = 3,
	pos = 6,
	type = 4,
	playFormat = 10,
	id = 1,
	playConfig = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_college_story_node.onLoad(json)
	lua_college_story_node.configList, lua_college_story_node.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_story_node
