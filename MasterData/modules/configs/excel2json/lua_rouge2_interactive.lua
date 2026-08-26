-- chunkname: @modules/configs/excel2json/lua_rouge2_interactive.lua

module("modules.configs.excel2json.lua_rouge2_interactive", package.seeall)

local lua_rouge2_interactive = {}
local fields = {
	tips = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_interactive.onLoad(json)
	lua_rouge2_interactive.configList, lua_rouge2_interactive.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_interactive
