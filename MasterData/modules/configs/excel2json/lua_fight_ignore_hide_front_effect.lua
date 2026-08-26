-- chunkname: @modules/configs/excel2json/lua_fight_ignore_hide_front_effect.lua

module("modules.configs.excel2json.lua_fight_ignore_hide_front_effect", package.seeall)

local lua_fight_ignore_hide_front_effect = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_ignore_hide_front_effect.onLoad(json)
	lua_fight_ignore_hide_front_effect.configList, lua_fight_ignore_hide_front_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ignore_hide_front_effect
