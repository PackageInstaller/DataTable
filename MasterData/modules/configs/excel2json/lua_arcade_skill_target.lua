-- chunkname: @modules/configs/excel2json/lua_arcade_skill_target.lua

module("modules.configs.excel2json.lua_arcade_skill_target", package.seeall)

local lua_arcade_skill_target = {}
local fields = {
	ignoreSelf = 4,
	effect = 5,
	targets = 3,
	clztype = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_skill_target.onLoad(json)
	lua_arcade_skill_target.configList, lua_arcade_skill_target.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_skill_target
