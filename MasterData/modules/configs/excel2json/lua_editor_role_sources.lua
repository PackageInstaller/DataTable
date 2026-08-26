-- chunkname: @modules/configs/excel2json/lua_editor_role_sources.lua

module("modules.configs.excel2json.lua_editor_role_sources", package.seeall)

local lua_editor_role_sources = {}
local fields = {
	id = 1,
	name = 3,
	exSkill = 4,
	skinId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_editor_role_sources.onLoad(json)
	lua_editor_role_sources.configList, lua_editor_role_sources.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_editor_role_sources
