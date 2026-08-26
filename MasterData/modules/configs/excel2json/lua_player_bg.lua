-- chunkname: @modules/configs/excel2json/lua_player_bg.lua

module("modules.configs.excel2json.lua_player_bg", package.seeall)

local lua_player_bg = {}
local fields = {
	bg = 6,
	name = 2,
	item = 4,
	chatbg = 8,
	bgEffect = 7,
	desc = 3,
	infobg = 9,
	id = 1,
	lockdesc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lockdesc = 3,
	name = 1,
	desc = 2
}

function lua_player_bg.onLoad(json)
	lua_player_bg.configList, lua_player_bg.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_player_bg
