-- chunkname: @modules/configs/excel2json/lua_atomic_key_element.lua

module("modules.configs.excel2json.lua_atomic_key_element", package.seeall)

local lua_atomic_key_element = {}
local fields = {
	preId = 4,
	doorIdList = 5,
	parm = 7,
	type = 6,
	needFollow = 10,
	unlockCondition = 3,
	pos = 8,
	desc = 12,
	title = 11,
	mapId = 2,
	canClick = 13,
	id = 1,
	icon = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_key_element.onLoad(json)
	lua_atomic_key_element.configList, lua_atomic_key_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_key_element
