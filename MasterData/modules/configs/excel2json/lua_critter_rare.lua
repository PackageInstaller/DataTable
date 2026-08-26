-- chunkname: @modules/configs/excel2json/lua_critter_rare.lua

module("modules.configs.excel2json.lua_critter_rare", package.seeall)

local lua_critter_rare = {}
local fields = {
	cardRes = 2,
	incubateCost = 4,
	rare = 1,
	eggRes = 3
}
local primaryKey = {
	"rare"
}
local mlStringKey = {}

function lua_critter_rare.onLoad(json)
	lua_critter_rare.configList, lua_critter_rare.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_rare
