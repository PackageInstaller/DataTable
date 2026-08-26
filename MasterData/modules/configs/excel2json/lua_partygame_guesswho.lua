-- chunkname: @modules/configs/excel2json/lua_partygame_guesswho.lua

module("modules.configs.excel2json.lua_partygame_guesswho", package.seeall)

local lua_partygame_guesswho = {}
local fields = {
	openType = 2,
	id = 1,
	answerTime = 4,
	pictureIds = 5,
	answerCount = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_guesswho.onLoad(json)
	lua_partygame_guesswho.configList, lua_partygame_guesswho.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_guesswho
