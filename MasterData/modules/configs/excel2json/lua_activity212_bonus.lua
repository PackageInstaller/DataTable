-- chunkname: @modules/configs/excel2json/lua_activity212_bonus.lua

module("modules.configs.excel2json.lua_activity212_bonus", package.seeall)

local lua_activity212_bonus = {}
local fields = {
	id = 2,
	packsId = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity212_bonus.onLoad(json)
	lua_activity212_bonus.configList, lua_activity212_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity212_bonus
