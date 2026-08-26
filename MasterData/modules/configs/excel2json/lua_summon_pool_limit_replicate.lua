-- chunkname: @modules/configs/excel2json/lua_summon_pool_limit_replicate.lua

module("modules.configs.excel2json.lua_summon_pool_limit_replicate", package.seeall)

local lua_summon_pool_limit_replicate = {}
local fields = {
	id = 1,
	res = 2,
	class = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_summon_pool_limit_replicate.onLoad(json)
	lua_summon_pool_limit_replicate.configList, lua_summon_pool_limit_replicate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool_limit_replicate
