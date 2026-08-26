-- chunkname: @modules/configs/excel2json/lua_activity144_episode_showtarget.lua

module("modules.configs.excel2json.lua_activity144_episode_showtarget", package.seeall)

local lua_activity144_episode_showtarget = {}
local fields = {
	id = 1,
	name = 2,
	colorStr = 4,
	elevation = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity144_episode_showtarget.onLoad(json)
	lua_activity144_episode_showtarget.configList, lua_activity144_episode_showtarget.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_episode_showtarget
