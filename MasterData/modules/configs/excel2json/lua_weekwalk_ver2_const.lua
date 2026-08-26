-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_const.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_const", package.seeall)

local lua_weekwalk_ver2_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_ver2_const.onLoad(json)
	lua_weekwalk_ver2_const.configList, lua_weekwalk_ver2_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2_const
