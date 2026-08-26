-- chunkname: @modules/configs/excel2json/lua_block_place_position.lua

module("modules.configs.excel2json.lua_block_place_position", package.seeall)

local lua_block_place_position = {}
local fields = {
	id = 1,
	z = 4,
	x = 2,
	y = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_block_place_position.onLoad(json)
	lua_block_place_position.configList, lua_block_place_position.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_block_place_position
