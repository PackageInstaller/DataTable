-- chunkname: @modules/configs/excel2json/lua_activity113_dungeon.lua

module("modules.configs.excel2json.lua_activity113_dungeon", package.seeall)

local lua_activity113_dungeon = {}
local fields = {
	openDay = 3,
	activityId = 2,
	chapterId = 1
}
local primaryKey = {
	"chapterId"
}
local mlStringKey = {}

function lua_activity113_dungeon.onLoad(json)
	lua_activity113_dungeon.configList, lua_activity113_dungeon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity113_dungeon
