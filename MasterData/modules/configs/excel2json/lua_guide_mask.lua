-- chunkname: @modules/configs/excel2json/lua_guide_mask.lua

module("modules.configs.excel2json.lua_guide_mask", package.seeall)

local lua_guide_mask = {}
local fields = {
	uiOffset1 = 2,
	uiInfo1 = 3,
	uiOffset2 = 5,
	id = 1,
	goPath1 = 4,
	goPath4 = 13,
	uiInfo3 = 9,
	uiInfo4 = 12,
	goPath3 = 10,
	goPath2 = 7,
	uiInfo2 = 6,
	uiOffset3 = 8,
	uiOffset4 = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_guide_mask.onLoad(json)
	lua_guide_mask.configList, lua_guide_mask.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_guide_mask
