-- chunkname: @modules/configs/excel2json/lua_fight_summoned_stance.lua

module("modules.configs.excel2json.lua_fight_summoned_stance", package.seeall)

local lua_fight_summoned_stance = {}
local fields = {
	pos3 = 4,
	pos1 = 2,
	pos2 = 3,
	id = 1,
	pos4 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_summoned_stance.onLoad(json)
	lua_fight_summoned_stance.configList, lua_fight_summoned_stance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_summoned_stance
