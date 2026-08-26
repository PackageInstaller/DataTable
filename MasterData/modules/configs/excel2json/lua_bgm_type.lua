-- chunkname: @modules/configs/excel2json/lua_bgm_type.lua

module("modules.configs.excel2json.lua_bgm_type", package.seeall)

local lua_bgm_type = {}
local fields = {
	id = 1,
	typename = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	typename = 1
}

function lua_bgm_type.onLoad(json)
	lua_bgm_type.configList, lua_bgm_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bgm_type
