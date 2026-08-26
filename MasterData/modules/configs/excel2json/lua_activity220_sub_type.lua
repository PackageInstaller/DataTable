-- chunkname: @modules/configs/excel2json/lua_activity220_sub_type.lua

module("modules.configs.excel2json.lua_activity220_sub_type", package.seeall)

local lua_activity220_sub_type = {}
local fields = {
	jumpId = 4,
	subType = 2,
	activityId = 1,
	reddotId = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity220_sub_type.onLoad(json)
	lua_activity220_sub_type.configList, lua_activity220_sub_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_sub_type
