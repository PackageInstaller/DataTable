-- chunkname: @modules/configs/excel2json/lua_activity197_pool.lua

module("modules.configs.excel2json.lua_activity197_pool", package.seeall)

local lua_activity197_pool = {}
local fields = {
	index = 3,
	bonus = 4,
	activityId = 1,
	poolId = 2
}
local primaryKey = {
	"activityId",
	"poolId",
	"index"
}
local mlStringKey = {}

function lua_activity197_pool.onLoad(json)
	lua_activity197_pool.configList, lua_activity197_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity197_pool
