-- chunkname: @modules/configs/excel2json/lua_fight_dnsz.lua

module("modules.configs.excel2json.lua_fight_dnsz", package.seeall)

local lua_fight_dnsz = {}
local fields = {
	id = 2,
	progress = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_fight_dnsz.onLoad(json)
	lua_fight_dnsz.configList, lua_fight_dnsz.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_dnsz
