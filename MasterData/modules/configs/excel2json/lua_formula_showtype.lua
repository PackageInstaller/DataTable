-- chunkname: @modules/configs/excel2json/lua_formula_showtype.lua

module("modules.configs.excel2json.lua_formula_showtype", package.seeall)

local lua_formula_showtype = {}
local fields = {
	nameEn = 4,
	name = 3,
	id = 1,
	icon = 5,
	buildingType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_formula_showtype.onLoad(json)
	lua_formula_showtype.configList, lua_formula_showtype.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_formula_showtype
