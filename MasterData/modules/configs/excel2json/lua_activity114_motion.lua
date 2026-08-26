-- chunkname: @modules/configs/excel2json/lua_activity114_motion.lua

module("modules.configs.excel2json.lua_activity114_motion", package.seeall)

local lua_activity114_motion = {}
local fields = {
	param = 3,
	face = 5,
	type = 2,
	id = 1,
	motion = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	face = 1
}

function lua_activity114_motion.onLoad(json)
	lua_activity114_motion.configList, lua_activity114_motion.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_motion
