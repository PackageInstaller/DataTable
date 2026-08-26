-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_piece.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_piece", package.seeall)

local lua_activity220_wmz_map_piece = {}
local fields = {
	id = 1,
	mapId = 2,
	pieceMinY = 5,
	pieceMaxX = 6,
	pieceMinX = 4,
	pieceMaxY = 7,
	pieceResNamePrefix = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_wmz_map_piece.onLoad(json)
	lua_activity220_wmz_map_piece.configList, lua_activity220_wmz_map_piece.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_map_piece
