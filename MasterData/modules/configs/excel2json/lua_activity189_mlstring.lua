-- chunkname: @modules/configs/excel2json/lua_activity189_mlstring.lua

module("modules.configs.excel2json.lua_activity189_mlstring", package.seeall)

local lua_activity189_mlstring = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 1
}

function lua_activity189_mlstring.onLoad(json)
	lua_activity189_mlstring.configList, lua_activity189_mlstring.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_mlstring
