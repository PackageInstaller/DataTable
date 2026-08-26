-- chunkname: @modules/configs/excel2json/lua_partygame_puzzle_pictures.lua

module("modules.configs.excel2json.lua_partygame_puzzle_pictures", package.seeall)

local lua_partygame_puzzle_pictures = {}
local fields = {
	id = 1,
	resource = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_puzzle_pictures.onLoad(json)
	lua_partygame_puzzle_pictures.configList, lua_partygame_puzzle_pictures.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_puzzle_pictures
