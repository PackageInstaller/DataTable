-- chunkname: @modules/configs/excel2json/lua_odyssey_level_suppress.lua

module("modules.configs.excel2json.lua_odyssey_level_suppress", package.seeall)

local lua_odyssey_level_suppress = {}
local fields = {
	id = 1,
	hiddenRule = 3,
	levelDifference = 2,
	tips = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}

function lua_odyssey_level_suppress.onLoad(json)
	lua_odyssey_level_suppress.configList, lua_odyssey_level_suppress.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_level_suppress
