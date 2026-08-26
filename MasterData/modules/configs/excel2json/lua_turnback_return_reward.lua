-- chunkname: @modules/configs/excel2json/lua_turnback_return_reward.lua

module("modules.configs.excel2json.lua_turnback_return_reward", package.seeall)

local lua_turnback_return_reward = {}
local fields = {
	needVitality = 6,
	isOnline = 3,
	id = 1,
	turnbackId = 2,
	lossDaysRange = 4,
	bonus = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_turnback_return_reward.onLoad(json)
	lua_turnback_return_reward.configList, lua_turnback_return_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_return_reward
