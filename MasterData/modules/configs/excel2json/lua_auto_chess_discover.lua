-- chunkname: @modules/configs/excel2json/lua_auto_chess_discover.lua

module("modules.configs.excel2json.lua_auto_chess_discover", package.seeall)

local lua_auto_chess_discover = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_discover.onLoad(json)
	lua_auto_chess_discover.configList, lua_auto_chess_discover.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_discover
