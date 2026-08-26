-- chunkname: @modules/configs/excel2json/lua_weekwalk_pray.lua

module("modules.configs.excel2json.lua_weekwalk_pray", package.seeall)

local lua_weekwalk_pray = {}
local fields = {
	sacrificeLimit = 2,
	effect = 4,
	blessingLimit = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_pray.onLoad(json)
	lua_weekwalk_pray.configList, lua_weekwalk_pray.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_pray
