-- chunkname: @modules/configs/excel2json/lua_rogue_collection_group.lua

module("modules.configs.excel2json.lua_rogue_collection_group", package.seeall)

local lua_rogue_collection_group = {}
local fields = {
	id = 1,
	num = 2,
	dropGroupType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	dropGroupType = 1
}

function lua_rogue_collection_group.onLoad(json)
	lua_rogue_collection_group.configList, lua_rogue_collection_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collection_group
