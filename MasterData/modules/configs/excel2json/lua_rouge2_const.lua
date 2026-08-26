-- chunkname: @modules/configs/excel2json/lua_rouge2_const.lua

module("modules.configs.excel2json.lua_rouge2_const", package.seeall)

local lua_rouge2_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_rouge2_const.onLoad(json)
	lua_rouge2_const.configList, lua_rouge2_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_const
