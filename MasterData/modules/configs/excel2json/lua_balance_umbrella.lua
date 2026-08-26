-- chunkname: @modules/configs/excel2json/lua_balance_umbrella.lua

module("modules.configs.excel2json.lua_balance_umbrella", package.seeall)

local lua_balance_umbrella = {}
local fields = {
	players = 5,
	name = 3,
	id = 1,
	episode = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	players = 3,
	name = 1,
	desc = 2
}

function lua_balance_umbrella.onLoad(json)
	lua_balance_umbrella.configList, lua_balance_umbrella.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_balance_umbrella
