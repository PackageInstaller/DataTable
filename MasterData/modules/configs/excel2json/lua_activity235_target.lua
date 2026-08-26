-- chunkname: @modules/configs/excel2json/lua_activity235_target.lua

module("modules.configs.excel2json.lua_activity235_target", package.seeall)

local lua_activity235_target = {}
local fields = {
	hitDisappearDelay = 10,
	disappearTime = 8,
	hitRadius = 13,
	prefab = 3,
	name = 2,
	maxShowNum = 11,
	id = 1,
	disappearDealy = 9,
	firstShowNum = 12,
	afterScore = 6,
	appearTime = 7,
	firstScore = 5,
	weight = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity235_target.onLoad(json)
	lua_activity235_target.configList, lua_activity235_target.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity235_target
