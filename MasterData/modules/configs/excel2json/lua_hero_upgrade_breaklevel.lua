-- chunkname: @modules/configs/excel2json/lua_hero_upgrade_breaklevel.lua

module("modules.configs.excel2json.lua_hero_upgrade_breaklevel", package.seeall)

local lua_hero_upgrade_breaklevel = {}
local fields = {
	upgradeSkillId = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_hero_upgrade_breaklevel.onLoad(json)
	lua_hero_upgrade_breaklevel.configList, lua_hero_upgrade_breaklevel.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_upgrade_breaklevel
