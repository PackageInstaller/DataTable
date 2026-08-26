-- chunkname: @modules/configs/excel2json/lua_activity203_base.lua

module("modules.configs.excel2json.lua_activity203_base", package.seeall)

local lua_activity203_base = {}
local fields = {
	dispatchInterval = 7,
	name = 2,
	initialCamp = 6,
	type = 4,
	baseId = 1,
	picture = 3,
	isHQ = 5,
	initialSoldier = 8,
	soldierRecover = 9,
	soldierLimit = 10
}
local primaryKey = {
	"baseId"
}
local mlStringKey = {}

function lua_activity203_base.onLoad(json)
	lua_activity203_base.configList, lua_activity203_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_base
