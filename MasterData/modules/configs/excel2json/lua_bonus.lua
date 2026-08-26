-- chunkname: @modules/configs/excel2json/lua_bonus.lua

module("modules.configs.excel2json.lua_bonus", package.seeall)

local lua_bonus = {}
local fields = {
	dailyGainLimit = 2,
	fixBonus = 6,
	score = 5,
	heroExp = 3,
	id = 1,
	bonusView = 7,
	dailyGainWarning = 8,
	playerExp = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_bonus.onLoad(json)
	lua_bonus.configList, lua_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bonus
