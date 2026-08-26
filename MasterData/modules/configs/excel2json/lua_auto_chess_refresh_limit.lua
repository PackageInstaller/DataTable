-- chunkname: @modules/configs/excel2json/lua_auto_chess_refresh_limit.lua

module("modules.configs.excel2json.lua_auto_chess_refresh_limit", package.seeall)

local lua_auto_chess_refresh_limit = {}
local fields = {
	id = 1,
	maxRefreshLimit = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_refresh_limit.onLoad(json)
	lua_auto_chess_refresh_limit.configList, lua_auto_chess_refresh_limit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_refresh_limit
