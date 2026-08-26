-- chunkname: @modules/configs/excel2json/lua_storydialogfade.lua

module("modules.configs.excel2json.lua_storydialogfade", package.seeall)

local lua_storydialogfade = {}
local fields = {
	id = 1,
	skipvideo = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_storydialogfade.onLoad(json)
	lua_storydialogfade.configList, lua_storydialogfade.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_storydialogfade
