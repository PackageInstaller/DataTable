-- chunkname: @modules/configs/excel2json/lua_fight_skill_force_use.lua

module("modules.configs.excel2json.lua_fight_skill_force_use", package.seeall)

local lua_fight_skill_force_use = {}
local fields = {
	order = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_fight_skill_force_use.onLoad(json)
	lua_fight_skill_force_use.configList, lua_fight_skill_force_use.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skill_force_use
