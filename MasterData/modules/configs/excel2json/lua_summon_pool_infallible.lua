-- chunkname: @modules/configs/excel2json/lua_summon_pool_infallible.lua

module("modules.configs.excel2json.lua_summon_pool_infallible", package.seeall)

local lua_summon_pool_infallible = {}
local fields = {
	id = 1,
	prefabPath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_summon_pool_infallible.onLoad(json)
	lua_summon_pool_infallible.configList, lua_summon_pool_infallible.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool_infallible
