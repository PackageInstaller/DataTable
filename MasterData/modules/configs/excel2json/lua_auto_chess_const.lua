-- chunkname: @modules/configs/excel2json/lua_auto_chess_const.lua

module("modules.configs.excel2json.lua_auto_chess_const", package.seeall)

local lua_auto_chess_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_const.onLoad(json)
	lua_auto_chess_const.configList, lua_auto_chess_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_const
