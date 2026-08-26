-- chunkname: @modules/configs/excel2json/lua_rouge2_entrust.lua

module("modules.configs.excel2json.lua_rouge2_entrust", package.seeall)

local lua_rouge2_entrust = {}
local fields = {
	param = 3,
	resultDesc = 5,
	type = 2,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	resultDesc = 2,
	desc = 1
}

function lua_rouge2_entrust.onLoad(json)
	lua_rouge2_entrust.configList, lua_rouge2_entrust.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_entrust
