-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_skill.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_skill", package.seeall)

local lua_activity_nuodika_180_skill = {}
local fields = {
	param = 3,
	effect = 2,
	scale = 5,
	skillId = 1,
	trigger = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_activity_nuodika_180_skill.onLoad(json)
	lua_activity_nuodika_180_skill.configList, lua_activity_nuodika_180_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_nuodika_180_skill
