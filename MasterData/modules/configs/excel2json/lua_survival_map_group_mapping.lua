-- chunkname: @modules/configs/excel2json/lua_survival_map_group_mapping.lua

module("modules.configs.excel2json.lua_survival_map_group_mapping", package.seeall)

local lua_survival_map_group_mapping = {}
local fields = {
	id = 2,
	mapId = 1
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}

function lua_survival_map_group_mapping.onLoad(json)
	lua_survival_map_group_mapping.configList, lua_survival_map_group_mapping.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_map_group_mapping
