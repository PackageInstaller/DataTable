-- chunkname: @modules/configs/excel2json/lua_survival_reward.lua

module("modules.configs.excel2json.lua_survival_reward", package.seeall)

local lua_survival_reward = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id",
	"score"
}
local mlStringKey = {}

function lua_survival_reward.onLoad(json)
	lua_survival_reward.configList, lua_survival_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_reward
