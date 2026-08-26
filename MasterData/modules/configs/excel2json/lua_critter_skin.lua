-- chunkname: @modules/configs/excel2json/lua_critter_skin.lua

module("modules.configs.excel2json.lua_critter_skin", package.seeall)

local lua_critter_skin = {}
local fields = {
	handEffects = 5,
	spine = 4,
	largeIcon = 3,
	id = 1,
	headIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_critter_skin.onLoad(json)
	lua_critter_skin.configList, lua_critter_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_skin
