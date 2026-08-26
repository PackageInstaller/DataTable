-- chunkname: @modules/configs/excel2json/lua_udimo_lock_mode_setting.lua

module("modules.configs.excel2json.lua_udimo_lock_mode_setting", package.seeall)

local lua_udimo_lock_mode_setting = {}
local fields = {
	id = 1,
	name = 2,
	isDefault = 4,
	waitTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_udimo_lock_mode_setting.onLoad(json)
	lua_udimo_lock_mode_setting.configList, lua_udimo_lock_mode_setting.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_lock_mode_setting
