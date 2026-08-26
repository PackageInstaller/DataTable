-- chunkname: @modules/configs/excel2json/lua_push_box_episode.lua

module("modules.configs.excel2json.lua_push_box_episode", package.seeall)

local lua_push_box_episode = {}
local fields = {
	fan_duration = 8,
	name = 2,
	enemy_alarm = 7,
	layout = 3,
	light_alarm = 9,
	enemy_act = 6,
	id = 1,
	wall = 4,
	step = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_push_box_episode.onLoad(json)
	lua_push_box_episode.configList, lua_push_box_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_push_box_episode
