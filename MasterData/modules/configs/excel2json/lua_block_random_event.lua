-- chunkname: @modules/configs/excel2json/lua_block_random_event.lua

module("modules.configs.excel2json.lua_block_random_event", package.seeall)

local lua_block_random_event = {}
local fields = {
	id = 1,
	blockCount = 2,
	event = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_block_random_event.onLoad(json)
	lua_block_random_event.configList, lua_block_random_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_block_random_event
