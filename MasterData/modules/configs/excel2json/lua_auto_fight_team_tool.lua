-- chunkname: @modules/configs/excel2json/lua_auto_fight_team_tool.lua

module("modules.configs.excel2json.lua_auto_fight_team_tool", package.seeall)

local lua_auto_fight_team_tool = {}
local fields = {
	position3 = 5,
	name = 2,
	position2 = 4,
	id = 1,
	position1 = 3,
	position4 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_fight_team_tool.onLoad(json)
	lua_auto_fight_team_tool.configList, lua_auto_fight_team_tool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_fight_team_tool
