-- chunkname: @modules/configs/excel2json/lua_rouge2_material.lua

module("modules.configs.excel2json.lua_rouge2_material", package.seeall)

local lua_rouge2_material = {}
local fields = {
	name = 4,
	details = 6,
	type = 2,
	rare = 3,
	effects = 8,
	numMax = 9,
	formula = 7,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	details = 2,
	name = 1
}

function lua_rouge2_material.onLoad(json)
	lua_rouge2_material.configList, lua_rouge2_material.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_material
