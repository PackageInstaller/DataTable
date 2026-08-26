-- chunkname: @modules/configs/excel2json/lua_auto_chess_effect.lua

module("modules.configs.excel2json.lua_auto_chess_effect", package.seeall)

local lua_auto_chess_effect = {}
local fields = {
	tag = 2,
	subtag = 3,
	nameDown = 5,
	type = 6,
	target = 9,
	offset = 11,
	nameUp = 4,
	duration = 12,
	loop = 8,
	playertype = 7,
	soundId = 13,
	id = 1,
	position = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_effect.onLoad(json)
	lua_auto_chess_effect.configList, lua_auto_chess_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_effect
