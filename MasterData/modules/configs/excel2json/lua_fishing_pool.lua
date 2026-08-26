-- chunkname: @modules/configs/excel2json/lua_fishing_pool.lua

module("modules.configs.excel2json.lua_fishing_pool", package.seeall)

local lua_fishing_pool = {}
local fields = {
	item = 3,
	time = 4,
	id = 1,
	weight = 2,
	share_item = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fishing_pool.onLoad(json)
	lua_fishing_pool.configList, lua_fishing_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fishing_pool
