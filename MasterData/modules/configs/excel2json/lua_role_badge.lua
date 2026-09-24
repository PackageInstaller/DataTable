-- chunkname: @modules/configs/excel2json/lua_role_badge.lua

module("modules.configs.excel2json.lua_role_badge", package.seeall)

local lua_role_badge = {}
local fields = {
	sortId = 8,
	listenerType = 5,
	icon = 10,
	groupId = 2,
	badgeTitle = 3,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	badgeTitle = 1,
	desc = 2
}

function lua_role_badge.onLoad(json)
	lua_role_badge.configList, lua_role_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_role_badge
