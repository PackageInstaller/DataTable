-- chunkname: @modules/configs/excel2json/lua_stance.lua

module("modules.configs.excel2json.lua_stance", package.seeall)

local lua_stance = {}
local fields = {
	pos8 = 9,
	pos1 = 2,
	subPos1 = 10,
	pos5 = 6,
	subPos2 = 11,
	subPos3 = 12,
	pos4 = 5,
	dec_stance = 13,
	pos3 = 4,
	cardCamera = 14,
	pos7 = 8,
	pos2 = 3,
	id = 1,
	pos6 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_stance.onLoad(json)
	lua_stance.configList, lua_stance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stance
