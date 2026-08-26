-- chunkname: @modules/configs/excel2json/lua_specialexpired_item.lua

module("modules.configs.excel2json.lua_specialexpired_item", package.seeall)

local lua_specialexpired_item = {}
local fields = {
	expireTime = 7,
	name = 2,
	useDesc = 8,
	expireType = 6,
	effect = 10,
	sources = 11,
	rare = 4,
	desc = 9,
	id = 1,
	icon = 3,
	highQuality = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_specialexpired_item.onLoad(json)
	lua_specialexpired_item.configList, lua_specialexpired_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_specialexpired_item
