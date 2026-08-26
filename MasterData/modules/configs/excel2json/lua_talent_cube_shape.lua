-- chunkname: @modules/configs/excel2json/lua_talent_cube_shape.lua

module("modules.configs.excel2json.lua_talent_cube_shape", package.seeall)

local lua_talent_cube_shape = {}
local fields = {
	id = 1,
	shape = 2,
	icon = 4,
	sort = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_talent_cube_shape.onLoad(json)
	lua_talent_cube_shape.configList, lua_talent_cube_shape.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_cube_shape
