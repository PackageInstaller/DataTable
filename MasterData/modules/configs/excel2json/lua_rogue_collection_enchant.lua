-- chunkname: @modules/configs/excel2json/lua_rogue_collection_enchant.lua

module("modules.configs.excel2json.lua_rogue_collection_enchant", package.seeall)

local lua_rogue_collection_enchant = {}
local fields = {
	id = 1,
	name = 2,
	collectionID = 3,
	state = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rogue_collection_enchant.onLoad(json)
	lua_rogue_collection_enchant.configList, lua_rogue_collection_enchant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collection_enchant
