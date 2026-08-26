-- chunkname: @modules/configs/excel2json/lua_tower_assist_attribute.lua

module("modules.configs.excel2json.lua_tower_assist_attribute", package.seeall)

local lua_tower_assist_attribute = {}
local fields = {
	bossId = 1,
	criDmg = 5,
	hp = 6,
	cri = 4,
	attack = 3,
	teamLevel = 2
}
local primaryKey = {
	"bossId",
	"teamLevel"
}
local mlStringKey = {}

function lua_tower_assist_attribute.onLoad(json)
	lua_tower_assist_attribute.configList, lua_tower_assist_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_assist_attribute
