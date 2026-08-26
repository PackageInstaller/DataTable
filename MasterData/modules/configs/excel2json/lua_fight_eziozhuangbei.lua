-- chunkname: @modules/configs/excel2json/lua_fight_eziozhuangbei.lua

module("modules.configs.excel2json.lua_fight_eziozhuangbei", package.seeall)

local lua_fight_eziozhuangbei = {}
local fields = {
	skillEx = 9,
	passiveSkill = 6,
	firstId = 1,
	secondId = 2,
	skillGroup1 = 7,
	skillGroup2 = 8,
	skillLevel = 3,
	secondDesc = 5,
	firstDesc = 4,
	exchangeSkills = 10
}
local primaryKey = {
	"firstId",
	"secondId",
	"skillLevel"
}
local mlStringKey = {
	secondDesc = 2,
	firstDesc = 1
}

function lua_fight_eziozhuangbei.onLoad(json)
	lua_fight_eziozhuangbei.configList, lua_fight_eziozhuangbei.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_eziozhuangbei
