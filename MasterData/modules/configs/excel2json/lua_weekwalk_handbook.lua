-- chunkname: @modules/configs/excel2json/lua_weekwalk_handbook.lua

module("modules.configs.excel2json.lua_weekwalk_handbook", package.seeall)

local lua_weekwalk_handbook = {}
local fields = {
	text = 6,
	positionOffset = 5,
	type = 3,
	id = 1,
	position = 4,
	branchId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_handbook.onLoad(json)
	lua_weekwalk_handbook.configList, lua_weekwalk_handbook.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_handbook
