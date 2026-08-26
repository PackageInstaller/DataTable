-- chunkname: @modules/configs/excel2json/lua_auto_chess_rank.lua

module("modules.configs.excel2json.lua_auto_chess_rank", package.seeall)

local lua_auto_chess_rank = {}
local fields = {
	reward = 8,
	name = 4,
	protection = 5,
	score = 6,
	rankId = 2,
	isShow = 9,
	maxRound = 10,
	icon = 3,
	activityId = 1,
	round2Score = 7
}
local primaryKey = {
	"activityId",
	"rankId"
}
local mlStringKey = {
	name = 1
}

function lua_auto_chess_rank.onLoad(json)
	lua_auto_chess_rank.configList, lua_auto_chess_rank.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_rank
