-- chunkname: @modules/configs/excel2json/lua_fight_debut_show.lua

module("modules.configs.excel2json.lua_fight_debut_show", package.seeall)

local lua_fight_debut_show = {}
local fields = {
	audioId = 5,
	effect = 2,
	skinId = 1,
	effectHangPoint = 3,
	effectTime = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_debut_show.onLoad(json)
	lua_fight_debut_show.configList, lua_fight_debut_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_debut_show
