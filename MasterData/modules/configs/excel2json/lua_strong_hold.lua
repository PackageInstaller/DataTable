-- chunkname: @modules/configs/excel2json/lua_strong_hold.lua

module("modules.configs.excel2json.lua_strong_hold", package.seeall)

local lua_strong_hold = {}
local fields = {
	ruleId = 7,
	name = 2,
	eliminateBg = 3,
	id = 1,
	strongholdBg = 4,
	friendCapacity = 6,
	enemyCapacity = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_strong_hold.onLoad(json)
	lua_strong_hold.configList, lua_strong_hold.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_strong_hold
