-- chunkname: @modules/configs/excel2json/lua_achievement_group.lua

module("modules.configs.excel2json.lua_achievement_group", package.seeall)

local lua_achievement_group = {}
local fields = {
	uiListParam = 6,
	name = 4,
	desc = 5,
	category = 2,
	id = 1,
	unLockAchievement = 8,
	uiPlayerParam = 7,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_achievement_group.onLoad(json)
	lua_achievement_group.configList, lua_achievement_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_achievement_group
