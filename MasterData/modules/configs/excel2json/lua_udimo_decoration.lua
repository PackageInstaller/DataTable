-- chunkname: @modules/configs/excel2json/lua_udimo_decoration.lua

module("modules.configs.excel2json.lua_udimo_decoration", package.seeall)

local lua_udimo_decoration = {}
local fields = {
	defaultUse = 5,
	name = 2,
	img = 3,
	id = 1,
	isDefault = 4,
	airPoints = 8,
	pos = 6,
	resource = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_udimo_decoration.onLoad(json)
	lua_udimo_decoration.configList, lua_udimo_decoration.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_decoration
