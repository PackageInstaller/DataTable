-- chunkname: @modules/configs/excel2json/lua_talent_mould.lua

module("modules.configs.excel2json.lua_talent_mould", package.seeall)

local lua_talent_mould = {}
local fields = {
	type11 = 5,
	type19 = 13,
	talentMould = 2,
	type14 = 8,
	type12 = 6,
	type17 = 11,
	type15 = 9,
	type20 = 14,
	type10 = 4,
	type13 = 7,
	type18 = 12,
	allShape = 3,
	talentId = 1,
	type16 = 10
}
local primaryKey = {
	"talentId",
	"talentMould"
}
local mlStringKey = {}

function lua_talent_mould.onLoad(json)
	lua_talent_mould.configList, lua_talent_mould.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_mould
