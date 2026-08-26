-- chunkname: @modules/configs/excel2json/lua_assassin_trap.lua

module("modules.configs.excel2json.lua_assassin_trap", package.seeall)

local lua_assassin_trap = {}
local fields = {
	effectId = 5,
	effect = 3,
	type = 2,
	trapId = 1,
	duration = 4
}
local primaryKey = {
	"trapId"
}
local mlStringKey = {}

function lua_assassin_trap.onLoad(json)
	lua_assassin_trap.configList, lua_assassin_trap.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_trap
