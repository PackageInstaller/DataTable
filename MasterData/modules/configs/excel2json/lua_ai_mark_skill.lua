-- chunkname: @modules/configs/excel2json/lua_ai_mark_skill.lua

module("modules.configs.excel2json.lua_ai_mark_skill", package.seeall)

local lua_ai_mark_skill = {}
local fields = {
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_ai_mark_skill.onLoad(json)
	lua_ai_mark_skill.configList, lua_ai_mark_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_ai_mark_skill
