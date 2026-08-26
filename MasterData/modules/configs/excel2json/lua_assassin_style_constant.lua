-- chunkname: @modules/configs/excel2json/lua_assassin_style_constant.lua

module("modules.configs.excel2json.lua_assassin_style_constant", package.seeall)

local lua_assassin_style_constant = {}
local fields = {
	id = 1,
	constant = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_style_constant.onLoad(json)
	lua_assassin_style_constant.configList, lua_assassin_style_constant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_style_constant
