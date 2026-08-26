-- chunkname: @modules/configs/excel2json/lua_activity114_test.lua

module("modules.configs.excel2json.lua_activity114_test", package.seeall)

local lua_activity114_test = {}
local fields = {
	score = 8,
	topic = 4,
	result = 9,
	testId = 3,
	choice2 = 6,
	choice1 = 5,
	id = 2,
	activityId = 1,
	choice3 = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	topic = 1,
	choice2 = 3,
	choice3 = 4,
	choice1 = 2
}

function lua_activity114_test.onLoad(json)
	lua_activity114_test.configList, lua_activity114_test.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_test
