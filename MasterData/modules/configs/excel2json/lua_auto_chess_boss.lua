-- chunkname: @modules/configs/excel2json/lua_auto_chess_boss.lua

module("modules.configs.excel2json.lua_auto_chess_boss", package.seeall)

local lua_auto_chess_boss = {}
local fields = {
	expBonus = 2,
	startBtnImage = 6,
	loadingImage = 5,
	id = 1,
	collectionBonus = 3,
	smallImage = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_boss.onLoad(json)
	lua_auto_chess_boss.configList, lua_auto_chess_boss.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_boss
