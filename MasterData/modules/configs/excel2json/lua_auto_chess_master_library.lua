-- chunkname: @modules/configs/excel2json/lua_auto_chess_master_library.lua

module("modules.configs.excel2json.lua_auto_chess_master_library", package.seeall)

local lua_auto_chess_master_library = {}
local fields = {
	id = 1,
	masterId = 2,
	weight = 3
}
local primaryKey = {
	"id",
	"masterId"
}
local mlStringKey = {}

function lua_auto_chess_master_library.onLoad(json)
	lua_auto_chess_master_library.configList, lua_auto_chess_master_library.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_master_library
