-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_level.lua

module("modules.configs.excel2json.lua_fight_rouge2_level", package.seeall)

local lua_fight_rouge2_level = {}
local fields = {
	id = 1,
	icon = 4,
	rare = 2,
	bgIcon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_rouge2_level.onLoad(json)
	lua_fight_rouge2_level.configList, lua_fight_rouge2_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_rouge2_level
