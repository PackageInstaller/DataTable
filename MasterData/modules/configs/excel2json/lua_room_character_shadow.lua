-- chunkname: @modules/configs/excel2json/lua_room_character_shadow.lua

module("modules.configs.excel2json.lua_room_character_shadow", package.seeall)

local lua_room_character_shadow = {}
local fields = {
	animName = 2,
	shadow = 3,
	skinId = 1
}
local primaryKey = {
	"skinId",
	"animName"
}
local mlStringKey = {}

function lua_room_character_shadow.onLoad(json)
	lua_room_character_shadow.configList, lua_room_character_shadow.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_shadow
