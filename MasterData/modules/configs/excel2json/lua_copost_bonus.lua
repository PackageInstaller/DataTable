-- chunkname: @modules/configs/excel2json/lua_copost_bonus.lua

module("modules.configs.excel2json.lua_copost_bonus", package.seeall)

local lua_copost_bonus = {}
local fields = {
	isBig = 5,
	versionId = 4,
	pointNum = 3,
	id = 1,
	bonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_bonus.onLoad(json)
	lua_copost_bonus.configList, lua_copost_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_bonus
