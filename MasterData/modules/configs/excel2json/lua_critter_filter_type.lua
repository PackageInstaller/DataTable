-- chunkname: @modules/configs/excel2json/lua_critter_filter_type.lua

module("modules.configs.excel2json.lua_critter_filter_type", package.seeall)

local lua_critter_filter_type = {}
local fields = {
	tabIcon = 6,
	name = 2,
	tabName = 5,
	id = 1,
	filterTab = 4,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tabName = 2,
	name = 1
}

function lua_critter_filter_type.onLoad(json)
	lua_critter_filter_type.configList, lua_critter_filter_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_filter_type
