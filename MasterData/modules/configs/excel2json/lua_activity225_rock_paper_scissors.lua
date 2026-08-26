-- chunkname: @modules/configs/excel2json/lua_activity225_rock_paper_scissors.lua

module("modules.configs.excel2json.lua_activity225_rock_paper_scissors", package.seeall)

local lua_activity225_rock_paper_scissors = {}
local fields = {
	winBonus = 3,
	loseBonus = 5,
	drawBonus = 4,
	activityId = 1,
	times = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity225_rock_paper_scissors.onLoad(json)
	lua_activity225_rock_paper_scissors.configList, lua_activity225_rock_paper_scissors.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_rock_paper_scissors
