-- chunkname: @modules/configs/excel2json/lua_rouge2_piece.lua

module("modules.configs.excel2json.lua_rouge2_piece", package.seeall)

local lua_rouge2_piece = {}
local fields = {
	entrustType = 2,
	talkId = 6,
	pieceRes = 3,
	id = 1,
	title = 4,
	bossEffect = 7,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge2_piece.onLoad(json)
	lua_rouge2_piece.configList, lua_rouge2_piece.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_piece
