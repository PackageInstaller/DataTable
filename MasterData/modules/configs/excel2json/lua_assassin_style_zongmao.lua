-- chunkname: @modules/configs/excel2json/lua_assassin_style_zongmao.lua

module("modules.configs.excel2json.lua_assassin_style_zongmao", package.seeall)

local lua_assassin_style_zongmao = {}
local fields = {
	itemId = 1,
	number = 2
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {}

function lua_assassin_style_zongmao.onLoad(json)
	lua_assassin_style_zongmao.configList, lua_assassin_style_zongmao.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_style_zongmao
