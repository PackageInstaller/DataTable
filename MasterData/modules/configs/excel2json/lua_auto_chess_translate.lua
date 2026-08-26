-- chunkname: @modules/configs/excel2json/lua_auto_chess_translate.lua

module("modules.configs.excel2json.lua_auto_chess_translate", package.seeall)

local lua_auto_chess_translate = {}
local fields = {
	id = 1,
	name = 2,
	tagResName = 4,
	color = 3,
	isShow = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_translate.onLoad(json)
	lua_auto_chess_translate.configList, lua_auto_chess_translate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_translate
