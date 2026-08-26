-- chunkname: @modules/configs/excel2json/lua_assassin_act.lua

module("modules.configs.excel2json.lua_assassin_act", package.seeall)

local lua_assassin_act = {}
local fields = {
	param = 8,
	name = 2,
	icon = 3,
	type = 7,
	id = 1,
	effectId = 10,
	desc = 9,
	audioId = 5,
	power = 6,
	showImg = 4,
	targetEffectId = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_assassin_act.onLoad(json)
	lua_assassin_act.configList, lua_assassin_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_act
