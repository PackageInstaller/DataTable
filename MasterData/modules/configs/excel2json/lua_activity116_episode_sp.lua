-- chunkname: @modules/configs/excel2json/lua_activity116_episode_sp.lua

module("modules.configs.excel2json.lua_activity116_episode_sp", package.seeall)

local lua_activity116_episode_sp = {}
local fields = {
	endShow = 5,
	id = 1,
	title = 3,
	refreshDay = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endShow = 3,
	title = 1,
	desc = 2
}

function lua_activity116_episode_sp.onLoad(json)
	lua_activity116_episode_sp.configList, lua_activity116_episode_sp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity116_episode_sp
