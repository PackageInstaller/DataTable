-- chunkname: @modules/configs/excel2json/lua_college_const.lua

module("modules.configs.excel2json.lua_college_const", package.seeall)

local lua_college_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}

function lua_college_const.onLoad(json)
	lua_college_const.configList, lua_college_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_const
