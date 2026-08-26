-- chunkname: @modules/configs/excel2json/lua_auto_chess_level.lua

module("modules.configs.excel2json.lua_auto_chess_level", package.seeall)

local lua_auto_chess_level = {}
local fields = {
	collectionIds = 8,
	unlockCollectionIds = 7,
	unlockBossIds = 6,
	unlockCardpackIds = 5,
	exp = 3,
	bonus = 4,
	spMasterId = 9,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}

function lua_auto_chess_level.onLoad(json)
	lua_auto_chess_level.configList, lua_auto_chess_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_level
