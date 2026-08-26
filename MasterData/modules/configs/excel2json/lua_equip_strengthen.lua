-- chunkname: @modules/configs/excel2json/lua_equip_strengthen.lua

module("modules.configs.excel2json.lua_equip_strengthen", package.seeall)

local lua_equip_strengthen = {}
local fields = {
	strengthType = 1,
	def = 4,
	hp = 2,
	atk = 3,
	mdef = 5
}
local primaryKey = {
	"strengthType"
}
local mlStringKey = {}

function lua_equip_strengthen.onLoad(json)
	lua_equip_strengthen.configList, lua_equip_strengthen.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_strengthen
