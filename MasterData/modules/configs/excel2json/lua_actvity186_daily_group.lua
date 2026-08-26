-- chunkname: @modules/configs/excel2json/lua_actvity186_daily_group.lua

module("modules.configs.excel2json.lua_actvity186_daily_group", package.seeall)

local lua_actvity186_daily_group = {}
local fields = {
	acceptInterval = 5,
	bonus = 6,
	rewardId = 2,
	groupId = 1,
	acceptTime = 3,
	isLoopBonus = 4
}
local primaryKey = {
	"groupId",
	"rewardId"
}
local mlStringKey = {}

function lua_actvity186_daily_group.onLoad(json)
	lua_actvity186_daily_group.configList, lua_actvity186_daily_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_daily_group
