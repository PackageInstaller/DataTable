-- chunkname: @modules/configs/excel2json/lua_skin_monster_scale.lua

module("modules.configs.excel2json.lua_skin_monster_scale", package.seeall)

local lua_skin_monster_scale = {}
local fields = {
	effectName = 3,
	monsterId = 2,
	scale = 4,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_skin_monster_scale.onLoad(json)
	lua_skin_monster_scale.configList, lua_skin_monster_scale.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_monster_scale
