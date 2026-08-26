-- chunkname: @modules/configs/excel2json/lua_fight_she_fa_ignite.lua

module("modules.configs.excel2json.lua_fight_she_fa_ignite", package.seeall)

local lua_fight_she_fa_ignite = {}
local fields = {
	id = 1,
	timeline = 3,
	layer = 2
}
local primaryKey = {
	"id",
	"layer"
}
local mlStringKey = {}

function lua_fight_she_fa_ignite.onLoad(json)
	lua_fight_she_fa_ignite.configList, lua_fight_she_fa_ignite.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_she_fa_ignite
