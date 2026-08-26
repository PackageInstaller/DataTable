-- chunkname: @modules/configs/excel2json/lua_challenge_badge.lua

module("modules.configs.excel2json.lua_challenge_badge", package.seeall)

local lua_challenge_badge = {}
local fields = {
	rule = 3,
	unlockSupport = 5,
	num = 2,
	activityId = 1,
	decs = 4
}
local primaryKey = {
	"activityId",
	"num"
}
local mlStringKey = {
	decs = 1
}

function lua_challenge_badge.onLoad(json)
	lua_challenge_badge.configList, lua_challenge_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_badge
