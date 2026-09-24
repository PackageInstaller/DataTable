-- chunkname: @modules/configs/excel2json/lua_activity244_skill_buff.lua

module("modules.configs.excel2json.lua_activity244_skill_buff", package.seeall)

local lua_activity244_skill_buff = {}
local fields = {
	id = 1,
	buffEffectType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_skill_buff.onLoad(json)
	lua_activity244_skill_buff.configList, lua_activity244_skill_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_skill_buff
