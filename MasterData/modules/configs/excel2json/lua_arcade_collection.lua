-- chunkname: @modules/configs/excel2json/lua_arcade_collection.lua

module("modules.configs.excel2json.lua_arcade_collection", package.seeall)

local lua_arcade_collection = {}
local fields = {
	scale = 14,
	describe = 4,
	price = 12,
	type = 3,
	name = 2,
	showTmpAttrChange = 7,
	passiveSkills = 6,
	dropWeight = 11,
	icon = 17,
	resPath = 13,
	level = 8,
	goodsWeight = 9,
	posOffset = 15,
	category = 16,
	id = 1,
	isUnique = 10,
	durable = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	describe = 2,
	name = 1
}

function lua_arcade_collection.onLoad(json)
	lua_arcade_collection.configList, lua_arcade_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_collection
