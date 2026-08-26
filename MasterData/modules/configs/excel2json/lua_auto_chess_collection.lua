-- chunkname: @modules/configs/excel2json/lua_auto_chess_collection.lua

module("modules.configs.excel2json.lua_auto_chess_collection", package.seeall)

local lua_auto_chess_collection = {}
local fields = {
	isSp = 9,
	name = 2,
	skilldesc = 5,
	id = 1,
	passiveChessSkills = 4,
	image = 8,
	quality = 10,
	desc = 3,
	tag = 6,
	weight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skilldesc = 3,
	desc = 2
}

function lua_auto_chess_collection.onLoad(json)
	lua_auto_chess_collection.configList, lua_auto_chess_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_collection
