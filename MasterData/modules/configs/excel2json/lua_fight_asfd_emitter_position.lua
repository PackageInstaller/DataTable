-- chunkname: @modules/configs/excel2json/lua_fight_asfd_emitter_position.lua

module("modules.configs.excel2json.lua_fight_asfd_emitter_position", package.seeall)

local lua_fight_asfd_emitter_position = {}
local fields = {
	sceneId = 1,
	enemySidePos = 4,
	emitterId = 2,
	mySidePos = 3
}
local primaryKey = {
	"sceneId",
	"emitterId"
}
local mlStringKey = {}

function lua_fight_asfd_emitter_position.onLoad(json)
	lua_fight_asfd_emitter_position.configList, lua_fight_asfd_emitter_position.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_asfd_emitter_position
