-- chunkname: @modules/configs/excel2json/lua_activity128_tag.lua

module("modules.configs.excel2json.lua_activity128_tag", package.seeall)

local lua_activity128_tag = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity128_tag.onLoad(json)
	lua_activity128_tag.configList, lua_activity128_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_tag
