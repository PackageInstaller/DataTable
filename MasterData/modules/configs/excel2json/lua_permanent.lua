-- chunkname: @modules/configs/excel2json/lua_permanent.lua

module("modules.configs.excel2json.lua_permanent", package.seeall)

local lua_permanent = {}
local fields = {
	id = 1,
	enterview = 3,
	kvIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_permanent.onLoad(json)
	lua_permanent.configList, lua_permanent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_permanent
