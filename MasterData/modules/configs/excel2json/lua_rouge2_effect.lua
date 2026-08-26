-- chunkname: @modules/configs/excel2json/lua_rouge2_effect.lua

module("modules.configs.excel2json.lua_rouge2_effect", package.seeall)

local lua_rouge2_effect = {}
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

function lua_rouge2_effect.onLoad(json)
	lua_rouge2_effect.configList, lua_rouge2_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_effect
