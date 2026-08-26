-- chunkname: @modules/configs/excel2json/lua_activity159_critter.lua

module("modules.configs.excel2json.lua_activity159_critter", package.seeall)

local lua_activity159_critter = {}
local fields = {
	name = 1,
	startPos = 4,
	res = 2,
	anim = 3,
	scale = 5
}
local primaryKey = {
	"name"
}
local mlStringKey = {}

function lua_activity159_critter.onLoad(json)
	lua_activity159_critter.configList, lua_activity159_critter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity159_critter
