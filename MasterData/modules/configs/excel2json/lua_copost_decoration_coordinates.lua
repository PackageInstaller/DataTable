-- chunkname: @modules/configs/excel2json/lua_copost_decoration_coordinates.lua

module("modules.configs.excel2json.lua_copost_decoration_coordinates", package.seeall)

local lua_copost_decoration_coordinates = {}
local fields = {
	rotate = 4,
	coordinates = 2,
	id = 1,
	scale = 3,
	decorationId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_decoration_coordinates.onLoad(json)
	lua_copost_decoration_coordinates.configList, lua_copost_decoration_coordinates.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_decoration_coordinates
