-- chunkname: @modules/configs/excel2json/lua_activity132_collect.lua

module("modules.configs.excel2json.lua_activity132_collect", package.seeall)

local lua_activity132_collect = {}
local fields = {
	nameEn = 6,
	name = 3,
	collectId = 2,
	bg = 4,
	activityId = 1,
	clues = 5
}
local primaryKey = {
	"activityId",
	"collectId"
}
local mlStringKey = {
	name = 1
}

function lua_activity132_collect.onLoad(json)
	lua_activity132_collect.configList, lua_activity132_collect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity132_collect
