-- chunkname: @modules/configs/excel2json/lua_challenge_daily_unlock.lua

module("modules.configs.excel2json.lua_challenge_daily_unlock", package.seeall)

local lua_challenge_daily_unlock = {}
local fields = {
	groupId = 1,
	unlock = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_challenge_daily_unlock.onLoad(json)
	lua_challenge_daily_unlock.configList, lua_challenge_daily_unlock.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_daily_unlock
