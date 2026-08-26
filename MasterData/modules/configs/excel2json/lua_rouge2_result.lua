-- chunkname: @modules/configs/excel2json/lua_rouge2_result.lua

module("modules.configs.excel2json.lua_rouge2_result", package.seeall)

local lua_rouge2_result = {}
local fields = {
	priority = 4,
	triggerParam = 6,
	type = 2,
	id = 1,
	trigger = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_result.onLoad(json)
	lua_rouge2_result.configList, lua_rouge2_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_result
