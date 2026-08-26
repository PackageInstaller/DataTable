-- chunkname: @modules/configs/excel2json/lua_skin_ui_bloom.lua

module("modules.configs.excel2json.lua_skin_ui_bloom", package.seeall)

local lua_skin_ui_bloom = {}
local fields = {
	id = 1,
	view_CharacterDataView = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_ui_bloom.onLoad(json)
	lua_skin_ui_bloom.configList, lua_skin_ui_bloom.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_ui_bloom
