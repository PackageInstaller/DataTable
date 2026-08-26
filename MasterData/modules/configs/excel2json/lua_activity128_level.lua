-- chunkname: @modules/configs/excel2json/lua_activity128_level.lua

module("modules.configs.excel2json.lua_activity128_level", package.seeall)

local lua_activity128_level = {}
local fields = {
	bonus = 5,
	spLevelBg = 4,
	levelBg = 3,
	needExp = 2,
	playerLevel = 1
}
local primaryKey = {
	"playerLevel"
}
local mlStringKey = {}

function lua_activity128_level.onLoad(json)
	lua_activity128_level.configList, lua_activity128_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_level
