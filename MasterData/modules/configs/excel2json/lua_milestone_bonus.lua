-- chunkname: @modules/configs/excel2json/lua_milestone_bonus.lua

module("modules.configs.excel2json.lua_milestone_bonus", package.seeall)

local lua_milestone_bonus = {}
local fields = {
	needProgress = 3,
	special = 5,
	bonusId = 2,
	milestoneId = 1,
	bonus = 4
}
local primaryKey = {
	"milestoneId",
	"bonusId"
}
local mlStringKey = {}

function lua_milestone_bonus.onLoad(json)
	lua_milestone_bonus.configList, lua_milestone_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_milestone_bonus
