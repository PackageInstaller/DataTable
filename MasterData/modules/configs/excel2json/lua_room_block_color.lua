-- chunkname: @modules/configs/excel2json/lua_room_block_color.lua

module("modules.configs.excel2json.lua_room_block_color", package.seeall)

local lua_room_block_color = {}
local fields = {
	voucherId = 3,
	blockId = 2,
	blockColor = 1
}
local primaryKey = {
	"blockColor"
}
local mlStringKey = {}

function lua_room_block_color.onLoad(json)
	lua_room_block_color.configList, lua_room_block_color.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_block_color
