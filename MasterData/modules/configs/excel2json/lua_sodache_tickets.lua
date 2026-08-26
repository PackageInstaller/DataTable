-- chunkname: @modules/configs/excel2json/lua_sodache_tickets.lua

module("modules.configs.excel2json.lua_sodache_tickets", package.seeall)

local lua_sodache_tickets = {}
local fields = {
	tips = 3,
	name = 2,
	price = 5,
	skillIds = 6,
	id = 1,
	pic = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 2,
	name = 1
}

function lua_sodache_tickets.onLoad(json)
	lua_sodache_tickets.configList, lua_sodache_tickets.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_tickets
