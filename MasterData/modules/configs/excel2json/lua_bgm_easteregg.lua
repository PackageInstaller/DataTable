-- chunkname: @modules/configs/excel2json/lua_bgm_easteregg.lua

module("modules.configs.excel2json.lua_bgm_easteregg", package.seeall)

local lua_bgm_easteregg = {}
local fields = {
	param1 = 3,
	param2 = 4,
	type = 2,
	id = 1,
	param4 = 6,
	param3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_bgm_easteregg.onLoad(json)
	lua_bgm_easteregg.configList, lua_bgm_easteregg.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bgm_easteregg
