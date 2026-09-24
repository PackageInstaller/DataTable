-- chunkname: @modules/configs/excel2json/lua_activity244_gem_droprate.lua

module("modules.configs.excel2json.lua_activity244_gem_droprate", package.seeall)

local lua_activity244_gem_droprate = {}
local fields = {
	boxDropRate = 4,
	bombDropRate = 3,
	gemTemplateId = 1,
	healDropRate = 2
}
local primaryKey = {
	"gemTemplateId"
}
local mlStringKey = {}

function lua_activity244_gem_droprate.onLoad(json)
	lua_activity244_gem_droprate.configList, lua_activity244_gem_droprate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_gem_droprate
