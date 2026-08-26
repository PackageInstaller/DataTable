-- chunkname: @modules/configs/excel2json/lua_survival_found.lua

module("modules.configs.excel2json.lua_survival_found", package.seeall)

local lua_survival_found = {}
local fields = {
	id = 1,
	desc = 3,
	tagMax = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_found.onLoad(json)
	lua_survival_found.configList, lua_survival_found.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_found
