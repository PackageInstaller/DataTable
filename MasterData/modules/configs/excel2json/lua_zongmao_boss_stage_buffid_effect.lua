-- chunkname: @modules/configs/excel2json/lua_zongmao_boss_stage_buffid_effect.lua

module("modules.configs.excel2json.lua_zongmao_boss_stage_buffid_effect", package.seeall)

local lua_zongmao_boss_stage_buffid_effect = {}
local fields = {
	effects = 3,
	buffId = 2,
	id = 1,
	scales = 5,
	hangpoints = 4
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_zongmao_boss_stage_buffid_effect.onLoad(json)
	lua_zongmao_boss_stage_buffid_effect.configList, lua_zongmao_boss_stage_buffid_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_zongmao_boss_stage_buffid_effect
