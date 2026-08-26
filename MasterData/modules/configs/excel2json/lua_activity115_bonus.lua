-- chunkname: @modules/configs/excel2json/lua_activity115_bonus.lua

module("modules.configs.excel2json.lua_activity115_bonus", package.seeall)

local lua_activity115_bonus = {}
local fields = {
	bonus = 4,
	important = 5,
	id = 2,
	activityId = 1,
	needScore = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity115_bonus.onLoad(json)
	lua_activity115_bonus.configList, lua_activity115_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_bonus
