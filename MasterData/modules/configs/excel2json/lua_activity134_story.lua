-- chunkname: @modules/configs/excel2json/lua_activity134_story.lua

module("modules.configs.excel2json.lua_activity134_story", package.seeall)

local lua_activity134_story = {}
local fields = {
	storyType = 2,
	charaterIcon = 4,
	id = 1,
	formMan = 5,
	desc = 3
}
local primaryKey = {
	"id",
	"storyType"
}
local mlStringKey = {
	formMan = 2,
	desc = 1
}

function lua_activity134_story.onLoad(json)
	lua_activity134_story.configList, lua_activity134_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity134_story
