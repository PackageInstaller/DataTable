-- chunkname: @modules/configs/excel2json/lua_survival_recruitment.lua

module("modules.configs.excel2json.lua_survival_recruitment", package.seeall)

local lua_survival_recruitment = {}
local fields = {
	id = 1,
	conditionType = 3,
	param = 4,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_recruitment.onLoad(json)
	lua_survival_recruitment.configList, lua_survival_recruitment.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_recruitment
