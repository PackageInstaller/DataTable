-- chunkname: @modules/configs/excel2json/lua_survival_maptarget.lua

module("modules.configs.excel2json.lua_survival_maptarget", package.seeall)

local lua_survival_maptarget = {}
local fields = {
	desc = 4,
	failCondition = 12,
	prepose = 11,
	dropShow = 15,
	group = 2,
	progressCondition = 8,
	uselessCondition = 13,
	showInExplore = 7,
	track = 16,
	desc2 = 6,
	needAccept = 10,
	maxProgress = 9,
	id = 1,
	icon = 5,
	autoDrop = 14,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc = 1
}

function lua_survival_maptarget.onLoad(json)
	lua_survival_maptarget.configList, lua_survival_maptarget.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_maptarget
