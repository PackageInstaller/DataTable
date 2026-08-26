-- chunkname: @modules/configs/excel2json/lua_survival_reward_shop.lua

module("modules.configs.excel2json.lua_survival_reward_shop", package.seeall)

local lua_survival_reward_shop = {}
local fields = {
	cost = 4,
	name = 6,
	product = 2,
	tag = 5,
	id = 1,
	maxBuyCount = 3,
	order = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_reward_shop.onLoad(json)
	lua_survival_reward_shop.configList, lua_survival_reward_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_reward_shop
