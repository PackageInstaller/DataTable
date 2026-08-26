-- chunkname: @modules/configs/excel2json/lua_activity101_dragonboat.lua

module("modules.configs.excel2json.lua_activity101_dragonboat", package.seeall)

local lua_activity101_dragonboat = {}
local fields = {
	desc = 4,
	name = 3,
	dayicon = 5,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity101_dragonboat.onLoad(json)
	lua_activity101_dragonboat.configList, lua_activity101_dragonboat.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity101_dragonboat
