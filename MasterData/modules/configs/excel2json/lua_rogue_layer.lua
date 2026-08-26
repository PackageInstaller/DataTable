-- chunkname: @modules/configs/excel2json/lua_rogue_layer.lua

module("modules.configs.excel2json.lua_rogue_layer", package.seeall)

local lua_rogue_layer = {}
local fields = {
	attr = 3,
	difficulty = 1,
	layer = 2
}
local primaryKey = {
	"difficulty",
	"layer"
}
local mlStringKey = {}

function lua_rogue_layer.onLoad(json)
	lua_rogue_layer.configList, lua_rogue_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_layer
