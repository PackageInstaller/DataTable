-- chunkname: @modules/configs/excel2json/lua_exclude_config.lua

module("modules.configs.excel2json.lua_exclude_config", package.seeall)

local lua_exclude_config = {}
local fields = {
	row_sel = 4,
	json_file = 3,
	mode = 5,
	params = 6,
	id = 1,
	version = 2,
	onornot = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_exclude_config.onLoad(json)
	lua_exclude_config.configList, lua_exclude_config.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_exclude_config
