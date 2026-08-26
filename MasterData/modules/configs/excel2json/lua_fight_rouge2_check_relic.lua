-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_check_relic.lua

module("modules.configs.excel2json.lua_fight_rouge2_check_relic", package.seeall)

local lua_fight_rouge2_check_relic = {}
local fields = {
	limit = 3,
	skill = 5,
	buff = 4,
	id = 1,
	attributeTag = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_rouge2_check_relic.onLoad(json)
	lua_fight_rouge2_check_relic.configList, lua_fight_rouge2_check_relic.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_rouge2_check_relic
