-- chunkname: @modules/configs/excel2json/lua_activity244_skill_effect.lua

module("modules.configs.excel2json.lua_activity244_skill_effect", package.seeall)

local lua_activity244_skill_effect = {}
local fields = {
	type = 2,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}

function lua_activity244_skill_effect.onLoad(json)
	lua_activity244_skill_effect.configList, lua_activity244_skill_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_effect
