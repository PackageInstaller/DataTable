-- chunkname: @modules/configs/excel2json/lua_activity132_content.lua

module("modules.configs.excel2json.lua_activity132_content", package.seeall)

local lua_activity132_content = {}
local fields = {
	content = 3,
	activityId = 1,
	contentId = 2,
	unlockDesc = 5,
	condition = 4
}
local primaryKey = {
	"activityId",
	"contentId"
}
local mlStringKey = {
	content = 1,
	unlockDesc = 2
}

function lua_activity132_content.onLoad(json)
	lua_activity132_content.configList, lua_activity132_content.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity132_content
