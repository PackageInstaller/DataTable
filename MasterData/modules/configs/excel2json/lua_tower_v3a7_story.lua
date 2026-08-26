-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_story.lua

module("modules.configs.excel2json.lua_tower_v3a7_story", package.seeall)

local lua_tower_v3a7_story = {}
local fields = {
	head = 3,
	id = 1,
	dialogue = 4,
	occur = 5,
	order = 2
}
local primaryKey = {
	"id",
	"order"
}
local mlStringKey = {
	dialogue = 1
}

function lua_tower_v3a7_story.onLoad(json)
	lua_tower_v3a7_story.configList, lua_tower_v3a7_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_v3a7_story
