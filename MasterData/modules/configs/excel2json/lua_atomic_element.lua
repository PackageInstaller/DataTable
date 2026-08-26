-- chunkname: @modules/configs/excel2json/lua_atomic_element.lua

module("modules.configs.excel2json.lua_atomic_element", package.seeall)

local lua_atomic_element = {}
local fields = {
	preId = 5,
	needFollow = 10,
	isPermanent = 12,
	type = 6,
	isEmergency = 13,
	unlockCondition = 4,
	pos = 8,
	warning = 14,
	dialog = 18,
	icon = 9,
	conditionType = 3,
	reward = 16,
	parm = 7,
	dataBase = 17,
	canDisappear = 11,
	mapId = 2,
	warningExpired = 15,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_atomic_element.onLoad(json)
	lua_atomic_element.configList, lua_atomic_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_element
