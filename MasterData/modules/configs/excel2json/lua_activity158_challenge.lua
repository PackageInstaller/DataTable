-- chunkname: @modules/configs/excel2json/lua_activity158_challenge.lua

module("modules.configs.excel2json.lua_activity158_challenge", package.seeall)

local lua_activity158_challenge = {}
local fields = {
	instructionDesc = 8,
	difficulty = 3,
	unlockCondition = 6,
	episodeId = 9,
	heroId = 7,
	id = 1,
	stage = 5,
	activityId = 2,
	sort = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	instructionDesc = 1
}

function lua_activity158_challenge.onLoad(json)
	lua_activity158_challenge.configList, lua_activity158_challenge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity158_challenge
