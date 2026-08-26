-- chunkname: @modules/configs/excel2json/lua_turnback_sp_h5.lua

module("modules.configs.excel2json.lua_turnback_sp_h5", package.seeall)

local lua_turnback_sp_h5 = {}
local fields = {
	type2BindCount = 2,
	asNewUserTime = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_turnback_sp_h5.onLoad(json)
	lua_turnback_sp_h5.configList, lua_turnback_sp_h5.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_sp_h5
