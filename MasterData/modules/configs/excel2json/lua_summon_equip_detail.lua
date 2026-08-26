-- chunkname: @modules/configs/excel2json/lua_summon_equip_detail.lua

module("modules.configs.excel2json.lua_summon_equip_detail", package.seeall)

local lua_summon_equip_detail = {}
local fields = {
	texture = 4,
	texturePoster = 5,
	equipId = 3,
	location = 6,
	id = 1,
	poolId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_summon_equip_detail.onLoad(json)
	lua_summon_equip_detail.configList, lua_summon_equip_detail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_equip_detail
