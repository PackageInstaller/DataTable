-- chunkname: @modules/configs/excel2json/lua_bossrush_skin_effect.lua

module("modules.configs.excel2json.lua_bossrush_skin_effect", package.seeall)

local lua_bossrush_skin_effect = {}
local fields = {
	effects = 3,
	scales = 5,
	id = 1,
	stage = 2,
	hangpoints = 4
}
local primaryKey = {
	"id",
	"stage"
}
local mlStringKey = {}

function lua_bossrush_skin_effect.onLoad(json)
	lua_bossrush_skin_effect.configList, lua_bossrush_skin_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bossrush_skin_effect
