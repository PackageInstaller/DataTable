-- chunkname: @modules/configs/excel2json/lua_activity101_sp_bonus.lua

module("modules.configs.excel2json.lua_activity101_sp_bonus", package.seeall)

local lua_activity101_sp_bonus = {}
local fields = {
	canGetSignInDays = 6,
	taskDesc = 3,
	canGetDate = 5,
	id = 2,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	taskDesc = 1
}

function lua_activity101_sp_bonus.onLoad(json)
	lua_activity101_sp_bonus.configList, lua_activity101_sp_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity101_sp_bonus
