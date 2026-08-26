-- chunkname: @modules/configs/excel2json/lua_survival_fight_level.lua

module("modules.configs.excel2json.lua_survival_fight_level", package.seeall)

local lua_survival_fight_level = {}
local fields = {
	id = 1,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_fight_level.onLoad(json)
	lua_survival_fight_level.configList, lua_survival_fight_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_fight_level
