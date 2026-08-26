-- chunkname: @modules/configs/excel2json/lua_assassin_interactive.lua

module("modules.configs.excel2json.lua_assassin_interactive", package.seeall)

local lua_assassin_interactive = {}
local fields = {
	gridId = 4,
	name = 2,
	missionId = 3,
	id = 1,
	costPoint = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_interactive.onLoad(json)
	lua_assassin_interactive.configList, lua_assassin_interactive.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_interactive
