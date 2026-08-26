-- chunkname: @modules/configs/excel2json/lua_rogue_field.lua

module("modules.configs.excel2json.lua_rogue_field", package.seeall)

local lua_rogue_field = {}
local fields = {
	cost = 2,
	equipLevel = 6,
	level6 = 5,
	level4 = 3,
	level5 = 4,
	talentLevel = 7,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_rogue_field.onLoad(json)
	lua_rogue_field.configList, lua_rogue_field.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_field
