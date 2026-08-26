-- chunkname: @modules/configs/excel2json/lua_activity200_setting.lua

module("modules.configs.excel2json.lua_activity200_setting", package.seeall)

local lua_activity200_setting = {}
local fields = {
	detial = 3,
	size = 2,
	activityId = 1,
	failText = 4
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	failText = 2,
	detial = 1
}

function lua_activity200_setting.onLoad(json)
	lua_activity200_setting.configList, lua_activity200_setting.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity200_setting
