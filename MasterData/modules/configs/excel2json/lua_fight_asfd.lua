-- chunkname: @modules/configs/excel2json/lua_fight_asfd.lua

module("modules.configs.excel2json.lua_fight_asfd", package.seeall)

local lua_fight_asfd = {}
local fields = {
	replaceRule = 3,
	priority = 10,
	sampleMinHeight = 8,
	audio = 6,
	res = 4,
	sceneEmitterId = 5,
	id = 1,
	unit = 2,
	scale = 7,
	flyPath = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_asfd.onLoad(json)
	lua_fight_asfd.configList, lua_fight_asfd.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_asfd
