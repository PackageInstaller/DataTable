-- chunkname: @modules/configs/excel2json/lua_summon_pool_detail.lua

module("modules.configs.excel2json.lua_summon_pool_detail", package.seeall)

local lua_summon_pool_detail = {}
local fields = {
	order = 6,
	name = 4,
	openId = 7,
	historyShowType = 5,
	id = 1,
	info = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_summon_pool_detail.onLoad(json)
	lua_summon_pool_detail.configList, lua_summon_pool_detail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool_detail
