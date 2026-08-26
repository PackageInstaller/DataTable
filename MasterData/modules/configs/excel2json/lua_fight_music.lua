-- chunkname: @modules/configs/excel2json/lua_fight_music.lua

module("modules.configs.excel2json.lua_fight_music", package.seeall)

local lua_fight_music = {}
local fields = {
	param = 5,
	battleId = 2,
	monster = 3,
	switch = 6,
	id = 1,
	invokeType = 4
}
local primaryKey = {
	"id",
	"battleId",
	"monster",
	"invokeType",
	"param"
}
local mlStringKey = {}

function lua_fight_music.onLoad(json)
	lua_fight_music.configList, lua_fight_music.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_music
