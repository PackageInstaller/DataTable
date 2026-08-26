-- chunkname: @modules/configs/excel2json/lua_rouge2_entrust_desc.lua

module("modules.configs.excel2json.lua_rouge2_entrust_desc", package.seeall)

local lua_rouge2_entrust_desc = {}
local fields = {
	id = 1,
	finishDesc = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	finishDesc = 2,
	desc = 1
}

function lua_rouge2_entrust_desc.onLoad(json)
	lua_rouge2_entrust_desc.configList, lua_rouge2_entrust_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_entrust_desc
