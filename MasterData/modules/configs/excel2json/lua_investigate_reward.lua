-- chunkname: @modules/configs/excel2json/lua_investigate_reward.lua

module("modules.configs.excel2json.lua_investigate_reward", package.seeall)

local lua_investigate_reward = {}
local fields = {
	listenerParam = 4,
	minType = 2,
	listenerType = 3,
	desc = 6,
	bonus = 7,
	maxProgress = 5,
	jumpId = 8,
	taskId = 1
}
local primaryKey = {
	"taskId"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}

function lua_investigate_reward.onLoad(json)
	lua_investigate_reward.configList, lua_investigate_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_investigate_reward
