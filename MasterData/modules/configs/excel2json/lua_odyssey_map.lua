-- chunkname: @modules/configs/excel2json/lua_odyssey_map.lua

module("modules.configs.excel2json.lua_odyssey_map", package.seeall)

local lua_odyssey_map = {}
local fields = {
	unlockCondition = 2,
	res = 3,
	mapName = 5,
	recommendLevel = 6,
	id = 1,
	initPos = 4,
	unlockDesc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	mapName = 1
}

function lua_odyssey_map.onLoad(json)
	lua_odyssey_map.configList, lua_odyssey_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_map
