-- chunkname: @modules/configs/excel2json/lua_summon.lua

module("modules.configs.excel2json.lua_summon", package.seeall)

local lua_summon = {}
local fields = {
	id = 1,
	summonId = 3,
	rare = 2,
	luckyBagId = 4
}
local primaryKey = {
	"id",
	"rare"
}
local mlStringKey = {}

function lua_summon.onLoad(json)
	lua_summon.configList, lua_summon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon
