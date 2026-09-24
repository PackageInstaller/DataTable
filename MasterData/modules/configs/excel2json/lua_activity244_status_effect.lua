-- chunkname: @modules/configs/excel2json/lua_activity244_status_effect.lua

module("modules.configs.excel2json.lua_activity244_status_effect", package.seeall)

local lua_activity244_status_effect = {}
local fields = {
	durationType = 4,
	statusId = 1,
	targetType = 3,
	defaultDuration = 5,
	stackRule = 6,
	statusKey = 2,
	removeRule = 7,
	desc = 8
}
local primaryKey = {
	"statusId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity244_status_effect.onLoad(json)
	lua_activity244_status_effect.configList, lua_activity244_status_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_status_effect
