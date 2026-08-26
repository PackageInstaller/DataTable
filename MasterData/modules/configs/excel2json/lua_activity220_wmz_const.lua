-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_const.lua

module("modules.configs.excel2json.lua_activity220_wmz_const", package.seeall)

local lua_activity220_wmz_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_wmz_const.onLoad(json)
	lua_activity220_wmz_const.configList, lua_activity220_wmz_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_const
