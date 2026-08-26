-- chunkname: @modules/configs/excel2json/lua_fight_luxi_skin_effect.lua

module("modules.configs.excel2json.lua_fight_luxi_skin_effect", package.seeall)

local lua_fight_luxi_skin_effect = {}
local fields = {
	effectDuration = 4,
	effect = 3,
	effectHangPoint = 5,
	audio = 6,
	id = 1,
	actionName = 2
}
local primaryKey = {
	"id",
	"actionName"
}
local mlStringKey = {}

function lua_fight_luxi_skin_effect.onLoad(json)
	lua_fight_luxi_skin_effect.configList, lua_fight_luxi_skin_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_luxi_skin_effect
