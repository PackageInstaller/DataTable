-- chunkname: @modules/configs/excel2json/lua_turnback_sp_h5_roletype.lua

module("modules.configs.excel2json.lua_turnback_sp_h5_roletype", package.seeall)

local lua_turnback_sp_h5_roletype = {}
local fields = {
	id = 1,
	name = 2,
	nameHexColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_turnback_sp_h5_roletype.onLoad(json)
	lua_turnback_sp_h5_roletype.configList, lua_turnback_sp_h5_roletype.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_sp_h5_roletype
