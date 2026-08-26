-- chunkname: @modules/configs/excel2json/lua_activity153.lua

module("modules.configs.excel2json.lua_activity153", package.seeall)

local lua_activity153 = {}
local fields = {
	activityId = 1,
	dailyLimit = 3,
	totalLimit = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity153.onLoad(json)
	lua_activity153.configList, lua_activity153.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity153
