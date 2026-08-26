-- chunkname: @modules/configs/excel2json/lua_odyssey_const.lua

module("modules.configs.excel2json.lua_odyssey_const", package.seeall)

local lua_odyssey_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_odyssey_const.onLoad(json)
	lua_odyssey_const.configList, lua_odyssey_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_const
