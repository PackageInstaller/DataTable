-- chunkname: @modules/configs/excel2json/lua_activity133_bonus.lua

module("modules.configs.excel2json.lua_activity133_bonus", package.seeall)

local lua_activity133_bonus = {}
local fields = {
	finalBonus = 9,
	title = 3,
	pos = 8,
	desc = 4,
	needTokens = 7,
	id = 2,
	icon = 5,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_activity133_bonus.onLoad(json)
	lua_activity133_bonus.configList, lua_activity133_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity133_bonus
