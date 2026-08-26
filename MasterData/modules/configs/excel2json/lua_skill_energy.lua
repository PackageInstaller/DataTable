-- chunkname: @modules/configs/excel2json/lua_skill_energy.lua

module("modules.configs.excel2json.lua_skill_energy", package.seeall)

local lua_skill_energy = {}
local fields = {
	energyType = 3,
	name = 2,
	count = 4,
	id = 1,
	isSpecialCard = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_skill_energy.onLoad(json)
	lua_skill_energy.configList, lua_skill_energy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_energy
