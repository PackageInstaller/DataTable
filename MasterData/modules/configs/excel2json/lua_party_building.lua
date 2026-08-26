-- chunkname: @modules/configs/excel2json/lua_party_building.lua

module("modules.configs.excel2json.lua_party_building", package.seeall)

local lua_party_building = {}
local fields = {
	scenePath = 6,
	name = 2,
	id = 1,
	icon = 5,
	pos = 4,
	enName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_party_building.onLoad(json)
	lua_party_building.configList, lua_party_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_building
