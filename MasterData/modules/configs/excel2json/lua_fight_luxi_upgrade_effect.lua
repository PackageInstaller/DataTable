-- chunkname: @modules/configs/excel2json/lua_fight_luxi_upgrade_effect.lua

module("modules.configs.excel2json.lua_fight_luxi_upgrade_effect", package.seeall)

local lua_fight_luxi_upgrade_effect = {}
local fields = {
	effect = 5,
	effectType = 3,
	buffId = 2,
	countOffset = 4,
	id = 1,
	effectHangPoint = 6,
	audio = 7
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_fight_luxi_upgrade_effect.onLoad(json)
	lua_fight_luxi_upgrade_effect.configList, lua_fight_luxi_upgrade_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_luxi_upgrade_effect
