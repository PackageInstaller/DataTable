-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall.lua

module("modules.configs.excel2json.lua_auto_chess_mall", package.seeall)

local lua_auto_chess_mall = {}
local fields = {
	groups = 5,
	capacity = 6,
	showLevel = 4,
	type = 2,
	id = 1,
	canRefresh = 7,
	round = 3,
	isFree = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_mall.onLoad(json)
	lua_auto_chess_mall.configList, lua_auto_chess_mall.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_mall
