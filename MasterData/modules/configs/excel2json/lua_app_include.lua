-- chunkname: @modules/configs/excel2json/lua_app_include.lua

module("modules.configs.excel2json.lua_app_include", package.seeall)

local lua_app_include = {}
local fields = {
	path = 8,
	video = 7,
	guide = 6,
	seasonIds = 5,
	roomTheme = 10,
	heroStoryIds = 11,
	story = 4,
	chapter = 3,
	character = 2,
	id = 1,
	maxWeekWalk = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_app_include.onLoad(json)
	lua_app_include.configList, lua_app_include.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_app_include
