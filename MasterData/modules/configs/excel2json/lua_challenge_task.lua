-- chunkname: @modules/configs/excel2json/lua_challenge_task.lua

module("modules.configs.excel2json.lua_challenge_task", package.seeall)

local lua_challenge_task = {}
local fields = {
	groupId = 4,
	name = 7,
	bonusMail = 9,
	type = 3,
	maxFinishCount = 14,
	desc = 8,
	listenerParam = 12,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	jumpId = 15,
	isOnline = 5,
	listenerType = 11,
	minType = 6,
	id = 1,
	badgeNum = 17,
	bonus = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_challenge_task.onLoad(json)
	lua_challenge_task.configList, lua_challenge_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_task
