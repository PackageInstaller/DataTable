-- chunkname: @modules/configs/excel2json/lua_fight_audio.lua

module("modules.configs.excel2json.lua_fight_audio", package.seeall)

local lua_fight_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	weapon = 4,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_audio.onLoad(json)
	lua_fight_audio.configList, lua_fight_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_audio
