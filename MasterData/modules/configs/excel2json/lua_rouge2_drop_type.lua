-- chunkname: @modules/configs/excel2json/lua_rouge2_drop_type.lua

module("modules.configs.excel2json.lua_rouge2_drop_type", package.seeall)

local lua_rouge2_drop_type = {}
local fields = {
	id = 1,
	refreshCost = 3,
	selectCount = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_drop_type.onLoad(json)
	lua_rouge2_drop_type.configList, lua_rouge2_drop_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_drop_type
