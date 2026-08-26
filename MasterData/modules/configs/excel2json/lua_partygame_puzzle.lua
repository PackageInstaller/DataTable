-- chunkname: @modules/configs/excel2json/lua_partygame_puzzle.lua

module("modules.configs.excel2json.lua_partygame_puzzle", package.seeall)

local lua_partygame_puzzle = {}
local fields = {
	id = 1,
	pictureIds = 3,
	answerTime = 2,
	exchange = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_puzzle.onLoad(json)
	lua_partygame_puzzle.configList, lua_partygame_puzzle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_puzzle
