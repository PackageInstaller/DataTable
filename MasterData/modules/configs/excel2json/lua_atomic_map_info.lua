-- chunkname: @modules/configs/excel2json/lua_atomic_map_info.lua

module("modules.configs.excel2json.lua_atomic_map_info", package.seeall)

local lua_atomic_map_info = {}
local fields = {
	initPos = 3,
	res = 2,
	lightRot = 5,
	type = 9,
	unlockDesc = 8,
	lightColor = 6,
	mapName = 7,
	id = 1,
	initRot = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	mapName = 1
}

function lua_atomic_map_info.onLoad(json)
	lua_atomic_map_info.configList, lua_atomic_map_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_map_info
