-- chunkname: @modules/configs/excel2json/lua_auto_fight_role_tool.lua

module("modules.configs.excel2json.lua_auto_fight_role_tool", package.seeall)

local lua_auto_fight_role_tool = {}
local fields = {
	equip = 5,
	exLv = 4,
	equipLv = 6,
	talentStyle = 9,
	destiny = 10,
	roleId = 2,
	talentLv = 8,
	equipExLv = 7,
	id = 1,
	lv = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_fight_role_tool.onLoad(json)
	lua_auto_fight_role_tool.configList, lua_auto_fight_role_tool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_fight_role_tool
