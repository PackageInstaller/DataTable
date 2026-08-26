-- chunkname: @modules/configs/excel2json/lua_weekwalk_type.lua

module("modules.configs.excel2json.lua_weekwalk_type", package.seeall)

local lua_weekwalk_type = {}
local fields = {
	heroCd = 2,
	isRefresh = 5,
	starNum = 7,
	type = 1,
	showDetail = 6,
	canResetLayer = 4,
	star = 3
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_weekwalk_type.onLoad(json)
	lua_weekwalk_type.configList, lua_weekwalk_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_type
