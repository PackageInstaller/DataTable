-- chunkname: @modules/configs/excel2json/lua_auto_chess_cardpack.lua

module("modules.configs.excel2json.lua_auto_chess_cardpack", package.seeall)

local lua_auto_chess_cardpack = {}
local fields = {
	activityId = 1,
	name = 3,
	races = 10,
	sequence = 4,
	desc = 8,
	chessPool = 5,
	masterLibraryId = 6,
	id = 2,
	icon = 9,
	collectionPool = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_auto_chess_cardpack.onLoad(json)
	lua_auto_chess_cardpack.configList, lua_auto_chess_cardpack.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_cardpack
