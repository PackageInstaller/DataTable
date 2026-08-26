-- chunkname: @modules/configs/excel2json/lua_activity191_ex_level.lua

module("modules.configs.excel2json.lua_activity191_ex_level", package.seeall)

local lua_activity191_ex_level = {}
local fields = {
	desc = 3,
	monsterId = 1,
	skillLevel = 2
}
local primaryKey = {
	"monsterId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}

function lua_activity191_ex_level.onLoad(json)
	lua_activity191_ex_level.configList, lua_activity191_ex_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_ex_level
