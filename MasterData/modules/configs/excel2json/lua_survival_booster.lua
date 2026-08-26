-- chunkname: @modules/configs/excel2json/lua_survival_booster.lua

module("modules.configs.excel2json.lua_survival_booster", package.seeall)

local lua_survival_booster = {}
local fields = {
	id = 1,
	name = 2,
	tag = 6,
	effectDesc = 3,
	icon = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1,
	desc = 3
}

function lua_survival_booster.onLoad(json)
	lua_survival_booster.configList, lua_survival_booster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_booster
