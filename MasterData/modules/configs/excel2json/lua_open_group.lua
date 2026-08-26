-- chunkname: @modules/configs/excel2json/lua_open_group.lua

module("modules.configs.excel2json.lua_open_group", package.seeall)

local lua_open_group = {}
local fields = {
	need_finish_guide = 6,
	hero_number = 2,
	need_episode = 4,
	need_enter_episode = 5,
	id = 1,
	showInEpisode = 7,
	need_level = 3,
	lock_desc = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_open_group.onLoad(json)
	lua_open_group.configList, lua_open_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_open_group
