-- chunkname: @modules/configs/excel2json/lua_arcade_talent_icon.lua

module("modules.configs.excel2json.lua_arcade_talent_icon", package.seeall)

local lua_arcade_talent_icon = {}
local fields = {
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_talent_icon.onLoad(json)
	lua_arcade_talent_icon.configList, lua_arcade_talent_icon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_talent_icon
