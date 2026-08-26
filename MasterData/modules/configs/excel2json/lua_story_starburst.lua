-- chunkname: @modules/configs/excel2json/lua_story_starburst.lua

module("modules.configs.excel2json.lua_story_starburst", package.seeall)

local lua_story_starburst = {}
local fields = {
	id = 1,
	meshpath = 3,
	effpath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_starburst.onLoad(json)
	lua_story_starburst.configList, lua_story_starburst.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_starburst
