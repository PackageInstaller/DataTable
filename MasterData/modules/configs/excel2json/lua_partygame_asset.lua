-- chunkname: @modules/configs/excel2json/lua_partygame_asset.lua

module("modules.configs.excel2json.lua_partygame_asset", package.seeall)

local lua_partygame_asset = {}
local fields = {
	id = 1,
	filePath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_asset.onLoad(json)
	lua_partygame_asset.configList, lua_partygame_asset.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_asset
