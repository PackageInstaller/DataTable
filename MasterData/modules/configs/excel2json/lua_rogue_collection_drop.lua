-- chunkname: @modules/configs/excel2json/lua_rogue_collection_drop.lua

module("modules.configs.excel2json.lua_rogue_collection_drop", package.seeall)

local lua_rogue_collection_drop = {}
local fields = {
	groupId = 2,
	id = 1,
	weights = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}

function lua_rogue_collection_drop.onLoad(json)
	lua_rogue_collection_drop.configList, lua_rogue_collection_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collection_drop
