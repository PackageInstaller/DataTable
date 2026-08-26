-- chunkname: @modules/configs/excel2json/lua_survival_subtask.lua

module("modules.configs.excel2json.lua_survival_subtask", package.seeall)

local lua_survival_subtask = {}
local fields = {
	jump = 17,
	failCondition = 14,
	maintaskChange = 7,
	dropShow = 16,
	prepose = 13,
	type = 4,
	autoDrop = 15,
	desc = 8,
	desc2 = 9,
	needAccept = 12,
	maxProgress = 11,
	versions = 6,
	group = 2,
	progressCondition = 10,
	seasons = 5,
	id = 1,
	step = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc = 1
}

function lua_survival_subtask.onLoad(json)
	lua_survival_subtask.configList, lua_survival_subtask.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_subtask
