-- chunkname: @modules/configs/excel2json/lua_weekwalk_level.lua

module("modules.configs.excel2json.lua_weekwalk_level", package.seeall)

local lua_weekwalk_level = {}
local fields = {
	id = 1,
	bonus = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_weekwalk_level.onLoad(json)
	lua_weekwalk_level.configList, lua_weekwalk_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_level
