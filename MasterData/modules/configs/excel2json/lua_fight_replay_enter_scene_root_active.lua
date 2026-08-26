-- chunkname: @modules/configs/excel2json/lua_fight_replay_enter_scene_root_active.lua

module("modules.configs.excel2json.lua_fight_replay_enter_scene_root_active", package.seeall)

local lua_fight_replay_enter_scene_root_active = {}
local fields = {
	wave = 2,
	id = 1,
	activeRootName = 3,
	switch = 4
}
local primaryKey = {
	"id",
	"wave"
}
local mlStringKey = {}

function lua_fight_replay_enter_scene_root_active.onLoad(json)
	lua_fight_replay_enter_scene_root_active.configList, lua_fight_replay_enter_scene_root_active.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_replay_enter_scene_root_active
