-- chunkname: @modules/configs/excel2json/lua_activity143_bonus.lua

module("modules.configs.excel2json.lua_activity143_bonus", package.seeall)

local lua_activity143_bonus = {}
local fields = {
	bonus = 3,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}

function lua_activity143_bonus.onLoad(json)
	lua_activity143_bonus.configList, lua_activity143_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity143_bonus
