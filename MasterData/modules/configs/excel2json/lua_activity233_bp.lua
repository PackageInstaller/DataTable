-- chunkname: @modules/configs/excel2json/lua_activity233_bp.lua

module("modules.configs.excel2json.lua_activity233_bp", package.seeall)

local lua_activity233_bp = {}
local fields = {
	unlockPremiumCost = 4,
	bpId = 1,
	activityId = 2,
	expLevelUp = 3
}
local primaryKey = {
	"bpId"
}
local mlStringKey = {}

function lua_activity233_bp.onLoad(json)
	lua_activity233_bp.configList, lua_activity233_bp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity233_bp
