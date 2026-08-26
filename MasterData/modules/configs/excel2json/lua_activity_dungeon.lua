-- chunkname: @modules/configs/excel2json/lua_activity_dungeon.lua

module("modules.configs.excel2json.lua_activity_dungeon", package.seeall)

local lua_activity_dungeon = {}
local fields = {
	hardChapterId = 5,
	story3ChapterId = 4,
	id = 1,
	story1ChapterId = 2,
	story2ChapterId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity_dungeon.onLoad(json)
	lua_activity_dungeon.configList, lua_activity_dungeon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_dungeon
