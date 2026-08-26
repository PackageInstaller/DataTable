-- chunkname: @modules/configs/excel2json/lua_fight_skill_delay.lua

module("modules.configs.excel2json.lua_fight_skill_delay", package.seeall)

local lua_fight_skill_delay = {}
local fields = {
	id = 1,
	delay = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_skill_delay.onLoad(json)
	lua_fight_skill_delay.configList, lua_fight_skill_delay.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skill_delay
