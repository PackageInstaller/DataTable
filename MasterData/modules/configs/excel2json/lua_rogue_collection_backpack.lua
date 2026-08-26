-- chunkname: @modules/configs/excel2json/lua_rogue_collection_backpack.lua

module("modules.configs.excel2json.lua_rogue_collection_backpack", package.seeall)

local lua_rogue_collection_backpack = {}
local fields = {
	id = 1,
	layout = 2,
	initialCollection = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_collection_backpack.onLoad(json)
	lua_rogue_collection_backpack.configList, lua_rogue_collection_backpack.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collection_backpack
