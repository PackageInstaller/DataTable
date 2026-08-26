-- chunkname: @modules/configs/excel2json/lua_activity145_movement.lua

module("modules.configs.excel2json.lua_activity145_movement", package.seeall)

local lua_activity145_movement = {}
local fields = {
	displayTime = 5,
	type = 2,
	id = 1,
	motion = 3,
	content = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	motion = 1
}

function lua_activity145_movement.onLoad(json)
	lua_activity145_movement.configList, lua_activity145_movement.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity145_movement
