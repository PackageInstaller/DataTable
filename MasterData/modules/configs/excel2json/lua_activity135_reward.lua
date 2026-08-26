-- chunkname: @modules/configs/excel2json/lua_activity135_reward.lua

module("modules.configs.excel2json.lua_activity135_reward", package.seeall)

local lua_activity135_reward = {}
local fields = {
	firstBounsId = 3,
	activityId = 2,
	episodeId = 1
}
local primaryKey = {
	"episodeId",
	"activityId"
}
local mlStringKey = {}

function lua_activity135_reward.onLoad(json)
	lua_activity135_reward.configList, lua_activity135_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity135_reward
