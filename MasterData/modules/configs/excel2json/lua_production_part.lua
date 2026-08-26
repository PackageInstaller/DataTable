-- chunkname: @modules/configs/excel2json/lua_production_part.lua

module("modules.configs.excel2json.lua_production_part", package.seeall)

local lua_production_part = {}
local fields = {
	productionLines = 4,
	name = 2,
	audio = 6,
	cameraParam = 5,
	id = 1,
	changeAudio = 7,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_production_part.onLoad(json)
	lua_production_part.configList, lua_production_part.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_production_part
