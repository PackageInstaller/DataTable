-- chunkname: @modules/configs/excel2json/lua_fight_sswl_skill1_effect.lua

module("modules.configs.excel2json.lua_fight_sswl_skill1_effect", package.seeall)

local lua_fight_sswl_skill1_effect = {}
local fields = {
	id = 1,
	buffId = 2,
	timeline = 3
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_fight_sswl_skill1_effect.onLoad(json)
	lua_fight_sswl_skill1_effect.configList, lua_fight_sswl_skill1_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sswl_skill1_effect
