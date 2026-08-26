-- chunkname: @modules/configs/excel2json/lua_activity166_base_level.lua

module("modules.configs.excel2json.lua_activity166_base_level", package.seeall)

local lua_activity166_base_level = {}
local fields = {
	baseId = 2,
	firstBonus = 4,
	activityId = 1,
	level = 3
}
local primaryKey = {
	"activityId",
	"baseId",
	"level"
}
local mlStringKey = {}

function lua_activity166_base_level.onLoad(json)
	lua_activity166_base_level.configList, lua_activity166_base_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_base_level
