-- chunkname: @modules/configs/excel2json/lua_activity165_reward.lua

module("modules.configs.excel2json.lua_activity165_reward", package.seeall)

local lua_activity165_reward = {}
local fields = {
	bonus = 3,
	showPos = 4,
	endingCount = 2,
	storyId = 1
}
local primaryKey = {
	"storyId",
	"endingCount"
}
local mlStringKey = {}

function lua_activity165_reward.onLoad(json)
	lua_activity165_reward.configList, lua_activity165_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity165_reward
