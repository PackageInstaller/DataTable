-- chunkname: @modules/configs/excel2json/lua_activity174_enhance.lua

module("modules.configs.excel2json.lua_activity174_enhance", package.seeall)

local lua_activity174_enhance = {}
local fields = {
	effects = 7,
	icon = 6,
	season = 2,
	coinValue = 8,
	id = 1,
	title = 4,
	rare = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_activity174_enhance.onLoad(json)
	lua_activity174_enhance.configList, lua_activity174_enhance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_enhance
