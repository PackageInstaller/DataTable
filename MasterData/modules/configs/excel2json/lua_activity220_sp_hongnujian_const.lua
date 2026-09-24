-- chunkname: @modules/configs/excel2json/lua_activity220_sp_hongnujian_const.lua

module("modules.configs.excel2json.lua_activity220_sp_hongnujian_const", package.seeall)

local lua_activity220_sp_hongnujian_const = {}
local fields = {
	id = 1,
	name = 2,
	value = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_sp_hongnujian_const.onLoad(json)
	lua_activity220_sp_hongnujian_const.configList, lua_activity220_sp_hongnujian_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_sp_hongnujian_const
