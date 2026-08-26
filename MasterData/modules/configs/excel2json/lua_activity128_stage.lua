-- chunkname: @modules/configs/excel2json/lua_activity128_stage.lua

module("modules.configs.excel2json.lua_activity128_stage", package.seeall)

local lua_activity128_stage = {}
local fields = {
	activityId = 1,
	name = 5,
	version = 3,
	type = 7,
	maxPoints = 8,
	bossRushLevelDetailFullBgSimage = 13,
	bossRushMainBg = 12,
	bossRushMainItemBossSprite = 11,
	name_en = 6,
	skinOffsetXYs = 19,
	resultViewNameSImage = 15,
	layer4MaxPoints = 9,
	stage = 2,
	skinIds = 16,
	openDay = 10,
	heartVariantId = 17,
	skinScales = 18,
	resultViewFullBgSImage = 14,
	isActivity = 4
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	name = 1
}

function lua_activity128_stage.onLoad(json)
	lua_activity128_stage.configList, lua_activity128_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_stage
