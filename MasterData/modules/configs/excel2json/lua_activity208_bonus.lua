-- chunkname: @modules/configs/excel2json/lua_activity208_bonus.lua

module("modules.configs.excel2json.lua_activity208_bonus", package.seeall)

local lua_activity208_bonus = {}
local fields = {
	id = 2,
	isAllBonus = 3,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity208_bonus.onLoad(json)
	lua_activity208_bonus.configList, lua_activity208_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity208_bonus
