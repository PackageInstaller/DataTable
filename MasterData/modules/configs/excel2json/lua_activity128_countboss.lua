-- chunkname: @modules/configs/excel2json/lua_activity128_countboss.lua

module("modules.configs.excel2json.lua_activity128_countboss", package.seeall)

local lua_activity128_countboss = {}
local fields = {
	battleId = 1,
	monsterId = 2,
	maxPoints = 4,
	finalMonsterId = 3
}
local primaryKey = {
	"battleId"
}
local mlStringKey = {}

function lua_activity128_countboss.onLoad(json)
	lua_activity128_countboss.configList, lua_activity128_countboss.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_countboss
