-- chunkname: @modules/configs/excel2json/lua_rouge_risk.lua

module("modules.configs.excel2json.lua_rouge_risk", package.seeall)

local lua_rouge_risk = {}
local fields = {
	buffNum = 7,
	range = 4,
	scoreReward = 8,
	title = 2,
	content = 6,
	desc = 5,
	title_en = 3,
	id = 1,
	viewDown = 10,
	attr = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	content = 4,
	desc = 3
}

function lua_rouge_risk.onLoad(json)
	lua_rouge_risk.configList, lua_rouge_risk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_risk
