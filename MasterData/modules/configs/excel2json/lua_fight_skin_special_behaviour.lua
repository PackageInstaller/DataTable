-- chunkname: @modules/configs/excel2json/lua_fight_skin_special_behaviour.lua

module("modules.configs.excel2json.lua_fight_skin_special_behaviour", package.seeall)

local lua_fight_skin_special_behaviour = {}
local fields = {
	id = 1,
	freeze = 4,
	die = 3,
	hit = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_skin_special_behaviour.onLoad(json)
	lua_fight_skin_special_behaviour.configList, lua_fight_skin_special_behaviour.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skin_special_behaviour
