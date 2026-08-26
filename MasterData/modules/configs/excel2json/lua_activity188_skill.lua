-- chunkname: @modules/configs/excel2json/lua_activity188_skill.lua

module("modules.configs.excel2json.lua_activity188_skill", package.seeall)

local lua_activity188_skill = {}
local fields = {
	param = 4,
	effect = 3,
	skillId = 2,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"skillId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity188_skill.onLoad(json)
	lua_activity188_skill.configList, lua_activity188_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_skill
