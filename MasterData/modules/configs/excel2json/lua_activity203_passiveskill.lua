-- chunkname: @modules/configs/excel2json/lua_activity203_passiveskill.lua

module("modules.configs.excel2json.lua_activity203_passiveskill", package.seeall)

local lua_activity203_passiveskill = {}
local fields = {
	description = 3,
	passive_skillid = 1,
	name = 2,
	effect = 4
}
local primaryKey = {
	"passive_skillid"
}
local mlStringKey = {}

function lua_activity203_passiveskill.onLoad(json)
	lua_activity203_passiveskill.configList, lua_activity203_passiveskill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_passiveskill
