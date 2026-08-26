-- chunkname: @modules/configs/excel2json/lua_survival_handbook.lua

module("modules.configs.excel2json.lua_survival_handbook", package.seeall)

local lua_survival_handbook = {}
local fields = {
	subtype = 3,
	name = 4,
	roleId = 8,
	type = 2,
	id = 1,
	eventId = 7,
	link = 5,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_handbook.onLoad(json)
	lua_survival_handbook.configList, lua_survival_handbook.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_handbook
