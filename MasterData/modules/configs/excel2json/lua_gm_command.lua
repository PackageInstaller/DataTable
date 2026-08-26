-- chunkname: @modules/configs/excel2json/lua_gm_command.lua

module("modules.configs.excel2json.lua_gm_command", package.seeall)

local lua_gm_command = {}
local fields = {
	id = 1,
	name = 3,
	command = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_gm_command.onLoad(json)
	lua_gm_command.configList, lua_gm_command.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_gm_command
