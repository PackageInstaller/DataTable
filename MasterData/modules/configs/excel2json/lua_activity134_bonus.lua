-- chunkname: @modules/configs/excel2json/lua_activity134_bonus.lua

module("modules.configs.excel2json.lua_activity134_bonus", package.seeall)

local lua_activity134_bonus = {}
local fields = {
	showTab = 5,
	introduce = 8,
	desc = 7,
	id = 2,
	bonus = 10,
	title = 6,
	number = 3,
	needTokens = 11,
	storyType = 4,
	activityId = 1,
	due = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 3,
	introduce = 4,
	due = 5,
	title = 2,
	number = 1
}

function lua_activity134_bonus.onLoad(json)
	lua_activity134_bonus.configList, lua_activity134_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity134_bonus
