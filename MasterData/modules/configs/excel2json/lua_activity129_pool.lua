-- chunkname: @modules/configs/excel2json/lua_activity129_pool.lua

module("modules.configs.excel2json.lua_activity129_pool", package.seeall)

local lua_activity129_pool = {}
local fields = {
	cost = 6,
	name = 4,
	nameEn = 5,
	type = 3,
	maxDraw = 7,
	activityId = 1,
	poolId = 2
}
local primaryKey = {
	"activityId",
	"poolId"
}
local mlStringKey = {
	nameEn = 2,
	name = 1
}

function lua_activity129_pool.onLoad(json)
	lua_activity129_pool.configList, lua_activity129_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity129_pool
