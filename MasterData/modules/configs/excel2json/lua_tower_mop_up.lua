-- chunkname: @modules/configs/excel2json/lua_tower_mop_up.lua

module("modules.configs.excel2json.lua_tower_mop_up", package.seeall)

local lua_tower_mop_up = {}
local fields = {
	id = 1,
	reward = 3,
	layerNum = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_tower_mop_up.onLoad(json)
	lua_tower_mop_up.configList, lua_tower_mop_up.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_mop_up
