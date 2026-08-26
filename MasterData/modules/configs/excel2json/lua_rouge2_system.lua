-- chunkname: @modules/configs/excel2json/lua_rouge2_system.lua

module("modules.configs.excel2json.lua_rouge2_system", package.seeall)

local lua_rouge2_system = {}
local fields = {
	color = 5,
	bg = 6,
	recommendAttribute = 3,
	visible = 8,
	id = 1,
	icon = 2,
	bgColor = 7,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_system.onLoad(json)
	lua_rouge2_system.configList, lua_rouge2_system.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_system
