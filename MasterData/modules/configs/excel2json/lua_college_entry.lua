-- chunkname: @modules/configs/excel2json/lua_college_entry.lua

module("modules.configs.excel2json.lua_college_entry", package.seeall)

local lua_college_entry = {}
local fields = {
	id = 1,
	quality = 2,
	description = 4,
	tags = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 1
}

function lua_college_entry.onLoad(json)
	lua_college_entry.configList, lua_college_entry.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_entry
