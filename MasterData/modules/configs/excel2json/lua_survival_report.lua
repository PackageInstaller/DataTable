-- chunkname: @modules/configs/excel2json/lua_survival_report.lua

module("modules.configs.excel2json.lua_survival_report", package.seeall)

local lua_survival_report = {}
local fields = {
	priority = 4,
	img = 5,
	type = 2,
	id = 1,
	condition = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_report.onLoad(json)
	lua_survival_report.configList, lua_survival_report.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_report
