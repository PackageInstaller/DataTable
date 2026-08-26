-- chunkname: @modules/configs/excel2json/lua_activity191_template.lua

module("modules.configs.excel2json.lua_activity191_template", package.seeall)

local lua_activity191_template = {}
local fields = {
	defense = 4,
	id = 1,
	technic = 6,
	life = 2,
	attack = 3,
	mdefense = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity191_template.onLoad(json)
	lua_activity191_template.configList, lua_activity191_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_template
