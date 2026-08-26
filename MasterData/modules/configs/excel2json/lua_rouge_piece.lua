-- chunkname: @modules/configs/excel2json/lua_rouge_piece.lua

module("modules.configs.excel2json.lua_rouge_piece", package.seeall)

local lua_rouge_piece = {}
local fields = {
	version = 2,
	title = 5,
	talkId = 7,
	pieceRes = 4,
	id = 1,
	entrustType = 3,
	bossEffect = 8,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_piece.onLoad(json)
	lua_rouge_piece.configList, lua_rouge_piece.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_piece
