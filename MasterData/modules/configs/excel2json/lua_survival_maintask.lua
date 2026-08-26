-- chunkname: @modules/configs/excel2json/lua_survival_maintask.lua

module("modules.configs.excel2json.lua_survival_maintask", package.seeall)

local lua_survival_maintask = {}
local fields = {
	versions = 5,
	failCondition = 13,
	prepose = 12,
	maintaskChange = 6,
	group = 2,
	progressCondition = 9,
	autoDrop = 14,
	desc = 7,
	dropShow = 15,
	desc2 = 8,
	needAccept = 11,
	seasons = 4,
	id = 1,
	maxProgress = 10,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc = 1
}

function lua_survival_maintask.onLoad(json)
	lua_survival_maintask.configList, lua_survival_maintask.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_maintask
