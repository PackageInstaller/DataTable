-- chunkname: @modules/configs/excel2json/lua_survival_level.lua

module("modules.configs.excel2json.lua_survival_level", package.seeall)

local lua_survival_level = {}
local fields = {
	id = 1,
	exp = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_level.onLoad(json)
	lua_survival_level.configList, lua_survival_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_level
