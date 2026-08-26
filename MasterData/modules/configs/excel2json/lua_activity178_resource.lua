-- chunkname: @modules/configs/excel2json/lua_activity178_resource.lua

module("modules.configs.excel2json.lua_activity178_resource", package.seeall)

local lua_activity178_resource = {}
local fields = {
	tips = 5,
	name = 3,
	id = 2,
	icon = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	tips = 2,
	name = 1
}

function lua_activity178_resource.onLoad(json)
	lua_activity178_resource.configList, lua_activity178_resource.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_resource
