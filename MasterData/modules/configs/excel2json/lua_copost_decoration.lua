-- chunkname: @modules/configs/excel2json/lua_copost_decoration.lua

module("modules.configs.excel2json.lua_copost_decoration", package.seeall)

local lua_copost_decoration = {}
local fields = {
	id = 1,
	decoration = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_decoration.onLoad(json)
	lua_copost_decoration.configList, lua_copost_decoration.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_decoration
