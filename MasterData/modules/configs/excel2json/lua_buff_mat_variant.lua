-- chunkname: @modules/configs/excel2json/lua_buff_mat_variant.lua

module("modules.configs.excel2json.lua_buff_mat_variant", package.seeall)

local lua_buff_mat_variant = {}
local fields = {
	id = 1,
	variant = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_buff_mat_variant.onLoad(json)
	lua_buff_mat_variant.configList, lua_buff_mat_variant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_buff_mat_variant
