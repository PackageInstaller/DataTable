-- chunkname: @modules/configs/excel2json/lua_activity163_evidence.lua

module("modules.configs.excel2json.lua_activity163_evidence", package.seeall)

local lua_activity163_evidence = {}
local fields = {
	evidenceId = 1,
	showFusion = 7,
	tips = 6,
	errorTip = 5,
	conditionStr = 4,
	puzzleTxt = 3,
	dialogGroupType = 2
}
local primaryKey = {
	"evidenceId"
}
local mlStringKey = {
	conditionStr = 2,
	puzzleTxt = 1
}

function lua_activity163_evidence.onLoad(json)
	lua_activity163_evidence.configList, lua_activity163_evidence.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_evidence
