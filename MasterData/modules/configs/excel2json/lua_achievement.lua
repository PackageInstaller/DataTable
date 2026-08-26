-- chunkname: @modules/configs/excel2json/lua_achievement.lua

module("modules.configs.excel2json.lua_achievement", package.seeall)

local lua_achievement = {}
local fields = {
	startTime = 8,
	name = 5,
	endTime = 9,
	rule = 10,
	groupId = 3,
	uiPlayerParam = 6,
	category = 2,
	id = 1,
	isMask = 7,
	order = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_achievement.onLoad(json)
	lua_achievement.configList, lua_achievement.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_achievement
