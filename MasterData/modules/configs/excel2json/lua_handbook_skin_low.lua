-- chunkname: @modules/configs/excel2json/lua_handbook_skin_low.lua

module("modules.configs.excel2json.lua_handbook_skin_low", package.seeall)

local lua_handbook_skin_low = {}
local fields = {
	backImg = 8,
	name = 2,
	des = 6,
	includeSuit = 12,
	spineParams = 9,
	tarotCardPath = 10,
	festivalParams = 11,
	show = 5,
	skinContain = 7,
	highId = 4,
	id = 1,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_handbook_skin_low.onLoad(json)
	lua_handbook_skin_low.configList, lua_handbook_skin_low.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_skin_low
