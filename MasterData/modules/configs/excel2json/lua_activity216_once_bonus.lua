-- chunkname: @modules/configs/excel2json/lua_activity216_once_bonus.lua

module("modules.configs.excel2json.lua_activity216_once_bonus", package.seeall)

local lua_activity216_once_bonus = {}
local fields = {
	bonus = 3,
	activityId = 1,
	needFinishTaskNum = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity216_once_bonus.onLoad(json)
	lua_activity216_once_bonus.configList, lua_activity216_once_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity216_once_bonus
