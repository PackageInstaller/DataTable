-- chunkname: @modules/configs/excel2json/lua_activity128_bosstype.lua

module("modules.configs.excel2json.lua_activity128_bosstype", package.seeall)

local lua_activity128_bosstype = {}
local fields = {
	mintype = 1,
	name = 3,
	sort = 2
}
local primaryKey = {
	"mintype"
}
local mlStringKey = {
	name = 1
}

function lua_activity128_bosstype.onLoad(json)
	lua_activity128_bosstype.configList, lua_activity128_bosstype.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_bosstype
