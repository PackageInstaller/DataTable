-- chunkname: @modules/configs/excel2json/lua_retro_item_convert.lua

module("modules.configs.excel2json.lua_retro_item_convert", package.seeall)

local lua_retro_item_convert = {}
local fields = {
	itemId = 2,
	limit = 3,
	version = 5,
	typeId = 1,
	price = 4
}
local primaryKey = {
	"typeId",
	"itemId"
}
local mlStringKey = {}

function lua_retro_item_convert.onLoad(json)
	lua_retro_item_convert.configList, lua_retro_item_convert.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_retro_item_convert
