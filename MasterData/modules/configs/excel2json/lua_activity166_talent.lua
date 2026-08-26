-- chunkname: @modules/configs/excel2json/lua_activity166_talent.lua

module("modules.configs.excel2json.lua_activity166_talent", package.seeall)

local lua_activity166_talent = {}
local fields = {
	activityId = 1,
	name = 3,
	baseSkillIds = 6,
	baseSkillIds2 = 7,
	sortIndex = 8,
	icon = 5,
	talentId = 2,
	nameEn = 4
}
local primaryKey = {
	"activityId",
	"talentId"
}
local mlStringKey = {
	nameEn = 2,
	name = 1
}

function lua_activity166_talent.onLoad(json)
	lua_activity166_talent.configList, lua_activity166_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_talent
