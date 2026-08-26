-- chunkname: @modules/configs/excel2json/lua_rouge_piece_talk.lua

module("modules.configs.excel2json.lua_rouge_piece_talk", package.seeall)

local lua_rouge_piece_talk = {}
local fields = {
	title = 2,
	exitDesc = 5,
	id = 1,
	selectIds = 4,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1,
	content = 2,
	exitDesc = 3
}

function lua_rouge_piece_talk.onLoad(json)
	lua_rouge_piece_talk.configList, lua_rouge_piece_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_piece_talk
