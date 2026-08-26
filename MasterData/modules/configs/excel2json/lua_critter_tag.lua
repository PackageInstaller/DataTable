-- chunkname: @modules/configs/excel2json/lua_critter_tag.lua

module("modules.configs.excel2json.lua_critter_tag", package.seeall)

local lua_critter_tag = {}
local fields = {
	id = 1,
	name = 7,
	inheritance = 10,
	type = 2,
	group = 3,
	luckyItemIds = 12,
	luckyItemType = 11,
	desc = 8,
	effects = 9,
	needAttributeLevel = 4,
	skillIcon = 5,
	filterTag = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_critter_tag.onLoad(json)
	lua_critter_tag.configList, lua_critter_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_tag
