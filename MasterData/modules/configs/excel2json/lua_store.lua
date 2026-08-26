-- chunkname: @modules/configs/excel2json/lua_store.lua

module("modules.configs.excel2json.lua_store", package.seeall)

local lua_store = {}
local fields = {
	id = 1,
	refreshCost = 3,
	autoRefreshTime = 2,
	needClearStore = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_store.onLoad(json)
	lua_store.configList, lua_store.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store
