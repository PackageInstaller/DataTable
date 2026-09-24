-- chunkname: @modules/configs/excel2json/lua_role_badge_group.lua

module("modules.configs.excel2json.lua_role_badge_group", package.seeall)

local lua_role_badge_group = {}
local fields = {
	id = 1,
	groupTitle = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_role_badge_group.onLoad(json)
	lua_role_badge_group.configList, lua_role_badge_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_role_badge_group
