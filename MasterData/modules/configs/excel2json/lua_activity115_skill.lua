-- chunkname: @modules/configs/excel2json/lua_activity115_skill.lua

module("modules.configs.excel2json.lua_activity115_skill", package.seeall)

local lua_activity115_skill = {}
local fields = {
	param = 4,
	name = 6,
	type = 3,
	id = 2,
	canUseCount = 5,
	activityId = 1,
	desc = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity115_skill.onLoad(json)
	lua_activity115_skill.configList, lua_activity115_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_skill
