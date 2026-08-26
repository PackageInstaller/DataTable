-- chunkname: @modules/configs/excel2json/lua_activity191_relation_select.lua

module("modules.configs.excel2json.lua_activity191_relation_select", package.seeall)

local lua_activity191_relation_select = {}
local fields = {
	tag = 2,
	sortIndex = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"tag"
}
local mlStringKey = {}

function lua_activity191_relation_select.onLoad(json)
	lua_activity191_relation_select.configList, lua_activity191_relation_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_relation_select
