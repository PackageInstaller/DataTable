-- chunkname: @modules/configs/excel2json/lua_survival_storytask.lua

module("modules.configs.excel2json.lua_survival_storytask", package.seeall)

local lua_survival_storytask = {}
local fields = {
	id = 1,
	failCondition = 14,
	prepose = 13,
	dropShow = 17,
	desc4 = 9,
	title = 4,
	desc3 = 8,
	desc = 6,
	desc2 = 7,
	needAccept = 12,
	eventID = 5,
	maxProgress = 11,
	group = 2,
	progressCondition = 10,
	track = 18,
	uselessCondition = 15,
	autoDrop = 16,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc3 = 4,
	desc2 = 3,
	desc4 = 5,
	title = 1,
	desc = 2
}

function lua_survival_storytask.onLoad(json)
	lua_survival_storytask.configList, lua_survival_storytask.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_storytask
