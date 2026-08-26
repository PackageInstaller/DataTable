-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti.lua

module("modules.configs.excel2json.lua_activity161_graffiti", package.seeall)

local lua_activity161_graffiti = {}
local fields = {
	dialogGroupId = 7,
	subElementIds = 6,
	activityId = 1,
	finishRate = 9,
	mainElementCd = 5,
	picture = 8,
	finishTitle = 12,
	finishDesc = 13,
	elementId = 2,
	preMainElementIds = 4,
	finishTitleEn = 14,
	brushSize = 10,
	mainElementId = 3,
	sort = 11
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {
	finishDesc = 2,
	finishTitle = 1
}

function lua_activity161_graffiti.onLoad(json)
	lua_activity161_graffiti.configList, lua_activity161_graffiti.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity161_graffiti
