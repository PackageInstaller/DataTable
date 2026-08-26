-- chunkname: @modules/configs/excel2json/lua_activity128_evaluate.lua

module("modules.configs.excel2json.lua_activity128_evaluate", package.seeall)

local lua_activity128_evaluate = {}
local fields = {
	id = 1,
	name = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity128_evaluate.onLoad(json)
	lua_activity128_evaluate.configList, lua_activity128_evaluate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_evaluate
