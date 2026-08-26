-- chunkname: @modules/configs/excel2json/lua_rouge2_piece_talk.lua

module("modules.configs.excel2json.lua_rouge2_piece_talk", package.seeall)

local lua_rouge2_piece_talk = {}
local fields = {
	title = 2,
	picture = 5,
	exitDesc = 6,
	id = 1,
	selectIds = 4,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	exitDesc = 2,
	title = 1
}

function lua_rouge2_piece_talk.onLoad(json)
	lua_rouge2_piece_talk.configList, lua_rouge2_piece_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_piece_talk
