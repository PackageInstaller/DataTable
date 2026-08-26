-- chunkname: @modules/configs/excel2json/lua_summon_pool_package.lua

module("modules.configs.excel2json.lua_summon_pool_package", package.seeall)

local lua_summon_pool_package = {}
local fields = {
	posOffset = 8,
	packageRecommend = 4,
	showLimit = 6,
	packageEffect = 5,
	id = 1,
	packageRecommendSwitch = 3,
	className = 7,
	order = 2
}
local primaryKey = {
	"id",
	"order"
}
local mlStringKey = {}

function lua_summon_pool_package.onLoad(json)
	lua_summon_pool_package.configList, lua_summon_pool_package.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool_package
