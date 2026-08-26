-- chunkname: @modules/configs/excel2json/lua_rouge2_fight_group.lua

module("modules.configs.excel2json.lua_rouge2_fight_group", package.seeall)

local lua_rouge2_fight_group = {}
local fields = {
	id = 1,
	battleWeighId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_fight_group.onLoad(json)
	lua_rouge2_fight_group.configList, lua_rouge2_fight_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_fight_group
