-- chunkname: @modules/configs/excel2json/lua_racing_reward.lua

module("modules.configs.excel2json.lua_racing_reward", package.seeall)

local lua_racing_reward = {}
local fields = {
	bonus = 3,
	star = 2,
	episodeId = 1
}
local primaryKey = {
	"episodeId",
	"star"
}
local mlStringKey = {}

function lua_racing_reward.onLoad(json)
	lua_racing_reward.configList, lua_racing_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_reward
