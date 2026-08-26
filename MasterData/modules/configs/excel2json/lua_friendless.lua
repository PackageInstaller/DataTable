-- chunkname: @modules/configs/excel2json/lua_friendless.lua

module("modules.configs.excel2json.lua_friendless", package.seeall)

local lua_friendless = {}
local fields = {
	friendliness = 2,
	percentage = 1
}
local primaryKey = {
	"percentage"
}
local mlStringKey = {}

function lua_friendless.onLoad(json)
	lua_friendless.configList, lua_friendless.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_friendless
