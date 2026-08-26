-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_time.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_time", package.seeall)

local lua_weekwalk_ver2_time = {}
local fields = {
	ruleFront = 5,
	ruleRear = 6,
	issueId = 2,
	ruleIcon = 4,
	optionalSkills = 3,
	timeId = 1
}
local primaryKey = {
	"timeId"
}
local mlStringKey = {}

function lua_weekwalk_ver2_time.onLoad(json)
	lua_weekwalk_ver2_time.configList, lua_weekwalk_ver2_time.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2_time
