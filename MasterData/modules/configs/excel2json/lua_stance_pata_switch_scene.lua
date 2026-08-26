-- chunkname: @modules/configs/excel2json/lua_stance_pata_switch_scene.lua

module("modules.configs.excel2json.lua_stance_pata_switch_scene", package.seeall)

local lua_stance_pata_switch_scene = {}
local fields = {
	sceneId = 1,
	enemyStanceId = 3,
	myStanceId = 2
}
local primaryKey = {
	"sceneId"
}
local mlStringKey = {}

function lua_stance_pata_switch_scene.onLoad(json)
	lua_stance_pata_switch_scene.configList, lua_stance_pata_switch_scene.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stance_pata_switch_scene
