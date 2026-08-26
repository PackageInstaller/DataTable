-- chunkname: @modules/configs/excel2json/lua_skill_next.lua

module("modules.configs.excel2json.lua_skill_next", package.seeall)

local lua_skill_next = {}
local fields = {
	id = 1,
	nextId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skill_next.onLoad(json)
	lua_skill_next.configList, lua_skill_next.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_next
