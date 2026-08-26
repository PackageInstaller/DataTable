-- chunkname: @modules/configs/excel2json/lua_player_badge.lua

module("modules.configs.excel2json.lua_player_badge", package.seeall)

local lua_player_badge = {}
local fields = {
	bigIcon = 3,
	name = 2,
	item = 7,
	group = 5,
	id = 1,
	icon = 4,
	level = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_player_badge.onLoad(json)
	lua_player_badge.configList, lua_player_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_player_badge
