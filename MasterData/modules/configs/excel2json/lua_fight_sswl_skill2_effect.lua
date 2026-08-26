-- chunkname: @modules/configs/excel2json/lua_fight_sswl_skill2_effect.lua

module("modules.configs.excel2json.lua_fight_sswl_skill2_effect", package.seeall)

local lua_fight_sswl_skill2_effect = {}
local fields = {
	id = 1,
	count = 2,
	timeline = 3
}
local primaryKey = {
	"id",
	"count"
}
local mlStringKey = {}

function lua_fight_sswl_skill2_effect.onLoad(json)
	lua_fight_sswl_skill2_effect.configList, lua_fight_sswl_skill2_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sswl_skill2_effect
