-- chunkname: @modules/configs/excel2json/lua_auto_chess_round_score.lua

module("modules.configs.excel2json.lua_auto_chess_round_score", package.seeall)

local lua_auto_chess_round_score = {}
local fields = {
	score = 2,
	rankId = 1,
	mult = 3
}
local primaryKey = {
	"rankId"
}
local mlStringKey = {}

function lua_auto_chess_round_score.onLoad(json)
	lua_auto_chess_round_score.configList, lua_auto_chess_round_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_round_score
