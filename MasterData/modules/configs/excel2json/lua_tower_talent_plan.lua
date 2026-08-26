-- chunkname: @modules/configs/excel2json/lua_tower_talent_plan.lua

module("modules.configs.excel2json.lua_tower_talent_plan", package.seeall)

local lua_tower_talent_plan = {}
local fields = {
	bossId = 1,
	talentIds = 3,
	planId = 2,
	planName = 4
}
local primaryKey = {
	"bossId",
	"planId"
}
local mlStringKey = {
	planName = 1
}

function lua_tower_talent_plan.onLoad(json)
	lua_tower_talent_plan.configList, lua_tower_talent_plan.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_talent_plan
