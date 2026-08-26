-- chunkname: @modules/configs/excel2json/lua_editor_skill_tag.lua

module("modules.configs.excel2json.lua_editor_skill_tag", package.seeall)

local lua_editor_skill_tag = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_editor_skill_tag.onLoad(json)
	lua_editor_skill_tag.configList, lua_editor_skill_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_editor_skill_tag
