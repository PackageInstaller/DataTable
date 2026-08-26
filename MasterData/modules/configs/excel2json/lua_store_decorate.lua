-- chunkname: @modules/configs/excel2json/lua_store_decorate.lua

module("modules.configs.excel2json.lua_store_decorate", package.seeall)

local lua_store_decorate = {}
local fields = {
	originalCost1 = 15,
	video = 12,
	smalllmg = 9,
	decorateskinOffset = 18,
	storeld = 2,
	maxbuycountType = 8,
	typeName = 5,
	desc = 6,
	biglmg = 10,
	subType = 4,
	linkTag = 23,
	tag1 = 14,
	decorateskinl2dOffset = 19,
	productType = 3,
	showskinId = 21,
	buylmg = 11,
	offTag = 17,
	tag2 = 22,
	rare = 7,
	effectbiglmg = 20,
	originalCost2 = 16,
	onlineTag = 13,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag1 = 3,
	typeName = 1,
	desc = 2
}

function lua_store_decorate.onLoad(json)
	lua_store_decorate.configList, lua_store_decorate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_decorate
