-- chunkname: @modules/configs/excel2json/lua_activity174_template.lua

module("modules.configs.excel2json.lua_activity174_template", package.seeall)

local lua_activity174_template = {}
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

function lua_activity174_template.onLoad(json)
	lua_activity174_template.configList, lua_activity174_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_template
