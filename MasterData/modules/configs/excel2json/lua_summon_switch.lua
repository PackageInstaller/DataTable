-- chunkname: @modules/configs/excel2json/lua_summon_switch.lua

module("modules.configs.excel2json.lua_summon_switch", package.seeall)

local lua_summon_switch = {}
local fields = {
	itemId = 3,
	previewIcon = 5,
	resName = 6,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_summon_switch.onLoad(json)
	lua_summon_switch.configList, lua_summon_switch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_switch
