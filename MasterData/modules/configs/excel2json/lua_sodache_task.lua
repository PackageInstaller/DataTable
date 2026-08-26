-- chunkname: @modules/configs/excel2json/lua_sodache_task.lua

module("modules.configs.excel2json.lua_sodache_task", package.seeall)

local lua_sodache_task = {}
local fields = {
	failCondition = 14,
	abandon = 15,
	insideShow = 4,
	desc1 = 7,
	rewardShow = 16,
	remove = 19,
	name = 6,
	desc = 8,
	listenerParam = 10,
	type = 2,
	needAccept = 12,
	group = 3,
	maxProgress = 11,
	reward = 17,
	prepose = 13,
	listenerType = 9,
	track = 18,
	id = 1,
	step = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	desc1 = 2
}

function lua_sodache_task.onLoad(json)
	lua_sodache_task.configList, lua_sodache_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_task
