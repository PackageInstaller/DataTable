-- chunkname: @modules/configs/excel2json/lua_magic_dnsz.lua

module("modules.configs.excel2json.lua_magic_dnsz", package.seeall)

local lua_magic_dnsz = {}
local fields = {
	id = 2,
	progress = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_magic_dnsz.onLoad(json)
	lua_magic_dnsz.configList, lua_magic_dnsz.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_magic_dnsz
