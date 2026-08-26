-- chunkname: @modules/configs/excel2json/lua_atomic_map.lua

module("modules.configs.excel2json.lua_atomic_map", package.seeall)

local lua_atomic_map = {}
local fields = {
	maptype = 5,
	arenaId = 2,
	infoId = 4,
	id = 1,
	unlockCondition = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_atomic_map.onLoad(json)
	lua_atomic_map.configList, lua_atomic_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_map
