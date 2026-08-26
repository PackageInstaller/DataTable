-- chunkname: @modules/configs/excel2json/lua_survival_shelter_invasion_fight.lua

module("modules.configs.excel2json.lua_survival_shelter_invasion_fight", package.seeall)

local lua_survival_shelter_invasion_fight = {}
local fields = {
	destructionLevel = 6,
	fightId = 2,
	schemeGroup = 5,
	id = 1,
	initSchemeGroup = 3,
	extraSchemeGroup = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_shelter_invasion_fight.onLoad(json)
	lua_survival_shelter_invasion_fight.configList, lua_survival_shelter_invasion_fight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_invasion_fight
