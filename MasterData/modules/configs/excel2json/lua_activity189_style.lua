-- chunkname: @modules/configs/excel2json/lua_activity189_style.lua

module("modules.configs.excel2json.lua_activity189_style", package.seeall)

local lua_activity189_style = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity189_style.onLoad(json)
	lua_activity189_style.configList, lua_activity189_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_style
