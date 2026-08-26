-- chunkname: @modules/configs/excel2json/lua_bp.lua

module("modules.configs.excel2json.lua_bp", package.seeall)

local lua_bp = {}
local fields = {
	isSp = 17,
	name = 7,
	chargeId2 = 3,
	bpSkinEnNametxt = 12,
	bpviewicon = 13,
	payStatus2Bonus = 6,
	chargeId1 = 2,
	promptDays = 20,
	activityId = 21,
	bpId = 1,
	showBonusDate = 16,
	specialBonus = 22,
	chargeId1to2 = 4,
	bpviewpos = 14,
	showBonus = 15,
	weekLimitTimes = 18,
	specialPropDesc = 23,
	bpSkinDesc = 10,
	bpSkinNametxt = 11,
	expLevelUp = 9,
	payStatus1Bonus = 5,
	payStatus2AddLevel = 8,
	expUpShow = 19
}
local primaryKey = {
	"bpId"
}
local mlStringKey = {
	bpSkinNametxt = 3,
	name = 1,
	specialPropDesc = 4,
	bpSkinDesc = 2
}

function lua_bp.onLoad(json)
	lua_bp.configList, lua_bp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp
