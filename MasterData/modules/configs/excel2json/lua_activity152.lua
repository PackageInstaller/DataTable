-- chunkname: @modules/configs/excel2json/lua_activity152.lua

module("modules.configs.excel2json.lua_activity152", package.seeall)

local lua_activity152 = {}
local fields = {
	presentName = 3,
	presentId = 2,
	roleNameEn = 8,
	presentIcon = 4,
	bonus = 10,
	acceptDate = 11,
	roleName = 7,
	roleIcon = 6,
	dialog = 9,
	activityId = 1,
	presentSign = 5
}
local primaryKey = {
	"activityId",
	"presentId"
}
local mlStringKey = {
	roleName = 2,
	presentName = 1,
	dialog = 3
}

function lua_activity152.onLoad(json)
	lua_activity152.configList, lua_activity152.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity152
