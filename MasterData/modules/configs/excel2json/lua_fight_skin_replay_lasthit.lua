-- chunkname: @modules/configs/excel2json/lua_fight_skin_replay_lasthit.lua

module("modules.configs.excel2json.lua_fight_skin_replay_lasthit", package.seeall)

local lua_fight_skin_replay_lasthit = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_skin_replay_lasthit.onLoad(json)
	lua_fight_skin_replay_lasthit.configList, lua_fight_skin_replay_lasthit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skin_replay_lasthit
