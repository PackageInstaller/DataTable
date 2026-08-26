-- chunkname: @modules/configs/excel2json/lua_activity101_doublefestival.lua

module("modules.configs.excel2json.lua_activity101_doublefestival", package.seeall)

local lua_activity101_doublefestival = {}
local fields = {
	blessTitle = 5,
	blessContent = 7,
	blessTitleEn = 6,
	btnDesc = 4,
	blessDesc = 8,
	blessContentType = 10,
	day = 2,
	bgSpriteName = 3,
	activityId = 1,
	blessSpriteName = 9
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	btnDesc = 2,
	bgSpriteName = 1,
	blessContent = 5,
	blessDesc = 6,
	blessTitle = 3,
	blessContentType = 8,
	blessTitleEn = 4,
	blessSpriteName = 7
}

function lua_activity101_doublefestival.onLoad(json)
	lua_activity101_doublefestival.configList, lua_activity101_doublefestival.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity101_doublefestival
