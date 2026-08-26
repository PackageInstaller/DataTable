-- chunkname: @modules/configs/excel2json/lua_auto_chess_function.lua

module("modules.configs.excel2json.lua_auto_chess_function", package.seeall)

local lua_auto_chess_function = {}
local fields = {
	id = 1,
	functionOn = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_function.onLoad(json)
	lua_auto_chess_function.configList, lua_auto_chess_function.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_function
