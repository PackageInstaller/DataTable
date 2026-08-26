-- chunkname: @modules/configs/excel2json/lua_backpack.lua

module("modules.configs.excel2json.lua_backpack", package.seeall)

local lua_backpack = {}
local fields = {
	includecurrency = 5,
	name = 2,
	includeitem = 4,
	subname = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_backpack.onLoad(json)
	lua_backpack.configList, lua_backpack.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_backpack
