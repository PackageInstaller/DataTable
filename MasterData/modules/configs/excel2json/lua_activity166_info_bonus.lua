-- chunkname: @modules/configs/excel2json/lua_activity166_info_bonus.lua

module("modules.configs.excel2json.lua_activity166_info_bonus", package.seeall)

local lua_activity166_info_bonus = {}
local fields = {
	analyCount = 2,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"analyCount"
}
local mlStringKey = {}

function lua_activity166_info_bonus.onLoad(json)
	lua_activity166_info_bonus.configList, lua_activity166_info_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_info_bonus
