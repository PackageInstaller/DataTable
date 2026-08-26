-- chunkname: @modules/configs/excel2json/lua_ai_monster_target.lua

module("modules.configs.excel2json.lua_ai_monster_target", package.seeall)

local lua_ai_monster_target = {}
local fields = {
	id = 1,
	targetNumber = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_ai_monster_target.onLoad(json)
	lua_ai_monster_target.configList, lua_ai_monster_target.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_ai_monster_target
