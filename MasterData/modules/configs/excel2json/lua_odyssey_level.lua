-- chunkname: @modules/configs/excel2json/lua_odyssey_level.lua

module("modules.configs.excel2json.lua_odyssey_level", package.seeall)

local lua_odyssey_level = {}
local fields = {
	needExp = 2,
	reward = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_odyssey_level.onLoad(json)
	lua_odyssey_level.configList, lua_odyssey_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_level
