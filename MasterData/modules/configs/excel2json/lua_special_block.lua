-- chunkname: @modules/configs/excel2json/lua_special_block.lua

module("modules.configs.excel2json.lua_special_block", package.seeall)

local lua_special_block = {}
local fields = {
	name = 2,
	sources = 8,
	useDesc = 3,
	duplicateItem = 11,
	age = 10,
	rare = 6,
	desc = 4,
	heroId = 9,
	id = 1,
	icon = 5,
	nameEn = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_special_block.onLoad(json)
	lua_special_block.configList, lua_special_block.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_special_block
