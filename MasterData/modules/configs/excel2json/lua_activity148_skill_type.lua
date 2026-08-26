-- chunkname: @modules/configs/excel2json/lua_activity148_skill_type.lua

module("modules.configs.excel2json.lua_activity148_skill_type", package.seeall)

local lua_activity148_skill_type = {}
local fields = {
	skillInfoDesc = 4,
	skillIcon = 5,
	skillValueDesc = 3,
	skillNameEn = 6,
	id = 1,
	skillName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillInfoDesc = 3,
	skillName = 1,
	skillValueDesc = 2,
	skillNameEn = 5,
	skillIcon = 4
}

function lua_activity148_skill_type.onLoad(json)
	lua_activity148_skill_type.configList, lua_activity148_skill_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity148_skill_type
