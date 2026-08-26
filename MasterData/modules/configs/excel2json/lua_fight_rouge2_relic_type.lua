-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_relic_type.lua

module("modules.configs.excel2json.lua_fight_rouge2_relic_type", package.seeall)

local lua_fight_rouge2_relic_type = {}
local fields = {
	bigIcon = 3,
	color = 5,
	id = 1,
	icon = 4,
	progressIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_rouge2_relic_type.onLoad(json)
	lua_fight_rouge2_relic_type.configList, lua_fight_rouge2_relic_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_rouge2_relic_type
