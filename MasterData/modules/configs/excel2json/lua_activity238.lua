-- chunkname: @modules/configs/excel2json/lua_activity238.lua

module("modules.configs.excel2json.lua_activity238", package.seeall)

local lua_activity238 = {}
local fields = {
	option3 = 8,
	option1 = 6,
	correctOption = 9,
	questionPictuer = 5,
	answer = 10,
	desc = 3,
	option2 = 7,
	questionMask = 4,
	id = 2,
	activityId = 1,
	bonus = 11
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	option3 = 4,
	answer = 5,
	option2 = 3,
	option1 = 2,
	desc = 1
}

function lua_activity238.onLoad(json)
	lua_activity238.configList, lua_activity238.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity238
