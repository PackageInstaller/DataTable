-- chunkname: @modules/configs/excel2json/lua_rouge2_outside_const.lua

module("modules.configs.excel2json.lua_rouge2_outside_const", package.seeall)

local lua_rouge2_outside_const = {}
local fields = {
	value = 2,
	id = 1,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_outside_const.onLoad(json)
	lua_rouge2_outside_const.configList, lua_rouge2_outside_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_outside_const
