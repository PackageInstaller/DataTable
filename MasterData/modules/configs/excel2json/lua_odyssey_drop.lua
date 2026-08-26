-- chunkname: @modules/configs/excel2json/lua_odyssey_drop.lua

module("modules.configs.excel2json.lua_odyssey_drop", package.seeall)

local lua_odyssey_drop = {}
local fields = {
	id = 1,
	dropRare = 2,
	dropNum = 4,
	dropSuit = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_odyssey_drop.onLoad(json)
	lua_odyssey_drop.configList, lua_odyssey_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_drop
