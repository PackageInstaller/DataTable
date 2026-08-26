-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_music.lua

module("modules.configs.excel2json.lua_fight_rouge2_music", package.seeall)

local lua_fight_rouge2_music = {}
local fields = {
	id = 1,
	name = 2,
	icon1 = 3,
	icon2 = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_fight_rouge2_music.onLoad(json)
	lua_fight_rouge2_music.configList, lua_fight_rouge2_music.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_rouge2_music
