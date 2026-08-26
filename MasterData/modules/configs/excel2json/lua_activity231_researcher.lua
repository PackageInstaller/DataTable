-- chunkname: @modules/configs/excel2json/lua_activity231_researcher.lua

module("modules.configs.excel2json.lua_activity231_researcher", package.seeall)

local lua_activity231_researcher = {}
local fields = {
	cost = 9,
	name = 5,
	settleTimes = 11,
	quality = 3,
	skillIds = 12,
	unlockCondition = 4,
	image2 = 8,
	image1 = 7,
	id = 2,
	icon = 6,
	activityId = 1,
	attribute = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity231_researcher.onLoad(json)
	lua_activity231_researcher.configList, lua_activity231_researcher.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_researcher
