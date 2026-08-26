-- chunkname: @modules/configs/excel2json/lua_device_power.lua

module("modules.configs.excel2json.lua_device_power", package.seeall)

local lua_device_power = {}
local fields = {
	powerIcon = 3,
	powerType = 1,
	powerNum = 2
}
local primaryKey = {
	"powerType",
	"powerNum"
}
local mlStringKey = {}

function lua_device_power.onLoad(json)
	lua_device_power.configList, lua_device_power.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_device_power
