-- chunkname: @modules/configs/excel2json/lua_activity114_feature.lua

module("modules.configs.excel2json.lua_activity114_feature", package.seeall)

local lua_activity114_feature = {}
local fields = {
	verifyNum = 5,
	inheritable = 9,
	attributeNum = 6,
	courseEfficiency = 7,
	desc = 4,
	restEfficiency = 8,
	id = 2,
	features = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	features = 1
}

function lua_activity114_feature.onLoad(json)
	lua_activity114_feature.configList, lua_activity114_feature.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_feature
