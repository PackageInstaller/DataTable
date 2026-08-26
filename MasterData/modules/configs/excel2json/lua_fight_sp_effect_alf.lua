-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf", package.seeall)

local lua_fight_sp_effect_alf = {}
local fields = {
	pullOutRes = 4,
	resName = 1,
	audioId = 5,
	skinId = 2,
	residualRes = 3
}
local primaryKey = {
	"resName"
}
local mlStringKey = {}

function lua_fight_sp_effect_alf.onLoad(json)
	lua_fight_sp_effect_alf.configList, lua_fight_sp_effect_alf.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_alf
