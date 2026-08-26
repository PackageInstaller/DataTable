-- chunkname: @modules/configs/excel2json/lua_survival_recruit.lua

module("modules.configs.excel2json.lua_survival_recruit", package.seeall)

local lua_survival_recruit = {}
local fields = {
	showNum = 2,
	randomNum = 5,
	refreshCost = 4,
	chooseNum = 6,
	id = 1,
	cost = 8,
	refreshTimes = 3,
	unlock = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_recruit.onLoad(json)
	lua_survival_recruit.configList, lua_survival_recruit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_recruit
