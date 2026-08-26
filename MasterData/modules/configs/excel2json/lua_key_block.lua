-- chunkname: @modules/configs/excel2json/lua_key_block.lua

module("modules.configs.excel2json.lua_key_block", package.seeall)

local lua_key_block = {}
local fields = {
	name = 2,
	hud = 1,
	blockkey = 3
}
local primaryKey = {
	"hud"
}
local mlStringKey = {
	name = 1
}

function lua_key_block.onLoad(json)
	lua_key_block.configList, lua_key_block.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_key_block
