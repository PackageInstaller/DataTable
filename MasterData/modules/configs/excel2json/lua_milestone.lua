-- chunkname: @modules/configs/excel2json/lua_milestone.lua

module("modules.configs.excel2json.lua_milestone", package.seeall)

local lua_milestone = {}
local fields = {
	milestoneId = 1,
	isNotPush = 4,
	activityId = 2,
	type = 3
}
local primaryKey = {
	"milestoneId"
}
local mlStringKey = {}

function lua_milestone.onLoad(json)
	lua_milestone.configList, lua_milestone.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_milestone
