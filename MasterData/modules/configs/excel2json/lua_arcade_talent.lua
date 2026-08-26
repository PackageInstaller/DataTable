-- chunkname: @modules/configs/excel2json/lua_arcade_talent.lua

module("modules.configs.excel2json.lua_arcade_talent", package.seeall)

local lua_arcade_talent = {}
local fields = {
	cost = 3,
	name = 4,
	skill = 6,
	displayType = 5,
	id = 1,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}

function lua_arcade_talent.onLoad(json)
	lua_arcade_talent.configList, lua_arcade_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_talent
