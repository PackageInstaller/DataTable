-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_unit_type.lua

module("modules.configs.excel2json.lua_activity220_lamona_unit_type", package.seeall)

local lua_activity220_lamona_unit_type = {}
local fields = {
	resName = 2,
	id = 1,
	layer = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_lamona_unit_type.onLoad(json)
	lua_activity220_lamona_unit_type.configList, lua_activity220_lamona_unit_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lamona_unit_type
