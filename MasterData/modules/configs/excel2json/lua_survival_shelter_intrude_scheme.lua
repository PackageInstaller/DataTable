-- chunkname: @modules/configs/excel2json/lua_survival_shelter_intrude_scheme.lua

module("modules.configs.excel2json.lua_survival_shelter_intrude_scheme", package.seeall)

local lua_survival_shelter_intrude_scheme = {}
local fields = {
	id = 1,
	icon = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_shelter_intrude_scheme.onLoad(json)
	lua_survival_shelter_intrude_scheme.configList, lua_survival_shelter_intrude_scheme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_intrude_scheme
