-- chunkname: @modules/configs/excel2json/lua_v3a8_warmup_play.lua

module("modules.configs.excel2json.lua_v3a8_warmup_play", package.seeall)

local lua_v3a8_warmup_play = {}
local fields = {
	issue = 3,
	op3 = 7,
	op2 = 6,
	answer = 4,
	op1 = 5,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	issue = 1,
	op1 = 2,
	op3 = 4,
	op2 = 3
}

function lua_v3a8_warmup_play.onLoad(json)
	lua_v3a8_warmup_play.configList, lua_v3a8_warmup_play.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a8_warmup_play
