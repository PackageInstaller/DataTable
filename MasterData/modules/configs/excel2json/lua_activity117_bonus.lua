-- chunkname: @modules/configs/excel2json/lua_activity117_bonus.lua

module("modules.configs.excel2json.lua_activity117_bonus", package.seeall)

local lua_activity117_bonus = {}
local fields = {
	needScore = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity117_bonus.onLoad(json)
	lua_activity117_bonus.configList, lua_activity117_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity117_bonus
