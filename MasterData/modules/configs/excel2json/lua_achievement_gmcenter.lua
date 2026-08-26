-- chunkname: @modules/configs/excel2json/lua_achievement_gmcenter.lua

module("modules.configs.excel2json.lua_achievement_gmcenter", package.seeall)

local lua_achievement_gmcenter = {}
local fields = {
	id = 1,
	achievementId = 3,
	category = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_achievement_gmcenter.onLoad(json)
	lua_achievement_gmcenter.configList, lua_achievement_gmcenter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_achievement_gmcenter
