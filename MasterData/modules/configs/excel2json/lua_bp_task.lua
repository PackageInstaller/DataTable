-- chunkname: @modules/configs/excel2json/lua_bp_task.lua

module("modules.configs.excel2json.lua_bp_task", package.seeall)

local lua_bp_task = {}
local fields = {
	listenerType = 8,
	name = 6,
	bonusScoreTimes = 22,
	bonusMail = 14,
	endTime = 19,
	turnbackTask = 20,
	jumpId = 17,
	desc = 7,
	listenerParam = 9,
	bpId = 3,
	params = 15,
	openLimit = 13,
	maxProgress = 10,
	sortId = 11,
	isOnline = 2,
	prepose = 12,
	loopType = 4,
	bonusScore = 16,
	minType = 5,
	id = 1,
	newbieTask = 21,
	startTime = 18
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_bp_task.onLoad(json)
	lua_bp_task.configList, lua_bp_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_task
