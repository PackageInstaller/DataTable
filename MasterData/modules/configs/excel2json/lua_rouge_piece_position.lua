-- chunkname: @modules/configs/excel2json/lua_rouge_piece_position.lua

module("modules.configs.excel2json.lua_rouge_piece_position", package.seeall)

local lua_rouge_piece_position = {}
local fields = {
	layerId = 3,
	unlockParam = 5,
	version = 2,
	pieceRes = 8,
	talkId = 11,
	entrustType = 7,
	title = 9,
	desc = 10,
	unlockType = 4,
	talkView = 12,
	id = 1,
	icon = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_piece_position.onLoad(json)
	lua_rouge_piece_position.configList, lua_rouge_piece_position.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_piece_position
