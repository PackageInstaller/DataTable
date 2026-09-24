-- chunkname: @modules/configs/excel2json/lua_auto_chess_composite_selector.lua

module("modules.configs.excel2json.lua_auto_chess_composite_selector", package.seeall)

local lua_auto_chess_composite_selector = {}
local fields = {
	id = 1,
	param = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_composite_selector.onLoad(json)
	lua_auto_chess_composite_selector.configList, lua_auto_chess_composite_selector.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_composite_selector
