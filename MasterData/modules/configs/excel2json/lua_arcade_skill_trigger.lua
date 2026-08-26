-- chunkname: @modules/configs/excel2json/lua_arcade_skill_trigger.lua

module("modules.configs.excel2json.lua_arcade_skill_trigger", package.seeall)

local lua_arcade_skill_trigger = {}
local fields = {
	id = 1,
	effect = 4,
	condition = 2,
	triggerPoint = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_skill_trigger.onLoad(json)
	lua_arcade_skill_trigger.configList, lua_arcade_skill_trigger.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_skill_trigger
