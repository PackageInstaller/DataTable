-- chunkname: @modules/configs/excel2json/lua_activity128_assess.lua

module("modules.configs.excel2json.lua_activity128_assess", package.seeall)

local lua_activity128_assess = {}
local fields = {
	spriteName = 3,
	needPointBoss1 = 4,
	mainBg = 8,
	needPointBoss2 = 5,
	layer4Assess = 9,
	battleIconBg = 7,
	strLevel = 2,
	needPointBoss3 = 6,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_activity128_assess.onLoad(json)
	lua_activity128_assess.configList, lua_activity128_assess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_assess
