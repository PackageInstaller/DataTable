-- chunkname: @modules/configs/excel2json/lua_story_prologue_synopsis.lua

module("modules.configs.excel2json.lua_story_prologue_synopsis", package.seeall)

local lua_story_prologue_synopsis = {}
local fields = {
	prologues = 2,
	id = 1,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_story_prologue_synopsis.onLoad(json)
	lua_story_prologue_synopsis.configList, lua_story_prologue_synopsis.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_prologue_synopsis
