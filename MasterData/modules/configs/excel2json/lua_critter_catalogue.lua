-- chunkname: @modules/configs/excel2json/lua_critter_catalogue.lua

module("modules.configs.excel2json.lua_critter_catalogue", package.seeall)

local lua_critter_catalogue = {}
local fields = {
	parentId = 3,
	name = 4,
	type = 2,
	id = 1,
	baseCard = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_critter_catalogue.onLoad(json)
	lua_critter_catalogue.configList, lua_critter_catalogue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_catalogue
