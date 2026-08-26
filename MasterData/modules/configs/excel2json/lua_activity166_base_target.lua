-- chunkname: @modules/configs/excel2json/lua_activity166_base_target.lua

module("modules.configs.excel2json.lua_activity166_base_target", package.seeall)

local lua_activity166_base_target = {}
local fields = {
	score = 6,
	targetParam = 5,
	targetType = 4,
	targetId = 3,
	baseId = 2,
	targetDesc = 7,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"baseId",
	"targetId"
}
local mlStringKey = {
	targetDesc = 1
}

function lua_activity166_base_target.onLoad(json)
	lua_activity166_base_target.configList, lua_activity166_base_target.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_base_target
