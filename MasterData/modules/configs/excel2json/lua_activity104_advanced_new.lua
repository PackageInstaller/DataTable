-- chunkname: @modules/configs/excel2json/lua_activity104_advanced_new.lua

module("modules.configs.excel2json.lua_activity104_advanced_new", package.seeall)

local lua_activity104_advanced_new = {}
local fields = {
	activityId = 1,
	retailEpisodeId = 2
}
local primaryKey = {
	"activityId",
	"retailEpisodeId"
}
local mlStringKey = {}

function lua_activity104_advanced_new.onLoad(json)
	lua_activity104_advanced_new.configList, lua_activity104_advanced_new.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_advanced_new
