-- chunkname: @modules/configs/excel2json/lua_auto_chess_round.lua

module("modules.configs.excel2json.lua_auto_chess_round", package.seeall)

local lua_auto_chess_round = {}
local fields = {
	activityId = 1,
	assess = 5,
	maxdamage = 4,
	starReward = 6,
	round = 2,
	previewCost = 3
}
local primaryKey = {
	"activityId",
	"round"
}
local mlStringKey = {}

function lua_auto_chess_round.onLoad(json)
	lua_auto_chess_round.configList, lua_auto_chess_round.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_round
