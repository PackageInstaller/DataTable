-- chunkname: @modules/configs/excel2json/lua_critter_patience_change.lua

module("modules.configs.excel2json.lua_critter_patience_change", package.seeall)

local lua_critter_patience_change = {}
local fields = {
	stepValue = 3,
	stepTime = 2,
	buildingType = 1
}
local primaryKey = {
	"buildingType"
}
local mlStringKey = {}

function lua_critter_patience_change.onLoad(json)
	lua_critter_patience_change.configList, lua_critter_patience_change.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_patience_change
