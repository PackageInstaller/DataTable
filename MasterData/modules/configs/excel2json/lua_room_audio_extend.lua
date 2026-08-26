-- chunkname: @modules/configs/excel2json/lua_room_audio_extend.lua

module("modules.configs.excel2json.lua_room_audio_extend", package.seeall)

local lua_room_audio_extend = {}
local fields = {
	audioId = 2,
	rtpcValue = 6,
	rtpc = 5,
	switchGroup = 3,
	id = 1,
	switchState = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_audio_extend.onLoad(json)
	lua_room_audio_extend.configList, lua_room_audio_extend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_audio_extend
