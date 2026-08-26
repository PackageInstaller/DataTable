-- chunkname: @modules/configs/excel2json/lua_activity144_round.lua

module("modules.configs.excel2json.lua_activity144_round", package.seeall)

local lua_activity144_round = {}
local fields = {
	isPass = 4,
	keepMaterialRate = 6,
	round = 3,
	name = 7,
	actionPoint = 5,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId",
	"round"
}
local mlStringKey = {
	name = 1
}

function lua_activity144_round.onLoad(json)
	lua_activity144_round.configList, lua_activity144_round.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_round
