-- chunkname: @modules/configs/excel2json/lua_activity_center.lua

module("modules.configs.excel2json.lua_activity_center", package.seeall)

local lua_activity_center = {}
local fields = {
	sortPriority = 5,
	name = 2,
	id = 1,
	reddotid = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity_center.onLoad(json)
	lua_activity_center.configList, lua_activity_center.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_center
