-- chunkname: @modules/configs/excel2json/lua_tower_compose_boss_lv.lua

module("modules.configs.excel2json.lua_tower_compose_boss_lv", package.seeall)

local lua_tower_compose_boss_lv = {}
local fields = {
	levelReq = 3,
	templateChange = 4,
	level = 2,
	episodeId = 1
}
local primaryKey = {
	"episodeId",
	"level"
}
local mlStringKey = {}

function lua_tower_compose_boss_lv.onLoad(json)
	lua_tower_compose_boss_lv.configList, lua_tower_compose_boss_lv.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_boss_lv
