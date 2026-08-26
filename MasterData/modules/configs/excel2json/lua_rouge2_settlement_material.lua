-- chunkname: @modules/configs/excel2json/lua_rouge2_settlement_material.lua

module("modules.configs.excel2json.lua_rouge2_settlement_material", package.seeall)

local lua_rouge2_settlement_material = {}
local fields = {
	score = 2,
	materialGroup = 4,
	materialNum = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_settlement_material.onLoad(json)
	lua_rouge2_settlement_material.configList, lua_rouge2_settlement_material.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_settlement_material
