-- chunkname: @modules/configs/excel2json/lua_activity168_compose_type.lua

module("modules.configs.excel2json.lua_activity168_compose_type", package.seeall)

local lua_activity168_compose_type = {}
local fields = {
	name = 3,
	composeType = 2,
	activityId = 1,
	costItems = 4
}
local primaryKey = {
	"activityId",
	"composeType"
}
local mlStringKey = {
	name = 1
}

function lua_activity168_compose_type.onLoad(json)
	lua_activity168_compose_type.configList, lua_activity168_compose_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_compose_type
